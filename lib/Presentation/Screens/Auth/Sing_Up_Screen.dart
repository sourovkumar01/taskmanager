import 'package:flutter/material.dart';
import 'package:taskmanager/Data/Models/Response_Object.dart';
import 'package:taskmanager/Data/Service/Network_Caller.dart';
import 'package:taskmanager/Data/Utils/Urls.dart';
import 'package:taskmanager/Presentation/Widget/Background_Widget.dart';
import 'package:taskmanager/Presentation/Widget/SnackBar_Message.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  final TextEditingController _FirstNameController = TextEditingController();
  final TextEditingController _LastNameController = TextEditingController();
  final TextEditingController _MobileController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _RegistationInprogress = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Text("Join With Us",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 50),
                  TextFormField(
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                    controller: _EmailController,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter your Frist name";
                      }
                      return null;
                    },
                    controller: _FirstNameController,
                    decoration: const InputDecoration(hintText: "Frist Name"),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter your Last name";
                      }
                      return null;
                    },
                    controller: _LastNameController,
                    decoration: const InputDecoration(hintText: "Last Name"),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter your Mobile";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: _MobileController,
                    decoration: const InputDecoration(hintText: "Mobile"),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter your Password";
                      }
                      if (value.length <= 6) {
                        return "Please password shud be 6 charracters";
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: _PasswordController,
                    decoration: const InputDecoration(hintText: "Password"),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              _RegistationInprogress = false;
                            });
                            Map<String, dynamic> InputParams = {
                              "email": _EmailController.text.trim(),
                              "firstName": _FirstNameController.text.trim(),
                              "lastName": _LastNameController.text.trim(),
                              "mobile": _MobileController.text.trim(),
                              "password": _PasswordController.text.trim(),
                            };
                            final ResponseObject response =
                                await NetworkCaller.postRequest(
                                    Urls.registration, InputParams);
                            setState(() {
                              _RegistationInprogress = true;
                            });
                            if (response.isSuccess) {
                              if (mounted) {
                                showSnackBarMessage(
                                    context, "Registation Complete");
                                Navigator.pop(context);
                              }
                            } else {
                              if (mounted) {
                                showSnackBarMessage(
                                    context, "Registation Faild!", true);
                              }
                            }
                          }
                        },
                        child: _RegistationInprogress
                            ? const Icon(Icons.arrow_circle_right_outlined)
                            : const Center(
                                child: CircularProgressIndicator(),
                              )),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have account?",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Sing in",
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _PasswordController.dispose();
    _EmailController.dispose();
    _FirstNameController.dispose();
    _LastNameController.dispose();
    _MobileController.dispose();
    super.dispose();
  }
}
