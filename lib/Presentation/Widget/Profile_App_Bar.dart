import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/App.dart';
import 'package:taskmanager/Presentation/Controllers/Auth_Controllers.dart';
import 'package:taskmanager/Presentation/Screens/Auth/Sing_In_Screen.dart';
import 'package:taskmanager/Presentation/Screens/Update_Profile_Screen.dart';
import 'package:taskmanager/Presentation/Utils/Assets_Path.dart';
import 'package:taskmanager/Presentation/Utils/Style.dart';

AppBar get profileAppBar {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: ColorGreen,
    title: GestureDetector(
      onTap: () {
        Navigator.push(
            TaskManager.navigatorKey.currentState!.context,
            MaterialPageRoute(
              builder: (context) => const UpdateProfileScreen(),
            ));
      },
      child: Row(children: [
        CircleAvatar(
          backgroundImage: AssetImage(AssetsPath.Profilejpeg),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AuthControllers.userData?.fullName ?? "Unknown",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                 AuthControllers.userData?.email?? "",
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings),
        ),
        IconButton(
          onPressed: () {
            AuthControllers.ClearUserData();
            Navigator.pushAndRemoveUntil(
                TaskManager.navigatorKey.currentState!.context,
                MaterialPageRoute(
                  builder: (context) => const SingInScreen(),
                ),
                (route) => false);
          },
          icon: const Icon(Icons.logout_outlined),
        ),
      ]),
    ),
  );
}
