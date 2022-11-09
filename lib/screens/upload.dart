import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:maize_app/main.dart';
import 'package:maize_app/utils/fuctions.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? image;
  final imagePicker = ImagePicker();
  String? downloadUrl;

  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();

  Future imagePickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        image = File(pick.path);
      } else {
        scaffoldMessage(context: context, message: 'No file selceted');
      }
    });
  }

  Future imageCaptureMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pick != null) {
        image = File(pick.path);
      } else {
        scaffoldMessage(context: context, message: 'No file selceted');
      }
    });
  }

  Future uploadImageMethod() async {
    if (image == null) {
      scaffoldMessage(context: context, message: 'No file selceted');
      return;
    }

    String postId = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('${MyApp.uid}/images')
        .child('post_$postId');
    await ref.putFile(image!);
    downloadUrl = await ref.getDownloadURL();

    final post = {
      'title': _titleController.text,
      'sub_title': _subtitleController.text,
      'img_url': downloadUrl,
      'owner': 'Godawari Udyog',
      'likes': 0,
      'month': DateTime.now().toString().split(' ')[0].split('-')[1]
    };

    DocumentReference docRefawait = await FirebaseFirestore.instance
        .collection('admins')
        .doc(MyApp.uid)
        .collection('posts')
        .add(post);
    FirebaseFirestore.instance
        .collection('admins')
        .doc(MyApp.uid)
        .collection('posts')
        .doc(docRefawait.id)
        .update(
      {'id': docRefawait.id},
    ).whenComplete(
            () => scaffoldMessage(context: context, message: 'Post Created!!'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                height: 500,
                width: double.infinity,
                child: Column(
                  children: [
                    Text('upload new post'),
                    SizedBox(height: 10),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: image == null
                                    ? Center(child: Text('No image selected'))
                                    : Image.file(image!),
                              ),
                              TextField(
                                controller: _titleController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Title',
                                ),
                              ),
                              SizedBox(height: 10, width: double.infinity),
                              TextField(
                                controller: _subtitleController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'caption',
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      margin: EdgeInsets.all(5),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          imagePickerMethod();
                                        },
                                        child: Text('Selecte image'),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      margin: EdgeInsets.all(5),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          imageCaptureMethod();
                                        },
                                        child: Text('Capture image'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10, width: double.infinity),
                              Container(
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    uploadImageMethod();
                                  },
                                  child: Text('Create Post'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
