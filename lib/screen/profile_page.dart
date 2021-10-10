import 'package:flutter/material.dart';
import 'package:moretech_vtb/assets/vtb_ui_typography.dart' as VtbTypography;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<ProfilePage> {
  static SharedPreferences? prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPreferences().whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
      Navigator.pop(context);
      return Future(() => true);
    },
    child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Имя: ' + prefs!.getString("name")!,
              style: VtbTypography.title1,
              ),
            Text(
              'Прогресс в Виселице: ' + getProgressOrZero().toString() + "/100",
              style: VtbTypography.title1,
            ),
          ]),
    ));
  }

  Future<void> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  int getProgressOrZero() {
    return prefs!.getInt("progress_v") == null ? 0 : prefs!.getInt("progress_v")!;
  }

}