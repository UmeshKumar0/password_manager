import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/activity_logs_controller.dart';
import '../models/get_all_logs_model.dart';
import '../models/logs_model.dart';

class LogsItem extends StatefulWidget {
  LogsItem({
    super.key,
    required this.logs,
  });
  LogsModel logs;

  @override
  State<LogsItem> createState() => _LogsItemState();
}

class _LogsItemState extends State<LogsItem> {
  //bool showPassword = false;
  final logsController = Get.find<ActivityLogsController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.defaultDialog(title: "Log Details",
        content: Column(
          children: [
            Text("Action Taken By : ${widget.logs.user?.name}"),
            Text("Action Type : ${widget.logs.level}"),
            Text("Description: ${widget.logs.message}"),
            Text("Date: ${widget.logs.createdAt?.split("T"). first}"),
          ],
        )
        );
      },
      child: Wrap(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10))),
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text("${widget.logs.level}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 15,
                                color: widget.logs.level == "delete"
                                    ? Colors.red
                                    : widget.logs.level == "share"
                                        ? Colors.green
                                        : widget.logs.level == "update"
                                            ? Colors.yellow
                                            : widget.logs.level == "create"
                                                ? Colors.blue
                                                : Colors.black))),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(widget.logs.message ?? "",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                Text(
                    widget.logs.createdAt != null
                        ? widget.logs.createdAt!
                            .substring(0, 10)
                            .split("-")
                            .reversed
                            .join("-")
                        : "",
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w400)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
