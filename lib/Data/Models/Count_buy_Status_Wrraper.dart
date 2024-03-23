import 'package:taskmanager/Data/Models/Task_By_Status_Data.dart';

class CountBuyTaskWrapper {
  String? status;
  List<TaskBuyStatusData>? listOfTaskStatusData;

  CountBuyTaskWrapper({this.status, this.listOfTaskStatusData});

  CountBuyTaskWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      listOfTaskStatusData = <TaskBuyStatusData>[];
      json['data'].forEach((v) {
        listOfTaskStatusData!.add(TaskBuyStatusData.fromJson(v));
      });
    }
  }
}