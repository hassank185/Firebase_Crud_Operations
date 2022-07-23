


import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? id;
  final String? username;
  final String? age;

  UserModel({this.id, this.username, this.age});

  factory UserModel.fromSnapshots(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      username: snapshot['username'],
      age: snapshot['age'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'username' : username,
    'age' : age,
    'id': id,
  };

}
