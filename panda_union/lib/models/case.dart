import 'package:flutter/material.dart';
import 'package:panda_union/common/color.dart';
import 'package:panda_union/common/tool.dart';

class Case {
  Map<String, dynamic> dataMap;

  String id = "";
  String orgName = "";
  String patientName = "";
  String editDate = "";
  int type = -1;
  int processStatus = -1;
  int downloadStatus = -1;
  String from = ""; //0: sender list, 1: receiver list

  Case({
    required this.dataMap,
  }) {
    try {
      if (dataMap.containsKey("id")) {
        String temp = dataMap["id"];
        if (!isEmptyOrNull(temp)) {
          id = temp;
        }
      }

      if (dataMap.containsKey("from")) {
        String temp = dataMap["from"];
        if (!isEmptyOrNull(temp)) {
          from = temp;
        }
      }

      orgName = Case.selectOrgName(dataMap);

      if (dataMap.containsKey("patientName")) {
        String temp = dataMap["patientName"];
        if (!isEmptyOrNull(temp)) {
          patientName = temp;
        }
      }

      if (dataMap.containsKey("edit")) {
        String temp = dataMap["edit"];
        if (isEmptyOrNull(temp) || temp == "--") {
          if (dataMap.containsKey("time")) {
            String time = dataMap["time"];
            if (!isEmptyOrNull(time)) {
              editDate = time;
            }
          }
        } else {
          editDate = temp;
        }
      } else {
        if (dataMap.containsKey("time")) {
          String time = dataMap["time"];
          if (!isEmptyOrNull(time)) {
            editDate = time;
          }
        }
      }

      if (dataMap.containsKey("communicateTime")) {
        String temp = dataMap["communicateTime"];
        if (!isEmptyOrNull(temp)) {
          editDate = temp;
        }
      }

      if (dataMap.containsKey("caseType")) {
        type = (dataMap["caseType"] as int?) ?? -1;
      }

      if (dataMap.containsKey("processStatus")) {
        Map<String, dynamic> processStatusMap = dataMap["processStatus"];
        if (dataMap.containsKey("receviceName")) {
          String recName = dataMap["receviceName"];
          processStatus = (processStatusMap[recName] as int?) ?? -1;
        }
      }

      if (dataMap.containsKey("downloadStatus")) {
        try {
          Map<String, dynamic> downloadStatusMap = dataMap["downloadStatus"];
          if (dataMap.containsKey("receviceId")) {
            String recId = dataMap["receviceId"];
            if (!isEmptyOrNull(recId)) {
              if (downloadStatusMap.containsKey(recId)) {
                downloadStatus = (downloadStatusMap[recId] as int?) ?? -1;
              } else {
                if (dataMap.containsKey("sendId")) {
                  String sendId = dataMap["sendId"];
                  if (!isEmptyOrNull(sendId)) {
                    if (downloadStatusMap.containsKey(sendId)) {
                      downloadStatus =
                          (downloadStatusMap[sendId] as int?) ?? -1;
                    }
                  }
                }
              }
            }
          }
        } catch (e) {
          debugPrint("#### Error: Case.downloadStatus, $e");
          downloadStatus = (dataMap["downloadStatus"] as int?) ?? -1;
        }
      }
    } catch (e) {
      debugPrint("#### Error: Case, $e");
    }
  }

  bool isCover() {
    if (dataMap.containsKey("edit")) {
      String temp = dataMap["edit"];
      if (!isEmptyOrNull(temp) && temp != "--") {
        return true;
      }
    }
    return false;
  }

  bool isExpired() {
    if (dataMap.containsKey("isPreview")) {
      bool temp = (dataMap["isPreview"] as bool?) ?? false;
      return temp;
    }
    return false;
  }

  String getTypeName() {
    String typeName = "";

    switch (type) {
      case 1:
        typeName = "Orthodontics";
        break;
      case 2:
        typeName = "Implant";
        break;
      case 3:
        typeName = "Restoration";
        break;
      default:
        typeName = "";
    }

    return typeName;
  }

  String getTypeImageName() {
    String imageName = "";

    switch (type) {
      case 1:
        imageName = "tooth1.png";
        break;
      case 2:
        imageName = "tooth2.png";
        break;
      case 3:
        imageName = "tooth3.png";
        break;
      default:
        imageName = "tooth1.png";
    }

    return imageName;
  }

  String getProcessStatusName() {
    switch (processStatus) {
      case 1:
        return "Received";
      case 2:
        return "Processing";
      case 3:
        return "Shipped";
      case 4:
        return "Completed";
      default:
        return "";
    }
  }

  Color getProcessStatusColor() {
    switch (processStatus) {
      case 1:
        return MyColors.receivedCaseColor;
      case 2:
        return MyColors.processingCaseColor;
      case 3:
        return MyColors.shippedCaseColor;
      case 4:
        return MyColors.completedCaseColor;
      default:
        {
          return MyColors.systemGray6;
        }
    }
  }

  bool isBothRoles() {
    if (dataMap.containsKey("receviceId")) {
      String recId = dataMap["receviceId"];
      if (!isEmptyOrNull(recId)) {
        if (dataMap.containsKey("sendId")) {
          String sendId = dataMap["sendId"];
          if (!isEmptyOrNull(sendId)) {
            return recId.toLowerCase() == sendId.toLowerCase();
          }
        }
      }
    }

    return false;
  }

  bool isSender() {
    if (isBothRoles()) {
      if (!isEmptyOrNull(from)) {
        if (from == "0") {
          return true;
        } else if (from == "1") {
          return false;
        }
      }
    }

    if (dataMap.containsKey("isSend")) {
      bool b = (dataMap["isSend"] as bool?) ?? false;
      return b;
    }

    return false;
  }

  String getRoleName() {
    String roleName = "Receiver";

    if (isBothRoles()) {
      if (!isEmptyOrNull(from)) {
        if (from == "0") {
          roleName = "Sender";
          return roleName;
        } else if (from == "1") {
          return roleName;
        }
      }
    }

    if (dataMap.containsKey("isSend")) {
      bool b = (dataMap["isSend"] as bool?) ?? false;
      if (b) {
        roleName = "Sender";
      }
    }

    return roleName;
  }

  String getFormat() {
    String format = "";

    if (dataMap.containsKey("ext")) {
      String temp = dataMap["ext"];
      if (!isEmptyOrNull(temp) && temp.toLowerCase() != "unknown") {
        format = temp;
      }
    }

    return format;
  }

  String getPatientNameAndOrgName() {
    String name = "";

    if (!isEmptyOrNull("patientName") && !isEmptyOrNull("orgName")) {
      return "$patientName | $orgName";
    } else if (!isEmptyOrNull("patientName")) {
      return patientName;
    } else if (!isEmptyOrNull("orgName")) {
      return orgName;
    }

    return name;
  }

  void updateProcessStatus(int status) {
    processStatus = status;

    if (dataMap.containsKey("receviceName")) {
      String recName = dataMap["receviceName"];
      Map<String, dynamic> processStatusMap = <String, dynamic>{};
      processStatusMap[recName] = status;
      dataMap["processStatus"] = processStatusMap;
    }
  }

  static String selectOrgName(Map<String, dynamic> dataMap) {
    String orgName = "";
    try {
      if (dataMap.containsKey("receviceId")) {
        String receiveId = dataMap["receviceId"];
        if (!isEmptyOrNull(receiveId)) {
          String sendName = "";
          if (dataMap.containsKey("sendName")) {
            sendName = dataMap["sendName"];
          }

          String receiveName = "";
          if (dataMap.containsKey("receviceName")) {
            receiveName = dataMap["receviceName"];
          }

          bool isSend = false;
          if (dataMap.containsKey("isSend")) {
            isSend = dataMap["isSend"];
          }

          if (receiveId.toLowerCase() == Tool.invalidId.toLowerCase()) {
            orgName = sendName;
          } else {
            if (isSend == false) {
              orgName = sendName;
            } else {
              orgName = receiveName;
            }
          }
        }
      }
    } catch (e) {
      debugPrint("#### Error: Case.selectOrgName, $e");
    }

    return orgName;
  }
}
