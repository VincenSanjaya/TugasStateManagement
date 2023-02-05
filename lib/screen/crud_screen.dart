import 'package:flutter/material.dart';
import 'package:tugas_state_management/screen/add_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:tugas_state_management/screen/edit_screen.dart';
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

class CRUDPage extends StatefulWidget {
  const CRUDPage({Key? key}) : super(key: key);

  @override
  State<CRUDPage> createState() => _CRUDPageState();
}

class _CRUDPageState extends State<CRUDPage> {
  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('data-user')
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => fromJson(doc.data())).toList());

  static User fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    age: json['age'],
    birthday: (json['birthday'] as Timestamp).toDate(),
    profile: json['profile'],
  );

  //make widget buildUser with button edit and delete
  Widget buildUser(User user) => Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(user.profile),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.name),
            Text(user.age.toString()),
            Text(DateFormat('dd-MM-yyyy').format(user.birthday)),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Get.to(() => EditPage(), arguments: {
                  'id': user.id,
                  'name': user.name,
                  'age': user.age,
                  'birthday': user.birthday,
                  'profile': user.profile,
                });
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                //make alert
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete'),
                      content: const Text('Are you sure want to delete this data?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            final docUser = FirebaseFirestore.instance.collection('data-user').doc(user.id);
                            docUser.delete();
                            Navigator.pop(context);
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('List User'),
      ),
      body: StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if(snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
