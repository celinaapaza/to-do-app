import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../page_controllers/create_or_edit_task_page_controller.dart';

class CreateOrEditTaskPage extends StatefulWidget {
  const CreateOrEditTaskPage({super.key});

  @override
  CreateOrEditTaskPageState createState() => CreateOrEditTaskPageState();
}

class CreateOrEditTaskPageState extends StateMVC<CreateOrEditTaskPage> {
  late CreateOrEditTaskPageController _con;

  CreateOrEditTaskPageState() : super(CreateOrEditTaskPageController()) {
    _con = CreateOrEditTaskPageController.con;
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
      child: SafeArea(child: Scaffold(body: Container())),
    );
  }
}
