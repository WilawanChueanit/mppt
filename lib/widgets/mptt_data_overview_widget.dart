import 'package:flutter/material.dart';

class MPTTDataOverviewCardWidget extends StatefulWidget {
  final String dataTitle;
  final Widget icon, children;

  const MPTTDataOverviewCardWidget({Key key, icon, dataTitle, children})
      : this.icon = icon ?? null,
        this.dataTitle = dataTitle ?? "INVALID DATA",
        this.children = children ?? null,
        super(key: key);

  @override
  _MPTTDataOverviewCardWidgetState createState() =>
      _MPTTDataOverviewCardWidgetState();
}

class _MPTTDataOverviewCardWidgetState
    extends State<MPTTDataOverviewCardWidget> {
  double screenWidth, screenHeight;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 3,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child:
                    Container(margin: EdgeInsets.all(10), child: widget.icon)),
            Container(
              decoration:
                  new BoxDecoration(border: Border.all(color: Colors.black54)),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.teal[200],
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(widget.dataTitle,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w900)),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: widget.children,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
