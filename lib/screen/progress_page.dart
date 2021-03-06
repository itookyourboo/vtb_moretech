import 'package:flutter/material.dart';
import 'package:moretech_vtb/assets/vtb_ui_typography.dart' as VtbTypography;

class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Progress Page',
        style: VtbTypography.largeTitle1,
      )
    );
  }
}