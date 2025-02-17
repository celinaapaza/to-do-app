//Flutter imports:
import 'package:flutter/material.dart';

//Package imports:
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:to_do_app/utils/k_colors.dart';
import 'package:to_do_app/utils/k_texts.dart';

//Project imports:
import '../components/custom_button_component.dart';
import '../components/task_card_component.dart';
import '../page_controllers/task_detail_page_controller.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({super.key});

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
      canPop: false,
      onPopInvokedWithResult: _con.onPopInvoked,
      child: SafeArea(
        child: Scaffold(
          body: _body(),
          appBar: _appBar(),
          bottomNavigationBar: _footer(),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        _con.task?.title ?? '-',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
      leading: GestureDetector(
        onTap: _con.onBack,
        child: const Icon(Icons.arrow_back_ios),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<Object>(
      stream: _con.streamTask,
      builder: (context, snapshot) {
        _con.onSnapshotData(snapshot);
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Hero(
            tag: _con.task.hashCode.toString(),
            child: TaskCardComponent(
              title: _con.task?.title,
              description: _con.task?.description,
              expirationDate: _con.task?.expirationDate,
              taskPriority: _con.task?.taskPriority,
              isCompleted: _con.task?.isCompleted ?? false,
              onTapCheckBox:
                  (bool newValue) => _con.onTapTaskCheckBox(newValue),
              maxLineDescription: 100,
            ),
          ),
        );
      },
    );
  }

  Widget _footer() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: customButtonComponent(
              context,
              kTextDelete,
              Icons.delete_outline_rounded,
              kColorRedT1,
              _con.onTapDelete,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: customButtonComponent(
              context,
              kTextEdit,
              Icons.mode_edit_outlined,
              kColorPrimary,
              _con.onTapEdit,
            ),
          ),
        ],
      ),
    );
  }
}
