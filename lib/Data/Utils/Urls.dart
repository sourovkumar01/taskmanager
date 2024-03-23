class Urls {
  static const String _BaseUrl = "https://task.teamrabbil.com/api/v1";
  static const String registration = "$_BaseUrl/registration";
  static const String login = "$_BaseUrl/login";
   static const String createTask = "$_BaseUrl/createTask";
static const String taskCountByStatus = "$_BaseUrl/taskStatusCount";
static const String newTaskList = "$_BaseUrl/listTaskByStatus/New";
  static const String completedTaskList = "$_BaseUrl/listTaskByStatus/Completed";
   static const String progressTaskList = "$_BaseUrl/listTaskByStatus/Progress";
   static const String cancelledTaskList = "$_BaseUrl/listTaskByStatus/Cancelled";

static  String deleteTask(String id) => "$_BaseUrl/deleteTask/$id";
static  String updateTaskStatus(String id,String status) => "$_BaseUrl/updateTaskStatus/$id/$status";

}
