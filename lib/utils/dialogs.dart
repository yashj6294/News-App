import 'package:news_app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

showLoaderDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: const SizedBox(
          child: SpinKitDualRing(
            color: Colors.lightBlueAccent,
          ),
        ),
      );
    },
  );
}

showErrorDialog(BuildContext context, String message) {
  double w = MediaQuery.of(context).size.width;
  AlertDialog alert = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
        ),
        const SizedBox(
          height: 20.0,
        ),
        Button(
          onTap: () {
            Navigator.pop(context);
          },
          text: 'OK',
          width: w * 0.5,
        ),
      ],
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(onWillPop: () async => false, child: alert);
    },
    barrierDismissible: false,
  );
}
