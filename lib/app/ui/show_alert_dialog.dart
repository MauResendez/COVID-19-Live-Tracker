import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog({ // Lets you show a pop up message with text that you want to show on it
  @required BuildContext context,
  @required String title,
  @required String content,
  @required String defaultActionText,
}) async {
  if(Platform.isIOS)
  {
    return await showCupertinoDialog( // Shows an iOS style of error
      context: context,
      builder: (context) => CupertinoAlertDialog
      (
        title: Text(title),
        content: Text(content),
        actions: <Widget>
        [
          CupertinoDialogAction(onPressed: () => Navigator.of(context).pop(), child: Text(defaultActionText))
        ],
      )
    );
  }
  return await showDialog( // Shows an Android style of error
    context: context,
    builder: (context) => AlertDialog
    (
      title: Text(title),
      content: Text(content),
      actions: <Widget>
      [
        FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text(defaultActionText))
      ],
    )
  );
}

