import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rateit/imageuploader.dart';
import 'dart:io';
import 'package:path/path.dart';


class Picturefromgallery extends StatefulWidget {
  @override
  _PicturefromgalleryState createState() => _PicturefromgalleryState();
}

class _PicturefromgalleryState extends State<Picturefromgallery> {
  File _image;
  @override
  Widget build(BuildContext context) {
    
    Future getImage() async{
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;

      });
    }

    Future UploadPictureToFirebase(BuildContext context)async{
      String Filename = basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(FileName);
       StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
       StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
       setState(() {
          print("Profile Picture uploaded");
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
       });
    }



    return Container(
      
    );
  }
}
