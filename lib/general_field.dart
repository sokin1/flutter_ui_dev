import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GeneralWidget extends StatefulWidget {
  GeneralWidget({Key key}) : super(key: key);

  @override
  _GeneralWidgetState createState() => _GeneralWidgetState();
}

class _GeneralWidgetState extends State<GeneralWidget> {
  bool isVisible = true;
  bool isExpanded = false;

  Future<File> imageFile;
  String _category = 'Category';
  String _text = '';
  List<String> categories = ['Category', 'a', 'b', 'c', 'd'];

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget _buildEventImage() {
    return Visibility(
      child: FutureBuilder<File>(
        future: imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if(snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
            return RaisedButton(
              // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                child: Image.file(
                  snapshot.data,
                ),
              ),
              onPressed: () {
                pickImageFromGallery(ImageSource.gallery);
              },
            );
          } else {
            return RaisedButton(
              padding: EdgeInsets.fromLTRB(0, 160, 0, 160),
              child: Text(
                'Upload 1 photo to illustrate your event',
              ),
              onPressed: () {
                pickImageFromGallery(ImageSource.gallery);
              },
            );
          }
        }
      ),
      visible: isVisible,
    );
  }

  Widget _buildTitle() {
    return Visibility(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Title of the event',
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => {},
            )
          ),
          validator: (String value) {
            if(value.isEmpty) {
              return 'Title is required';
            }
          },
        )
      ),
      visible: isVisible,
    );
  }

  Widget _buildDescription() {
    return Visibility(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Description',
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => {},
            )
          ),
          validator: (String value) {
            if(value.isEmpty) {
              return 'Title is required';
            }
          },
        ),
      ),
      visible: isVisible,
    );
  }

  Widget _buildCategory() {
    return Visibility(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: DropdownButton(
          isExpanded: true,
          value: _category,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
            textDirection: TextDirection.rtl,
          ),
          iconSize: 24,
          elevation: 16,
          items: categories.map((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: new Text(val),
            );
          }).toList(),
          onChanged: (String newVal) {
            setState(() {
              _category = newVal;
            });
          },
        ),
      ),
      visible: isVisible,
    );
  }

  Widget _buildYoutubeVideo() {
    return Visibility(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'YouTube video',
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => {},
            )
          ),
        ),
      ),
      visible: isVisible,
    );
  }

  Widget _buildLinkToSource() {
    return Visibility(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Link to source page',
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => {},
            )
          ),
        ),
      ),
      visible: isVisible,
    );
  }

  Widget _buildTag() {
    return Visibility(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ChipsInput(
          initialValue: [
            'John Doe', 'jaekkuk', 'seolmin'
          ],
          decoration: InputDecoration(
            labelText: "Select People",
          ),
          maxChips: 3,
          onChanged: (data) {
              print(data);
          },
          chipBuilder: (context, state, profile) {
            return InputChip(
                key: ObjectKey(profile),
                label: Text(profile),
                onDeleted: () => state.deleteChip(profile),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
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
                'General*',
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
        _buildEventImage(),
        _buildTitle(),
        _buildDescription(),
        _buildCategory(),
        _buildTag(),
        _buildYoutubeVideo(),
        _buildLinkToSource()
      ],
    );
  }
}