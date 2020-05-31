import 'package:flutter/material.dart';

class VenueWidget extends StatefulWidget {
  VenueWidget({Key key}) : super(key: key);

  @override
  _VenueWidgetState createState() => _VenueWidgetState();
}

class _VenueWidgetState extends State<VenueWidget> {
  bool isVisible = false;
  bool isExpanded = false;

  Widget _buildNameOfVenue() {
    return Visibility(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Name of the venue*',
          suffixIcon: Icon(Icons.clear),
        ),
      ),
      visible: isVisible,
    );
  }

  Widget _buildAddress() {
    return Visibility(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Street address of the venue*',
          suffixIcon: Icon(Icons.clear),
        ),
      ),
      visible: isVisible,
    );
  }

  Widget _buildAvatar() {
    return Visibility(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Avatar of the venue',
          suffixIcon: Icon(Icons.camera),
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
                'Venue*',
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
        _buildNameOfVenue(),
        _buildAddress(),
        _buildAvatar()
      ],
    );
  }
}