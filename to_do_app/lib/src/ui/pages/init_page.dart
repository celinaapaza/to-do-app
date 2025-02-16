//Flutter imports:
import 'package:flutter/material.dart';

//Package imports:
import 'package:mvc_pattern/mvc_pattern.dart';

//Project imports:
import '../../../utils/k_assets.dart';
import '../page_controllers/init_page_controller.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  InitPageState createState() => InitPageState();
}

class InitPageState extends StateMVC<InitPage> {
  late InitPageController _con;

  InitPageState() : super(InitPageController()) {
    _con = InitPageController.con;
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
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: _con.initApp(),
          builder: (context, snapshot) => _content(),
        ),
      ),
    );
  }

  _content() {
    return Center(
      child: Image.asset(
        kAssetsSplash,
        fit: BoxFit.contain,
        height: MediaQuery.of(context).size.height * 0.15,
      ),
    );
  }
}
