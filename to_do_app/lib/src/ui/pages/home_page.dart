import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../utils/k_texts.dart';
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
          floatingActionButton: FloatingActionButton(onPressed: () {}),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(title: Text(kTextsTitleHome), centerTitle: true, actions: [
      
    ],);
  }

  Widget _body() {
    return Container();
  }
}
