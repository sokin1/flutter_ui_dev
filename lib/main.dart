import 'package:flutter/material.dart';
import 'package:flutter_ui_dev/time_and_date_field.dart';
import 'package:flutter_ui_dev/venue_field.dart';
import 'package:flutter_ui_dev/general_field.dart';
import 'package:flutter_ui_dev/org_field.dart';
import 'package:flutter_ui_dev/perf_field.dart';
import 'package:flutter_ui_dev/price_field.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Testing UI",
      home: new Scaffold(
        appBar: AppBar(
          title: const Text('Post your event')
        ),
        body: TestWidget()
      )
    );
    
  }
}

class TestWidget extends StatefulWidget {
  TestWidget({Key key}) : super(key: key);

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GeneralWidget(),
          SizedBox(height: 20),
          TimeAndDateWidget(),
          SizedBox(height: 20),
          VenueWidget(),
          SizedBox(height: 20),
          OrgWidget(),
          SizedBox(height: 20),
          PerfWidget(),
          SizedBox(height: 20),
          PriceWidget(),
          SizedBox(height: 20),
          RaisedButton(
            child: Text(
              'POST',
              style: TextStyle(color: Colors.blue, fontSize: 16)
            ),
            onPressed: () => {},
          )
        ],
      ),
    );
  }
}