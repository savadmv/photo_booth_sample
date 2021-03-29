import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_for_jithin/app_switch_button.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    File _image;
    final picker = ImagePicker();

    Future getImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.camera);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            elevation: 2.0,
            child: new Icon(Icons.camera_alt_outlined),
            backgroundColor: new Color(0xFFE57373),
            onPressed: () {
              getImage();
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Center(
            child: CustomSwitch(
              value: false,
              activeText: "METRIC",
              inactiveText: "NON-METRIC",
              width: 200,
              height: 52,
              onChanged: (val) {
                print("$val");
              },
            ),
          ),
        ),
      ),
    );
  }
}
