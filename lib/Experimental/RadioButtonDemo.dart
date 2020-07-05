import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadioButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RadioButtons(),
    );
  }
}

class RadioButtons extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RadioButtonState();
}

class RadioButtonState extends State<RadioButtons> {
  int _groupValue = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _myRadioButton(
          title: "Checkbox 0",
          value: 0,
          onChanged: (newValue) => setState(() => _groupValue = newValue),
        ),
        _myRadioButton(
          title: "Checkbox 1",
          value: 1,
          onChanged: (newValue) => setState(() => _groupValue = newValue),
        ),
      ],
    );
  }

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      // groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title),
    );
  }
}
