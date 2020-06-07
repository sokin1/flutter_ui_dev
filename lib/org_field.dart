import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class OrgWidget extends StatefulWidget {
  OrgWidget({Key key}) : super(key: key);

  @override
  _OrgWidgetState createState() => _OrgWidgetState();
}

class _OrgWidgetState extends State<OrgWidget> {
  bool isVisible = false;
  bool isExpanded = false;

  Future<File> imageFile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget _buildNameOfOrganizer() {
    return Visibility(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Name of the organizer',
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
              child: Text('Avatar of the organizer'),
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
        )
      ),
      visible: isVisible,
    );
  }

  @override
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
                'Organizer*',
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
        _buildNameOfOrganizer(),
        _buildAvatar()
      ],
    );
  }
}