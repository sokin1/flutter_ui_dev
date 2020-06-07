import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VenueWidget extends StatefulWidget {
  VenueWidget({Key key}) : super(key: key);

  @override
  _VenueWidgetState createState() => _VenueWidgetState();
}

class _VenueWidgetState extends State<VenueWidget> {
  bool isVisible = false;
  bool isExpanded = false;

  Future<File> imageFile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget _buildNameOfVenue() {
    return Visibility(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Name of the venue*',
            suffixIcon: Icon(Icons.clear),
          ),
        ),
      ),
      visible: isVisible,
    );
  }

  Widget _buildAddress() {
    return Visibility(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'street address of the venue',
            suffixIcon: Icon(Icons.clear),
          ),
        ),
      ),
      visible: isVisible,
    );
  }

  Widget _buildAvatar() {
    return Visibility(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
          children: <Widget>[
            Container(
              child: Text('Avatar of the venue'),
            ),
            Container(
              width: 50,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: FutureBuilder<File>(
                future: imageFile,
                builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                    return GestureDetector(
                      onTap: () {
                        pickImageFromGallery(ImageSource.gallery);
                      },
                      child: Image.file(
                        snapshot.data,
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        pickImageFromGallery(ImageSource.gallery);
                      },
                      child: Icon(Icons.camera)
                    );
                  }
                }
              )
            )
          ],
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