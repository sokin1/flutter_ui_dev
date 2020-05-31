import 'package:flutter/material.dart';

class TimeAndDateWidget extends StatefulWidget {
  TimeAndDateWidget({Key key}) : super(key: key);

  @override
  _TimeAndDateWidgetState createState() => _TimeAndDateWidgetState();
}

class _TimeAndDateWidgetState extends State<TimeAndDateWidget> {
  bool isVisible = false;
  bool isExpanded = false;

  DateTime pickedDate;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year-5),
      lastDate: DateTime(DateTime.now().year+5),
      initialDate: pickedDate
    );

    if(date != null) {
      setState(() {
        pickedDate = date;
      });
    }
  }

  Widget _buildStart() {
    return Visibility(
      child: RaisedButton(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Starts*',
              style: TextStyle(color: Color.fromRGBO(117, 117, 141, 1), fontSize: 16)
            ),
            pickedDate != null ? Text('${pickedDate.year} ${pickedDate.month} ${pickedDate.day}') : Text('Select')
          ],
        ),
        onPressed: pickDate,
      ),
      visible: isVisible,
    );
  }

  Widget _buildEnd() {
    return Visibility(
      child: RaisedButton(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Ends',
              style: TextStyle(color: Color.fromRGBO(117, 117, 141, 1), fontSize: 16)
            ),
            pickedDate != null ? Text('${pickedDate.year} ${pickedDate.month} ${pickedDate.day}') : Text('Select')
          ],
        ),
        onPressed: pickDate,
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
        _buildEnd()
      ],
    );
  }
}