import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        appBar: AppBar(
          title: Text(
            "My Shots",
            style: theme.textTheme.headline5,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: Image.network(
                      "https://homepages.cae.wisc.edu/~ece533/images/goldhill.png",
                      fit: BoxFit.fill,
                      width: size.width - 50,
                    ),
                  ),
                ),
              );
            },
            itemCount: 10,
          ),
        ),
      ),
    );
  }
}
