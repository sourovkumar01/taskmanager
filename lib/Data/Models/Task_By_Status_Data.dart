
class TaskBuyStatusData {
  String? sId;
  int? sum;

  TaskBuyStatusData({this.sId, this.sum});

  TaskBuyStatusData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }
}
