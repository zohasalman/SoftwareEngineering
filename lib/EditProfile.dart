import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'user.dart';
import 'EditProfileQueries.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Pathway;
import 'rateit.dart';
import 'hostit.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key, this.title, this.userInfoRecieved}) : super(key: key);

  final String title;
  UserData userInfoRecieved;

  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  List<String> genders = ['Male', 'Female', 'Other'];
  final genderSelected = new TextEditingController();
  final editfirstname = new TextEditingController();
  final editlastname = new TextEditingController();
  final editpw = new TextEditingController();
  final editemail = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  bool validate = false;

  //bool validator = false;

  String _uploadedFileURL = '';
  File _image;
  bool error1 = true, error2 = true;
  bool check = true;
  DateTime dateTime;

  String _firstName, _lastName, _email, _password, _gender, _profilePicture;
  DateTime _dateOfBirth;

  final _formKey = GlobalKey<FormState>();
  final EditUserData _updateData = EditUserData();

  Future<void> _showChoiceDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Select'),
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  GestureDetector(
                      child: Text('Gallery'),
                      onTap: () {
                        _openGallery(context);
                      }),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                      child: Text('Camera'),
                      onTap: () {
                        _openCamera(context);
                      })
                ],
              )));
        });
  }

  Future _openGallery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
  }

  Future _openCamera(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    // String selectCity;

    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('UserData/${Pathway.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        print(_uploadedFileURL);
      });
    });
  }

  void submit() async {
    if (_image != null){
      await uploadFile();
      if (_uploadedFileURL.isNotEmpty) {
        _profilePicture = _uploadedFileURL;
      }
    }
    print('hii');
    _updateData.update(widget.userInfoRecieved.uid, _firstName, _lastName, _email, _password,
        _gender, _profilePicture, _dateOfBirth);
    // Storing data in user class object
    widget.userInfoRecieved.update(_firstName, _lastName, _email, _gender, _profilePicture);
  }

  List<DropdownMenuItem<String>> n = [];
  void loadData() {
    n = [];
    n.add(new DropdownMenuItem(child: new Text('Male'), value: 'Male'));
    n.add(new DropdownMenuItem(child: new Text('Female'), value: 'Female'));
    n.add(new DropdownMenuItem(child: new Text('Other'), value: 'Other'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: true,
            key: _formKey,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(370.0),
                child: ClipPath(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      AppBar(
                        centerTitle: true,
                        bottom: PreferredSize(
                            preferredSize: Size.fromHeight(0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 300.0, left: 18),
                                  child: Text('Edit Profile',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 28))),
                            )),
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        flexibleSpace: Container(
                            decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.topLeft,
                              colors: [
                                Color(0xFFAC0D57),
                                Color(0xFFFC4A1F),
                              ]),
                          image: DecorationImage(
                            image: AssetImage(
                              "asset/image/Chat.png",
                            ),
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(top: 110.0),
                              child: GestureDetector(
                                  onTap: () {
                                    print("Upload Photo");
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 70.0,
                                    backgroundImage: NetworkImage(
                                        '${widget.userInfoRecieved.profilePicture}'),
                                  ))),
                          Container(
                              child: Transform.translate(
                                  offset: Offset(50.0, -60.0),
                                  child: MaterialButton(
                                    onPressed: () {
                                      _showChoiceDialogue(context);
                                    },
                                    color: Color(0xFFFC4A1F),
                                    textColor: Colors.white,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 24,
                                    ),
                                    padding: EdgeInsets.all(16),
                                    shape: CircleBorder(),
                                  ))),
                          Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Transform.translate(
                                  offset: Offset(0.0, -50.0),
                                  child: Text(
                                      widget.userInfoRecieved.firstName +
                                          ' ' +
                                          widget.userInfoRecieved.lastName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      )))),
                          Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Transform.translate(
                                  offset: Offset(0.0, -50.0),
                                  child: Text(widget.userInfoRecieved.email,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      )))),
                        ],
                      )
                    ],
                  ),
                  clipper: Clipshape(),
                )),
            endDrawer: SideBar2(),
            body: Form(
              autovalidate: validate,
              child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      child: ListTile(
                          leading: Icon(Icons.person, color: Color(0xFFFC4A1F)),
                          title: Row(children: <Widget>[
                            Expanded(
                                child: TextFormField(
                              controller: editfirstname,
                              validator: (val)
                              {
                                if (val.isEmpty)
                                {
                                  val = widget.userInfoRecieved.firstName;
                                }
                                else
                                {
                                  _firstName = val.trim();
                                }
                              },
                              onChanged: (val) {
                                if (val.isEmpty)
                                {
                                  widget.userInfoRecieved.firstName = widget.userInfoRecieved.firstName;
                                }
                                else
                                {
                                  _firstName = val.trim();
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Edit First Name',
                                hintText: widget.userInfoRecieved.firstName,
                                labelStyle: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ))
                          ]),
                          //trailing: Icon(Icons.edit, color: Color(0xFFFC4A1F)),
                          onTap: () {}),
                    ),
                    Card(
                      child: ListTile(
                          leading: Icon(Icons.person, color: Color(0xFFFC4A1F)),
                          title: TextFormField(
                            controller: editlastname,
                             onChanged: (val)
                            {
                                if (val.isEmpty)
                                {
                                  widget.userInfoRecieved.lastName = widget.userInfoRecieved.lastName;
                                }
                                else
                                {
                                _lastName = val.trim();
                                }
                              },
                            decoration: InputDecoration(
                              labelText: 'Edit Last Name',
                              hintText: widget.userInfoRecieved.lastName,
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          //trailing: Icon(Icons.edit, color: Color(0xFFFC4A1F)),
                          onTap: () {}),
                    ),
                    Card(
                      child: ListTile(
                          leading: Icon(Icons.lock_outline,
                              color: Color(0xFFFC4A1F)),
                          title: TextFormField(
                             validator: (input)=> input.length<6? 'Please enter a password with at least 6 characters': null,
                            controller: editpw,
                            decoration: InputDecoration(
                              labelText: 'Change Password',
                              hintText: '*********',
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          //trailing: Icon(Icons.edit, color: Color(0xFFFC4A1F)),
                          onTap: () {
                            TextField();
                          }),
                    ),
                    Card(
                        child: ListTile(
                            leading: Icon(Icons.mail, color: Color(0xFFFC4A1F)),
                            title: TextFormField(
                              validator: (input)=> !EmailValidator.validate(input, true)? 'Please enter a valid email address' :null,
                              controller: editemail,
                              keyboardType: TextInputType.emailAddress,

                               onChanged: (val) 
                               {
                                if (val.isEmpty)
                                {
                                  widget.userInfoRecieved.email = widget.userInfoRecieved.email;
                                }
                                else
                                {
                                _email = val.trim();
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Update Email',
                                hintText: widget.userInfoRecieved.email,
                               
                                labelStyle: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ))),

                    Card(
                      child: ListTile(
                        leading: Icon(Icons.calendar_today,
                            color: Color(0xFFFC4A1F)),
                        title: RaisedButton(
                            color: Colors.white,
                            child: Text(
                                dateTime == null
                                    ? 'DD-MM-YYYY'
                                    : DateFormat('dd-MM-yyyy')
                                        .format(dateTime),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18)),
                            onPressed: () {
                              //print('here');
                              showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now(),
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.pink,
                                        accentColor: Colors.deepOrange,
                                        splashColor: Colors.deepOrange,
                                      ),
                                      child: child,
                                    );
                                  }).then((date) {
                                setState(() {
                                  dateTime = date;
                                });
                              });
                            }
                            // trailing: Icon(Icons.edit, color: Color(0xFFFC4A1F)),
                            // onTap: () {

                            // }
                            ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                          leading: Icon(Icons.lock_outline,
                              color: Color(0xFFFC4A1F)),
                          title: DropDownField(
                              controller: genderSelected,
                              hintText: widget.userInfoRecieved.gender,
                              enabled: true,
                              items: genders,
                              onValueChanged: (val) 
                              {
                                if (val.isEmpty)
                                {
                                  widget.userInfoRecieved.gender = widget.userInfoRecieved.gender;
                                }
                                else
                                {
                                _gender = val.trim();
                                }
                              },
                              )),
                    ),
                    SafeArea(
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            validate = true;
                            
                            if (!EmailValidator.validate(widget.userInfoRecieved.email, true))
                            {
                              check = false;
                            }
                          });
                          if (check)
                          {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                    "Details have been saved successfully!"),
                                actions: <Widget>[
                                  Center(
                                      child: FlatButton(
                                    onPressed: () {
                                          setState ( () {
                                            _gender = genderSelected.text;
                                           
                                            _firstName = editfirstname.text;
                                            widget.userInfoRecieved.firstName = _firstName;
                                            
                                            
                                            _lastName = editlastname.text;
                                            widget.userInfoRecieved.lastName = widget.userInfoRecieved.lastName;
                                           
                                            
                                            _email = editemail.text;
                                            widget.userInfoRecieved.email = _email;
  
                                           
                                            _gender= genderSelected.text;
                                            widget.userInfoRecieved.gender = _gender;

                                            //widget.userInfoRecieved.dateOfBirth = _dateOfBirth;
                                  
                                        });

                                        print(_firstName);
                                        print(_lastName);
                                        print(_email);
                                        submit();
                                        Navigator.of(context).pop(false);
                                        },                           
                                    child: Text("Ok"),
                                  ))
                                ],
                              );
                            },
                          );
                          }
                        },
                        child: SafeArea(
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 40, right: 40.0, left: 40.0, bottom: 10.0),
                            child: Container(
                                height: 50,
                                width: 350,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.topLeft,
                                      colors: [
                                        Color(0xFFAC0D57),
                                        Color(0xFFFC4A1F),
                                      ]),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: EdgeInsets.only(top: 15, left: 135, bottom: 10.0),
                                child: Text("Submit",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18))),
                          ),
                        ),
                      ),
                    ),
                  ]),
            )));
  }
}