import 'package:flutter/material.dart';
import 'package:taskmanager/Presentation/Utils/Style.dart';
import 'package:taskmanager/Presentation/Widget/Background_Widget.dart';
import 'package:taskmanager/Presentation/Widget/Profile_App_Bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

final TextEditingController _EmailController = TextEditingController();
final TextEditingController _PasswordController = TextEditingController();
final TextEditingController _FirstNameController = TextEditingController();
final TextEditingController _LastNameController = TextEditingController();
final TextEditingController _MobileController = TextEditingController();

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      resizeToAvoidBottomInset: false,
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text("Update Profile",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      color: ColorWhite,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          color: ColorDarkBlue,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8))),
                      child: const Text("Photo",
                          style: TextStyle(color: ColorLight, fontSize: 15)),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Image",
                      style: TextStyle(fontSize: 16, color: ColorLightGray),
                    )
                  ]),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _EmailController,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _FirstNameController,
                  decoration: const InputDecoration(hintText: "Frist Name"),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _LastNameController,
                  decoration: const InputDecoration(hintText: "Last Name"),
                ),
                const SizedBox(height: 16),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _MobileController,
                  decoration: const InputDecoration(hintText: "Mobile"),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _PasswordController,
                  decoration: const InputDecoration(hintText: "Password"),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Update",
                      style: TextStyle(fontSize: 20),
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
