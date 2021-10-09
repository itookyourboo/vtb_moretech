import 'package:flutter/material.dart';
import 'package:moretech_vtb/assets/vtb_ui_colors_light.dart';
import 'package:moretech_vtb/assets/vtb_ui_typography.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

TextStyle alertTitleStyle = largeTitle2.copyWith(
  color: Colors.white
);

TextStyle alertDescStyle = subtitle1.copyWith(
    color: Colors.white
);

var SuccessAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  animationDuration: Duration(milliseconds: 500),
  backgroundColor: blue90,
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  titleStyle: alertTitleStyle,
  descStyle: alertDescStyle,
);

var GameOverAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  animationDuration: Duration(milliseconds: 450),
  backgroundColor: blue90,
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  titleStyle: alertTitleStyle.copyWith(color: Colors.red),
  descStyle: alertDescStyle,
);

var FailedAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  animationDuration: Duration(milliseconds: 450),
  backgroundColor: blue90,
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  titleStyle: alertTitleStyle.copyWith(color: Colors.red),
  descStyle: alertDescStyle,
);


const kWordTextStyle = TextStyle(
    fontSize: 57,
    color: Colors.white,
    fontFamily: 'FiraMono',
    letterSpacing: 8);

const DialogButtonColor = Color(0x00000000);

const WordCounterTextStyle =
    TextStyle(fontSize: 29.5, color: Colors.white, fontWeight: FontWeight.w900);
