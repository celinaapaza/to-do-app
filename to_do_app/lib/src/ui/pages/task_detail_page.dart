import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../page_controllers/task_detail_page_controller.dart';

class TaskDetailPage extends StatefulWidget {

  const TaskDetailPage( {super.key});

  @override
  TaskDetailPageState createState() => TaskDetailPageState();
}

class TaskDetailPageState extends StateMVC<TaskDetailPage> {
  late TaskDetailPageController _con;

  TaskDetailPageState() : super(TaskDetailPageController()) {
    _con = TaskDetailPageController.con;
  }

  @override
  void initState() {
    _con.initPage();
    super.initState();
  }

  @override
  void dispose() {
    _con.disposePage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: _con.onPopInvoked,
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: Container(),
        ),
      ),
    );
  }
}

 