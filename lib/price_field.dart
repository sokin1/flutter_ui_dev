import 'package:flutter/material.dart';

class PriceWidget extends StatefulWidget {
  PriceWidget({Key key}) : super(key: key);

  @override
  _PriceWidgetState createState() => _PriceWidgetState();
}

class _PriceWidgetState extends State<PriceWidget> {
  bool isVisible = false;
  bool isTicketTab = true;
  bool isFreeEvent = false;
  bool isUnlimitedNumberOfTickets = false;
  bool isUnlimitedNumberOfCodes = true;
  bool isExpanded = false;


  List<String> currencies = ['Currency', 'a', 'b', 'c', 'd'];
  String _currency = 'Currency';

  Widget _buildSwitch() {
    return Visibility(
      child: Switch(
        value: isTicketTab,
        onChanged: (_) {
          setState(() {
            isTicketTab = !isTicketTab;
          });
        },
      ),
      visible: isVisible,
    );
  }

  Widget _buildFreeEvent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Free event'),
        Switch(
          value: isFreeEvent,
          onChanged: (_) {
            setState(() {
              isFreeEvent = !isFreeEvent;
            });
          }
        )
      ],
    );
  }

  Widget _buildUnlimitedNumberOfTickets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Unlimited number of tickets'),
        Switch(
          value: isUnlimitedNumberOfTickets,
          onChanged: (_) {
            setState(() {
              isUnlimitedNumberOfTickets = !isUnlimitedNumberOfTickets;
            });
          }
        )
      ],
    );
  }

  Widget _buildTicketingPlatform() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Link to ticketing platform',
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => {},
        )
      ),
    );
  }

  Widget _buildPromocode() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Promo code',
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => {},
        )
      ),
    );
  }

  Widget _buildDiscountAmount() {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        labelText: 'Discount amount',
        suffix: DropdownButtonHideUnderline(
          child: Container(
            height: 20,
            child: DropdownButton(
              value: _currency,
              autofocus: true,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              items: currencies.map((String val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: new Text(val),
                );
              }).toList(),
              onChanged: (String newVal) {
                setState(() {
                  _currency = newVal;
                });
              },
            )
          )
        )
      )
    );
  }

  Widget _buildUnlimitedNumberOfCodes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('Unlimited number of codes', ),
        Switch(
          value: isUnlimitedNumberOfCodes,
          onChanged: (_) {
            setState(() {
              isUnlimitedNumberOfCodes = !isUnlimitedNumberOfCodes;
            });
          }
        )
      ],
    );
  }

  Widget _buildPriceOfPromoCode() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Price of the promo code',
        suffixText: 'RocksTM'
      ),
    );
  }

  Widget _buildTicketTab() {
    return Visibility(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildFreeEvent(),
          _buildUnlimitedNumberOfTickets(),
          _buildTicketingPlatform(),
        ],
      ),
      visible: isVisible && isTicketTab,
    );
  }

  Widget _buildPromoTab() {
    return Visibility(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildPromocode(),
          _buildDiscountAmount(),
          _buildUnlimitedNumberOfCodes(),
          _buildTicketingPlatform(),
          _buildPriceOfPromoCode()
        ],
      ),
      visible: isVisible && !isTicketTab,
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
                'Product and price*',
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
        _buildSwitch(),
        _buildTicketTab(),
        _buildPromoTab(),
      ],
    );
  }
}