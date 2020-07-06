import 'package:flutter/material.dart';

class ConnectivityIssue extends StatelessWidget {
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
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Whoops!!!!',
                  style: TextStyle(fontSize: 40, color: Colors.red[400]),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Something went wrong. Please check your internet connection.',
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
