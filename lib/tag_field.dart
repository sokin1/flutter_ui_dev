import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

class TagWidget extends StatefulWidget {
  TagWidget({Key key}) : super(key: key);

  @override
  _TagWidgetState createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {
  String _text = '';

  Widget _buildAddButton() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.pinkAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.add,
            color: Colors.white,
            size: 15.0,
          ),
          Text(
            "Add New Tag",
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ],
      ),
    );
}

Widget _buildTag() {
  return FlutterTagging(
    textFieldDecoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Tags",
        labelText: "Enter tags"),
    addButtonWidget: _buildAddButton(),
    chipsColor: Colors.pinkAccent,
    chipsFontColor: Colors.white,
    deleteIcon: Icon(Icons.cancel,color: Colors.white),
    chipsPadding: EdgeInsets.all(2.0),
    chipsFontSize: 14.0,
    chipsSpacing: 5.0,
    chipsFontFamily: 'helvetica_neue_light',
    suggestionsCallback: (pattern) async {
      return await TagSearchService.getSuggestions(pattern);
      },
    onChanged: (result) {
      setState(() {
        _text = result.toString();
        });
      },
  );
}

  @override
  Widget build(BuildContext context) {
    return _buildTag();
  }
}

class TagSearchService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(milliseconds: 400), null);
    List<dynamic> tagList = <dynamic>[];
    tagList.add({'name': "Flutter", 'value': 1});
    tagList.add({'name': "HummingBird", 'value': 2});
    tagList.add({'name': "Dart", 'value': 3});
    List<dynamic> filteredTagList = <dynamic>[];
    if (query.isNotEmpty) {
      filteredTagList.add({'name': query, 'value': 0});
    }
    for (var tag in tagList) {
      if (tag['name'].toLowerCase().contains(query)) {
        filteredTagList.add(tag);
      }
    }
    return filteredTagList;
  }
}