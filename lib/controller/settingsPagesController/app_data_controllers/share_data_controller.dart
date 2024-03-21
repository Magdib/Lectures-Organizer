import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:archive/archive_io.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:unversityapp/core/Constant/arguments_names.dart';
import 'package:unversityapp/core/class/app_toasts.dart';
import 'package:unversityapp/core/class/enums/share_data_state.dart';
import 'package:unversityapp/model/HiveAdaptersModels/NormalUseModels/LecturesAdapter.dart';
import 'package:unversityapp/model/HiveAdaptersModels/NormalUseModels/SubjectsAdapter.dart';

class ShareDataController extends GetxController {
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  late Box<SubjectsPageModel> subjectBox;
  late Box<LecturesPageModel> lecturesBox;
  bool isReceiver = Get.arguments[ArgumentsNames.isReceiver];
  final String userName = Hive.box(HiveBoxes.userDataBox).get(HiveKeys.name);
  final Strategy strategy = Strategy.P2P_STAR;
  Map<String, ConnectionInfo> endpointMap = {};
  String endPointId = "";
  String? tempFileUri; //reference to the file currently being transferred
  Map<int, String> map = {}; //store filename mapped to corresponding payloadId
  double sendedMG = 0;
  double totalMG = 0;
  late File receivedFile;
  late ShareDataState shareDataState;
  openNeededBoxes() async {
    subjectBox = await Hive.openBox<SubjectsPageModel>(HiveBoxes.subjectsBox);
    lecturesBox = await Hive.openBox<LecturesPageModel>(HiveBoxes.lecturesBox);
  }

  startDiscovery() async {
    log("start Discovery");
    shareDataState = ShareDataState.searchingSend;
    update();
    try {
      log(userName);
      await Nearby().startDiscovery(userName, strategy,
          onEndpointFound: (id, name, serviceId) {
        log("Found End Point");
        Nearby().requestConnection(
          userName,
          id,
          onConnectionInitiated: (id, info) {
            onConnectionInit(id, info);
          },
          onConnectionResult: (id, status) {
            switch (status) {
              case Status.CONNECTED:
                AppToasts.successToast("تم الإتصال بنجاح");
                break;

              case Status.REJECTED:
                AppToasts.showErrorToast("تم رفض الإتصال من قبل الجهاز الآخر");
                Get.back();
                break;
              default:
                AppToasts.showErrorToast("حدث خطأ ما!");
                Get.back();
            }
          },
          onDisconnected: (id) {},
        );
        stopDiscovery();
      }, onEndpointLost: (String? endpointId) {
        startDiscovery();
        shareDataState = ShareDataState.searchingSend;
      });
    } catch (e) {
      log("$e");
      AppToasts.showErrorToast("حدث خطأ ما!");
      Get.back();
    }
  }

  startAdvertising() async {
    log("start Advertising");
    shareDataState = ShareDataState.searchingReceive;
    update();
    try {
      await Nearby().startAdvertising(
        userName,
        strategy,
        onConnectionInitiated: onConnectionInit,
        onConnectionResult: (id, status) {
          switch (status) {
            case Status.CONNECTED:
              AppToasts.successToast("تم الإتصال بنجاح");
              stopAdvertising();
              break;

            case Status.REJECTED:
              AppToasts.showErrorToast("تم رفض الإتصال من قبل الجهاز الآخر");
              Get.back();
              break;
            default:
              AppToasts.showErrorToast("حدث خطأ ما!");
              Get.back();
          }
        },
        onDisconnected: (id) {
          if (shareDataState != ShareDataState.unPacking) {
            startAdvertising();
          }
        },
      );
    } catch (exception) {
      log(exception.toString());
      AppToasts.showErrorToast("حدث خطأ ما!");
      Get.back();
    }
  }

  stopAdvertising() async {
    await Nearby().stopAdvertising();
  }

  Future<bool> moveFile(String uri, String fileName) async {
    String parentDir = (await getExternalStorageDirectory())!.absolute.path;
    final b =
        await Nearby().copyFileAndDeleteOriginal(uri, '$parentDir/$fileName');
    receivedFile = File('$parentDir/$fileName');
    return b;
  }

  sendFile() async {
    for (MapEntry<String, ConnectionInfo> m in endpointMap.entries) {
      int payloadId = await Nearby().sendFilePayload(m.key, tempFileUri!);
      Nearby().sendBytesPayload(
          m.key,
          Uint8List.fromList(
              "$payloadId:${tempFileUri!.split('/').last}".codeUnits));
    }
  }

  Future<void> onConnectionInit(String id, ConnectionInfo info) async {
    endpointMap[id] = info;
    endPointId = id;
    log("onConnectionInit");
    shareDataState = ShareDataState.transfer;
    update();
    await Nearby().acceptConnection(
      id,
      onPayLoadRecieved: (endid, payload) async {
        if (payload.uri != null) {
          tempFileUri = payload.uri;
        }
      },
      onPayloadTransferUpdate: (endid, payloadTransferUpdate) async {
        if (payloadTransferUpdate.status == PayloadStatus.IN_PROGRESS) {
          sendedMG = double.parse(
              (payloadTransferUpdate.bytesTransferred / 1024 / 1024)
                  .toStringAsFixed(2));
          if (totalMG == 0) {
            totalMG = double.parse(
                (payloadTransferUpdate.totalBytes / 1024 / 1024)
                    .toStringAsFixed(2));
          }
          update();
          if (totalMG == sendedMG) {
            if (isReceiver) {
              String name = "data.zip";
              await moveFile(tempFileUri!, name);
              shareDataState = ShareDataState.unPacking;
              update();
              await extractArchiveData();
            } else {
              await Future.delayed(const Duration(seconds: 5));
              AppToasts.successToast("تم إرسال الملف بنجاح!");
              Directory cachDir = await getTemporaryDirectory();
              await cachDir.delete(recursive: true);
              Get.back();
            }
          }
        } else if (payloadTransferUpdate.status == PayloadStatus.FAILURE) {
          AppToasts.showErrorToast("حدث خطأ ما");
          if (!isReceiver) {
            shareDataState = ShareDataState.failureSend;
          }
          update();
        } else if (payloadTransferUpdate.status == PayloadStatus.SUCCESS) {
          if (map.containsKey(payloadTransferUpdate.id)) {
          } else {
            //bytes not received till yet
            map[payloadTransferUpdate.id] = "";
          }
        }
      },
    );
    if (!isReceiver) {
      sendFile();
    }
  }

  stopDiscovery() async {
    await Nearby().stopDiscovery();
  }

  retrySend() async {
    await stopDiscovery();
    await startDiscovery();
  }

  createArchive() async {
    String saveFolder = "";
    await getApplicationCacheDirectory()
        .then((directory) => saveFolder = directory.path);
    var encoder = ZipFileEncoder();
    try {
      encoder.create('$saveFolder/data.zip');
      await encoder.addFile(File(lecturesBox.path!));
      await encoder.addFile(File(subjectBox.path!));
      List<LecturesPageModel> lectures = lecturesBox.values.toList();
      for (int i = 0; i < lectures.length; i++) {
        await encoder.addFile(File(lectures[i].lecturepath));
      }
      encoder.close();
      shareDataState = ShareDataState.searchingSend;
      tempFileUri = '$saveFolder/data.zip';
    } catch (e) {
      AppToasts.showErrorToast("تتعذر المشاركة!");
      Get.back();
    }
  }

  extractArchiveData() async {
    final ZipDecoder decoder = ZipDecoder();
    String tempSaveDirectory =
        (await getApplicationCacheDirectory()).absolute.path;

    //decode Archive
    List<int> s = (await receivedFile.readAsBytes());
    Archive archive = decoder.decodeBytes(s);
    //Getting Boxes Files
    ArchiveFile receivedLecturesBox = archive.files
        .firstWhere((element) => lecturesBox.path!.contains(element.name));
    ArchiveFile receivedSubjectsBox = archive.files
        .firstWhere((element) => subjectBox.path!.contains(element.name));
    List<ArchiveFile> archiveFiles = archive.files;
    //Getting Subjects
    await writeBoxesData(tempSaveDirectory, receivedSubjectsBox, subjectBox);
    await subjectBox.close();
    //Getting Lecture Box Data
    await writeBoxesData(tempSaveDirectory, receivedLecturesBox, lecturesBox);
    await lecturesBox.close();
    //Handle Subjects-Lectures Numbers
    await openNeededBoxes();
    await userDataBox.put(HiveKeys.subjectsNumber, subjectBox.length);
    await userDataBox.put(HiveKeys.lecturesNumber, lecturesBox.length);
    await lecturesBox.close();
    await subjectBox.close();
    //Getting Lectures Files
    String saveDirectory = (await getExternalStorageDirectory())!.path;
    await writeLectures(tempSaveDirectory, saveDirectory, archiveFiles);
    await receivedFile.delete();
    Get.back();
    AppToasts.successToast("تمت العملية بنجاح!");
  }

  writeBoxesData(String directory, ArchiveFile archiveBox, Box box) async {
    OutputStream output = OutputStream();
    archiveBox.writeContent(output);
    File file = File("$directory/${box.name}");
    await file.writeAsBytes(output.getBytes());
    String boxPath = box.path!;
    await file.copy(boxPath);
    await file.delete();

    output.clear();
  }

  writeLectures(String tempDirectory, String saveDirectory,
      List<ArchiveFile> lecturesList) async {
    OutputStream output = OutputStream();
    for (int i = 0; i < lecturesList.length; i++) {
      if (!lecturesList[i].name.contains("lecture") &&
          !lecturesList[i].name.contains("subject")) {
        lecturesList[i].writeContent(output);
        File file = File("$tempDirectory/${lecturesList[i].name}");
        await file.writeAsBytes(output.getBytes());
        String savePath = "$saveDirectory/${lecturesList[i].name}";
        await file.copy(savePath);
        await file.delete();
        output.clear();
      }
    }
  }

  @override
  void onInit() {
    shareDataState = isReceiver
        ? ShareDataState.searchingReceive
        : ShareDataState.creatingFile;
    super.onInit();
  }

  @override
  void onReady() async {
    await Future.delayed(const Duration(milliseconds: 600));
    await openNeededBoxes();
    if (!isReceiver) {
      await createArchive();
    }
    update();
    isReceiver ? startAdvertising() : startDiscovery();
    super.onReady();
  }

  @override
  void onClose() {
    isReceiver ? stopAdvertising() : stopDiscovery();
    if (endPointId != "") {
      Nearby().disconnectFromEndpoint(endPointId);
    }
    super.onClose();
  }
}
