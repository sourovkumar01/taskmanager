import 'package:flutter/material.dart';
import 'package:taskmanager/Data/Service/Network_Caller.dart';
import 'package:taskmanager/Data/Utils/Urls.dart';
import 'package:taskmanager/Presentation/Widget/Background_Widget.dart';
import 'package:taskmanager/Presentation/Widget/Profile_App_Bar.dart';
import 'package:taskmanager/Presentation/Widget/SnackBar_Message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key, required this.getApiCall});
  final VoidCallback getApiCall;
  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add New Task",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter title";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "Title"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 8,
                  controller: _descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter description";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Description",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 16)),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: addNewTaskInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          addNewTask();
                        }
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addNewTask() async {
    setState(() {
      addNewTaskInProgress = true;
    });

    Map<String, dynamic> inputParams = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": "New",
    };
    final response =
        await NetworkCaller.postRequest(Urls.createTask, inputParams);
    setState(() {
      addNewTaskInProgress = false;
    });
    if (response.isSuccess) {
      _titleController.clear();
      _descriptionController.clear();
      if (mounted) {
        showSnackBarMessage(context, "Task Added Successful");
        widget.getApiCall();
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.ErrorMessage ?? "Task added failed", true);
      }
    }
  }
}
