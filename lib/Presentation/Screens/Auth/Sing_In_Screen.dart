import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taskmanager/Data/Models/LoginResponse.dart';
import 'package:taskmanager/Data/Models/Response_Object.dart';
import 'package:taskmanager/Data/Service/Network_Caller.dart';
import 'package:taskmanager/Data/Utils/Urls.dart';
import 'package:taskmanager/Presentation/Controllers/Auth_Controllers.dart';
import 'package:taskmanager/Presentation/Screens/Auth/Email_verification_Screen.dart';
import 'package:taskmanager/Presentation/Screens/Auth/Sing_Up_Screen.dart';
import 'package:taskmanager/Presentation/Screens/Main_Bottom_Nav_Screen.dart';
import 'package:taskmanager/Presentation/Utils/Style.dart';
import 'package:taskmanager/Presentation/Widget/Background_Widget.dart';
import 'package:taskmanager/Presentation/Widget/SnackBar_Message.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _LoginInProgress = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    "Get Started With",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter you email";
                      }
                      return null;
                    },
                    controller: _EmailController,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter you Password";
                      }
                      if (value.length <= 6) {
                        return "Password shud be 6 charracters";
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
                              _LoginInProgress = false;
                            });
                            Map<String, dynamic> IputParams = {
                              "email": _EmailController.text.trim(),
                              "password": _PasswordController.text,
                            };
                            final ResponseObject response =
                                await NetworkCaller.postRequest(
                                    Urls.login, IputParams,formInSingIn: true);
                            setState(() {
                              _LoginInProgress = true;
                            });
                            if (response.isSuccess) {
                              if (mounted) {
                                LoginResponse loginResponse =
                                    LoginResponse.fromJson(
                                        response.ResponseBody);

                                await AuthControllers.SaveUserData(
                                    loginResponse.userdata!);
                                await AuthControllers.SaveToken(
                                    loginResponse.token!);

                                if (mounted) {
                                  showSnackBarMessage(
                                      context, "Login Successful");
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MainBottomNavScreen(),
                                      ),
                                      (route) => false);
                                }
                              }
                            } else {
                              if (mounted) {
                                showSnackBarMessage(
                                    context, "Login Failed!", true);
                              }
                            }
                          }
                        },
                        child: _LoginInProgress
                            ? const Icon(Icons.arrow_circle_right_outlined)
                            : const Center(
                                child: CircularProgressIndicator(),
                              )),
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: TextButton(
                      style:
                          TextButton.styleFrom(foregroundColor: ColorLightGray),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EmailVerificationScreen(),
                            ));
                      },
                      child: const Text(
                        "Forget Password ?",
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SingUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sing up",
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
    super.dispose();
  }
}
