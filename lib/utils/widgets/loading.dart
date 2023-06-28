
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading {
 void abrirLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return loading(context);
        });
  }

  Widget loading(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         SizedBox(
          width: 200,
          height: 200,
          child: CircularProgressIndicator(
            color: Colors.blue,
            strokeWidth: 10,
          ),
        ),
      ],
    );
  }

  void fecharLoading(BuildContext context) {
    Navigator.pop(context);
  }
}