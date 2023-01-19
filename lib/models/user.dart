import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String username;
  final String email;
  final String photoUrl;

  User({
    required this.uid,
    required this.username,
    required this.email,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'username': username,
    'email': email,
    'photoUrl': photoUrl,
  };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      uid: snapshot['uid'],
      username: snapshot['username'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
    );
  }
}
