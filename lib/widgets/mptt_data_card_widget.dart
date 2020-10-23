import 'package:flutter/material.dart';

class MPTTDataCardWidget extends StatefulWidget {
  final String dataValue;

  const MPTTDataCardWidget({Key key, this.dataValue}) : super(key: key);


  @override
  _MPTTDataCardWidgetState createState() => _MPTTDataCardWidgetState();
}

class _MPTTDataCardWidgetState extends State<MPTTDataCardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        shadowColor: Colors.black,
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            widget.dataValue,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
