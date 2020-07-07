import 'package:flutter/material.dart';

class ExceptionHandler extends StatelessWidget {
  String exceptionMessage;

  ExceptionHandler({@required this.exceptionMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        height: 200,
        child: Card(
          elevation: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.error,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  '${exceptionMessage.replaceAll("Exception: ", "").replaceAll("Exception:", "")}',
                  style: TextStyle(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
