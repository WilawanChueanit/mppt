import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mppt_esp32/widgets/mptt_data_card_widget.dart';
import 'package:mppt_esp32/widgets/mptt_data_overview_widget.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<double> wattList = List<double>();
  List<double> voltageList = List<double>();
  List<double> ampList = List<double>();
  List<double> batvoltageList = List<double>();
  List<double> chargeType = List<double>();
  List<double> percentage = List<double>();
  double volt, amp, watt, batvolt, cahrgeType, percen;
  Timer timer;
  FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  fetchSolarCellData() async {
    DatabaseReference databaseReference =
        _firebaseDatabase.reference().child("SolarCell");
    await databaseReference.once().then(
      (value) {
        Map<dynamic, dynamic> values = value.value;
        values.forEach(
          (key, value) {
            print("KEY : $key | VALUE : $value");
            voltageList.add(value["Voltage"].toDouble());
            ampList.add(value["Current"].toDouble());
            wattList.add(value["Power"].toDouble());
          },
        );
        setState(() {
          volt = voltageList[0];
          amp = ampList[0];
          watt = wattList[0];
        });
      },
    );
  }

  fetchBatteryData() async {
    DatabaseReference databaseReference =
        _firebaseDatabase.reference().child("Battery");
    await databaseReference.once().then(
      (value) {
        Map<dynamic, dynamic> values = value.value;
        values.forEach(
          (key, value) {
            print("KEY : $key | VALUE : $value");
            batvoltageList.add(value["Voltage"].toDouble());
            chargeType.add(value["Charge_Type"].toDouble());
            percentage.add(value["Percentage"].toDouble());
          },
        );
        setState(() {
          batvolt = batvoltageList[0];
          cahrgeType = chargeType[0];
          percen = percentage[0];
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();

    /* Call for first time */
    fetchSolarCellData();
    /* Call timer to iterable function */
    timer = Timer.periodic(
      Duration(seconds: 5),
      (timer) => fetchSolarCellData(),
    );

    fetchBatteryData();
    timer = Timer.periodic(
      Duration(seconds: 5),
      (timer) => fetchBatteryData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: __dashboardAppbar(),
      drawer: Container(
        width: 250,
        color: Colors.teal,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              MPTTDataOverviewCardWidget(
                icon: Image.asset("images/solacell.png"),
                dataTitle: "SOLAR CELL",
                children: Column(
                  children: [
                    SizedBox(height: 5),
                    MPTTDataCardWidget(dataValue: "VOLTAGE : $volt V"),
                    SizedBox(height: 5),
                    MPTTDataCardWidget(dataValue: "CURRENT : $amp A"),
                    SizedBox(height: 5),
                    MPTTDataCardWidget(dataValue: "POWER : $watt W"),
                  ],
                ),
              ),
              MPTTDataOverviewCardWidget(
                icon: Image.asset("images/battery.png"),
                dataTitle: "BATTERY",
                children: Column(
                  children: [
                    SizedBox(height: 5),
                    MPTTDataCardWidget(dataValue: "VOLTAGE :  $batvolt V"),
                    SizedBox(height: 5),
                    MPTTDataCardWidget(dataValue: "CHARGE TYPE : $cahrgeType"),
                    SizedBox(height: 5),
                    MPTTDataCardWidget(dataValue: "PERCENTAGE :  $percen %"),
                  ],
                ),
              ),
              // __solarCellWidget(name: "SOLAR CELL", image: "solacell.png"),
            ],
          ),
        ),
      ),
    );
  }

  Widget __dashboardAppbar() => AppBar(
        centerTitle: true,
        title: Text('MPTT ESP32'),
      );
}
