import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_some/AssetFiles/ImageAssetsLocation.dart';

class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildProgressIndicator();
  }

  Stack _buildProgressIndicator() {
    return Stack(
      children: <Widget>[
        Card(
          color: Colors.black12,
          child: Container(),
        ),
        Center(
          child: Container(
              width: 80,
              height: 80,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      // fit: BoxFit.fill,
                      image: new AssetImage(
                          ImageAssetsLocation.cloudSunReloader)))),
        ),
      ],
    );
  }
}
