import 'package:flutter/material.dart';
import 'package:taskmanager/Data/Models/Task+ITems.dart';
import 'package:taskmanager/Presentation/Utils/Style.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskItems,
    required this.onDelete,
    required this.oneEdit,
    required this.color,
  });

  final Color color;
  final TaskItems taskItems;
  final VoidCallback onDelete;
  final VoidCallback oneEdit;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Card(
        child: Container(
          height: 150,
          decoration: BoxDecoration(
              color: ColorWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 25)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.taskItems.title ?? "Unknown",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.taskItems.title ??
                            "please enter any description for good work",
                        style: const TextStyle(
                            color: ColorLightGray, fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: widget.color),
                          child: Expanded(
                              child: Text(
                            widget.taskItems.status ?? "",
                          )),
                        ),
                      ),
                      Wrap(children: [
                        IconButton(
                          onPressed: widget.oneEdit,
                          icon: const Icon(
                            Icons.edit,
                            color: ColorDarkBlue,
                          ),
                        ),
                        IconButton(
                          onPressed: widget.onDelete,
                          icon: const Icon(
                            Icons.delete,
                            color: ColorRed,
                          ),
                        ),
                      ])
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
