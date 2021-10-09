import 'package:flutter/material.dart';
import 'package:moretech_vtb/assets/vtb_ui_typography.dart' as VtbTypography;

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          'Profile Page',
          style: VtbTypography.largeTitle1,
        )
    );
  }
}