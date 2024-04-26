import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

alertDialogWarning(
    BuildContext context, String title, String desc, VoidCallback actionOK) {
  return AwesomeDialog(
    dialogBackgroundColor: Colors.lightBlue,
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.scale,
    headerAnimationLoop: false,
    title: title,
    desc: desc,
    btnOkOnPress: () {
      actionOK();
    },
    btnOkColor: Colors.amber[600],
    btnOkText: 'Ok',
    btnCancelOnPress: () {},
  ).show();
}

alertDialogError(
  BuildContext context,
  String title,
  String desc,
) {
  return AwesomeDialog(
          dialogBackgroundColor: Colors.red[100],
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          headerAnimationLoop: false,
          title: title,
          desc: desc,
          btnOkOnPress: () {},
          btnOkColor: Colors.red[200],
          btnOkText: 'OK')
      .show();
}

alertDialogInfo(
  BuildContext context,
  String title,
  String desc,
) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: 'Dialog Title',
      desc: 'Dialog description here',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.pop(context);
      }).show();
}
