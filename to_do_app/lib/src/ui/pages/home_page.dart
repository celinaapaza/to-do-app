//Flutter imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Package imports:
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';

//Project imports:
import '../../../utils/k_colors.dart';
import '../../../utils/k_texts.dart';
import '../../enums/task_order_type_enum.dart';
import '../../models/task_model.dart';
import '../../providers/theme_data_provider.dart';
import '../components/switch_theme_component.dart';
import '../components/task_card_component.dart';
import '../page_controllers/home_page_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends StateMVC<HomePage> {
  late HomePageController _con;

  HomePageState() : super(HomePageController()) {
    _con = HomePageController.con;
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
      onPopInvokedWithResult: _con.onPopInvoked,
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: _appBar(),
          body: _body(),
          floatingActionButton: _fab(),
          drawer: _drawer(),
        ),
      ),
    );
  }

  Widget _fab() {
    return FloatingActionButton(
      onPressed: _con.onTapFab,
      child: Icon(
        Icons.add,
        color:
            context.watch<ThemeDataProvider>().darkMode
                ? kColorBlack
                : kColorWhite,
        size: 30,
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        kTextTitleHome,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
    );
  }

  Widget _drawer() {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: kColorPrimary,
                size: 25,
              ),
            ),
            const SizedBox(height: 20),
            _userProfile(),
            const Divider(height: 40),
            Text(
              kTextTheme,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.start,
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            SwitchThemeComponent(
              isDarkMode: context.watch<ThemeDataProvider>().darkMode,
              onTap: _con.onTapSwitchTheme,
            ),
            const Spacer(),
            _logout(),
          ],
        ),
      ),
    );
  }

  Widget _userProfile() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: kColorPrimary, width: 4),
          ),
          child: const Center(
            child: Icon(Icons.person_rounded, color: kColorPrimary, size: 40),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kTextUser,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.start,
                maxLines: 2,
              ),
              Text(
                _con.userEmail,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.start,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _logout() {
    return GestureDetector(
      onTap: _con.onTapLogout,
      child: Row(
        children: [
          const Icon(Icons.logout_rounded, color: kColorPrimary, size: 30),
          const SizedBox(width: 10),
          Text(kTextLogout, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<Object>(
      stream: _con.streamTasks,
      builder: (context, snapshot) {
        _con.onSnapshotData(snapshot);
        return _con.tasks.isEmpty
            ? Center(
              child: Text(
                kTextNotTasks,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            )
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_header(), Expanded(child: _taskList())],
            );
      },
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              kTextTasks,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.start,
            ),
          ),
          GestureDetector(
            onTap: () {
              //TODO: onTap Filters
            },
            child: Row(
              children: [
                Icon(
                  _con.filter.ascendingOrder
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: kColorPrimary,
                  size: 30,
                ),
                Text(
                  _con.filter.taskOrderType?.label ?? "-",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: kColorPrimary),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              //TODO: onTap Filters
            },
            child: Row(
              children: [
                const Icon(
                  Icons.filter_alt_outlined,
                  color: kColorPrimary,
                  size: 25,
                ),
                Text(
                  "(${_con.filter.totalFilterApplied})",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: kColorPrimary),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _taskList() {
    return ListView.separated(
      itemCount: _con.tasks.length,
      itemBuilder: (context, index) {
        TaskModel task = _con.tasks[index];
        return Padding(
          padding: EdgeInsets.only(
            top: index == 0 ? 15 : 0,
            bottom: index == _con.tasks.length - 1 ? 40 : 0,
            left: 20,
            right: 20,
          ),
          child: GestureDetector(
            onTap: () {
              _con.onTapTask(task);
            },
            child: Hero(
              tag: task.hashCode.toString(),
              child: TaskCardComponent(
                title: task.title,
                description: task.description,
                expirationDate: task.expirationDate,
                taskPriority: task.taskPriority,
                isCompleted: task.isCompleted,
                darkenIsCompleted: true,
                maxLineDescription: 2,
                onTapCheckBox:
                    (bool newValue) => _con.onTapTaskCheckBox(task, newValue),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 15),
    );
  }
}
