import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class User {
  String id;
  final String name;
  final int age;
  final DateTime birthday;
  final String profile;

  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.birthday,
    required this.profile,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'birthday': birthday,
      'profile': profile,
    };
  }
}

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('data-user').doc();
    user.id = docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }

  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerBirthday = TextEditingController();
  final controllerImage = TextEditingController();
  String ImageUrl = " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Input Biodata'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            width: 50,
            height: 50,
            child: TextField(
              readOnly: true,
              controller: controllerImage,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: IconButton(onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                    print('{file?.path}');
                    if(file == null) return;
                    String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
                    Reference refRoot = FirebaseStorage.instance.ref();
                    Reference refDirImg = refRoot.child('images');
                    Reference refFile = refDirImg.child(uniqueId);
                    try {
                      await refFile.putFile(File(file!.path));
                      ImageUrl = await refFile.getDownloadURL();
                    } catch (error) {
                      //
                    }
                  },
                    icon: const Icon(Icons.add_a_photo),),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: controllerName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: controllerAge,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Age',
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
                controller: controllerBirthday,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Birthday',
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    final format = DateFormat('yyyy-MM-dd');
                    controllerBirthday.text = format.format(date);
                  }
                }
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 370,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                if(ImageUrl.isEmpty)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please Upload Image'),
                    ),
                  );
                  return;
                }
                final user = User(
                  name: controllerName.text,
                  age: int.parse(controllerAge.text),
                  birthday: DateTime.parse(controllerBirthday.text),
                  profile: ImageUrl,
                );
                createUser(user);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data Added'),
                  ),
                );
              },
              child: const Text('Tambah'),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}