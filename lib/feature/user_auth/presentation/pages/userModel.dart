import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? username;
  String? adress;
  int? age;
  String? id;

  UserModel({this.id, this.username, this.adress, this.age});
  static UserModel fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      username: snapshot['username'],
      adress: snapshot['adress'],
      age: snapshot['age'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "age": age,
      "id": id,
      "adress": adress,
    };
  }
}
