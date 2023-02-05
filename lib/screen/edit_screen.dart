import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

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

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerBirthday = TextEditingController();
  final controllerImage = TextEditingController();
  String ImageUrl = " ";

  Future updateUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('data-user').doc(Get.arguments['id']);
    user.id = docUser.id;

    final json = user.toJson();
    await docUser.update(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 5),
            Text(
              'User id : ' + Get.arguments['id'].toString(),
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 50,
              height: 50,
              child: TextField(
                readOnly: true,
                controller: controllerImage..text = "${Get.arguments['profile'].toString()}",
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
                controller: controllerName..text = "${Get.arguments['name'].toString()}",
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
                controller: controllerAge..text = "${Get.arguments['age'].toString()}",
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
                  controller: controllerBirthday..text = "${Get.arguments['birthday'].toString()}",
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
                onPressed: () {
                  if(ImageUrl == " "){
                    ImageUrl = Get.arguments['profile'].toString();
                  }
                  final user = User(
                    name: controllerName.text,
                    age: int.parse(controllerAge.text),
                    birthday: DateTime.parse(controllerBirthday.text),
                    profile: ImageUrl,
                  );
                  updateUser(user);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data Updated'),
                    ),
                  );
                },
                child: const Text('Edit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
