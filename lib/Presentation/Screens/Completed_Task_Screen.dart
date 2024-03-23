import 'package:flutter/material.dart';
import 'package:taskmanager/Data/Models/Count_buy_Status_Wrraper.dart';
import 'package:taskmanager/Data/Models/Task_List_Wrapper.dart';
import 'package:taskmanager/Data/Service/Network_Caller.dart';
import 'package:taskmanager/Data/Utils/Urls.dart';
import 'package:taskmanager/Presentation/Screens/Add_New_Task_Screen.dart';
import 'package:taskmanager/Presentation/Utils/Style.dart';
import 'package:taskmanager/Presentation/Widget/Background_Widget.dart';
import 'package:taskmanager/Presentation/Widget/Profile_App_Bar.dart';
import 'package:taskmanager/Presentation/Widget/SnackBar_Message.dart';
import 'package:taskmanager/Presentation/Widget/Task_Card.dart';
import 'package:taskmanager/Presentation/Widget/Task_Counter_Card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}
bool _getAllTaskCountBuyStatusInProgress = false;
bool _deleteTaskProgress = false;
bool _taskListWrapperInProgress = false;
bool _updateTaskInProgress = false;

CountBuyTaskWrapper _countByStatusWrapper = CountBuyTaskWrapper();
TaskListWrapper _completedTaskListWrapper = TaskListWrapper();

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    getDataFromApi();
    super.initState();
  }
  void getDataFromApi()async{
    getAllTaskCountByStatus();
    getAllTaskNewList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
          child: Column(
            children: [
              Expanded(
                child: Visibility(
                  visible: _taskListWrapperInProgress == false && _deleteTaskProgress ==false && _updateTaskInProgress == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: ()async => getDataFromApi(),
                    child: ListView.builder(
                        itemCount: _completedTaskListWrapper.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskCard(onDelete: (){
                            deleteTaskById(_completedTaskListWrapper.taskList![index].sId!);
                          },color: ColorBlue,
                            taskItems: _completedTaskListWrapper.taskList![index],
                            oneEdit: (){
                              _showUpdateStatusDialog(_completedTaskListWrapper.taskList![index].sId!);
                            },
                          );
                        }),
                  ),
                ),
              )
            ],
          )),
    );
  }



  void _showUpdateStatusDialog(String id){
    showDialog(context: context, builder: (context) {
      return  AlertDialog(title: const Text("Select Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(title: Text("New"),trailing: Icon(Icons.check),),
            ListTile(title: const Text("Completed"),onTap: (){
              _updateTaskById(id, "Completed");
              Navigator.pop(context);
            },),
            ListTile(title: const Text("Progress"),onTap: (){
              _updateTaskById(id, "Progress");
              Navigator.pop(context);
            },),
            ListTile(title: const Text("Canceled"),
              onTap: (){
                _updateTaskById(id, "Canceled");
                Navigator.pop(context);
              },),

          ],
        ),);
    },);
  }

  Future<void> getAllTaskCountByStatus() async {
    setState(() {
      _getAllTaskCountBuyStatusInProgress = true;
    });
    final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);
    if (response.isSuccess) {
      _countByStatusWrapper =
          CountBuyTaskWrapper.fromJson(response.ResponseBody);
      setState(() {
        _getAllTaskCountBuyStatusInProgress = false;
      });
    } else {
      if (mounted) {
        showSnackBarMessage(context, "request failed Try again");
      }
    }
  }

  Future<void> getAllTaskNewList() async {
    setState(() {
      _taskListWrapperInProgress = true;
    });
    final response = await NetworkCaller.getRequest(Urls.completedTaskList);
    if (response.isSuccess) {
      _completedTaskListWrapper = TaskListWrapper.fromJson(response.ResponseBody);;
      setState(() {
        _taskListWrapperInProgress = false;
      });
    } else {
      if (mounted) {
        showSnackBarMessage(context, "Sorry Task List Getting failed!");
      }
    }
  }
  Future<void>deleteTaskById(String id)async{
    _deleteTaskProgress =true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.deleteTask(id));
    _deleteTaskProgress =false;
    if(response.isSuccess){
      getDataFromApi();
    }else{
      if (mounted) {
        showSnackBarMessage(context, "Delete Task has been failed!");
      }
    }

  }
  Future<void>_updateTaskById(String id, String status)async{
    _updateTaskInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));
    _updateTaskInProgress = false;
    if(response.isSuccess){
      getDataFromApi();
    }else{
      if (mounted) {
        showSnackBarMessage(context, "Update Task Status has been failed!");
      }
    }
  }

}
