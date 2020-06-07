import 'package:flutter/material.dart';

class TimeAndDateWidget extends StatefulWidget {
  TimeAndDateWidget({Key key}) : super(key: key);

  @override
  _TimeAndDateWidgetState createState() => _TimeAndDateWidgetState();
}

class _TimeAndDateWidgetState extends State<TimeAndDateWidget> {
  bool isVisible = false;
  bool isExpanded = false;

  bool isStartSelected = false;
  bool isEndSelected = false;

  DateTime pickedStartDate;
  DateTime pickedEndDate;

  String _frequency = 'Never';
  List<String> frequencies = ['Never', 'Every day', 'Every week', 'Every 2 weeks', 'Every month', 'Every year'];

  @override
  void initState() {
    super.initState();
    pickedStartDate = DateTime.now();
    pickedEndDate = DateTime.now();
  }

  pickDate(bool isStart) async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year-5),
      lastDate: DateTime(DateTime.now().year+5),
      initialDate: DateTime.now()
    );

    if(date != null) {
      setState(() {
        if(isStart) {
          pickedStartDate = date;
          isStartSelected = true;
        } else {
          pickedEndDate = date;
          isEndSelected = true;
        }
      });
    }
  }

  Widget _buildStart() {
    return Visibility(
      child: GestureDetector(
        onTap: () { pickDate(true); },
        child: Container(
          margin:EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0
              )
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 30,
                child: Text(
                  'Starts*',
                  style: TextStyle(color: Color.fromRGBO(117, 117, 141, 1), fontSize: 16)
                ),
              ),
              Container(
                height: 30,
                child: isStartSelected ? Text('${pickedStartDate.year} ${pickedStartDate.month} ${pickedStartDate.day}') : Text('Select')
              )
            ],
          ),
        ),
      ),
      visible: isVisible,
    );
  }

  Widget _buildEnd() {
    return Visibility(
      child: GestureDetector(
        onTap: () { pickDate(false); },
        child: Container(
          margin:EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0
              )
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 30,
                child: Text(
                  'Ends',
                  style: TextStyle(color: Color.fromRGBO(117, 117, 141, 1), fontSize: 16)
                ),
              ),
              Container(
                height: 30,
                child: isStartSelected ? Text('${pickedStartDate.year} ${pickedStartDate.month} ${pickedStartDate.day}') : Text('Select')
              )
            ],
          ),
        ),
      ),
      visible: isVisible,
    );
  }

  Widget _buildFrequency() {
    return Visibility(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: DropdownButton(
          isExpanded: true,
          value: _frequency,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
            textDirection: TextDirection.rtl,
          ),
          iconSize: 24,
          elevation: 16,
          items: frequencies.map((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: new Text(val),
            );
          }).toList(),
          onChanged: (String newVal) {
            setState(() {
              _frequency = newVal;
            });
          },
        ),
      ),
      visible: isVisible,
    );
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: <Widget>[
        RaisedButton(
          padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Time and date*',
                style: TextStyle(color: Color.fromRGBO(117, 117, 141, 1), fontSize: 16)
              ),
              Icon(
                isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                size: 30,
                color: Color.fromRGBO(235, 238, 239, 1),
              )
            ],
          ),
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
              isExpanded = !isExpanded;
            });
          },
        ),
        _buildStart(),
        _buildEnd(),
        _buildFrequency(),
      ],
    );
  }
}