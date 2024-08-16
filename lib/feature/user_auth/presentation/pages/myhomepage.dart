import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datafire/feature/user_auth/presentation/pages/update_page.dart';
import 'package:datafire/feature/user_auth/presentation/pages/userModel.dart';
import 'package:datafire/feature/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  static Future<void> updateData(UserModel usermodel) async {
    final userCollection = FirebaseFirestore.instance.collection("users");
    final newData = UserModel(
      username: usermodel.username,
      age: usermodel.age,
      adress: usermodel.adress,
      id: usermodel.id,
    ).toJson();
    userCollection.doc(usermodel.id).update(newData);
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _pays = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('HomePage'),
          backgroundColor: const Color.fromARGB(255, 9, 178, 230)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              FormContainerWidget(hintTxt: 'username', controller: _name),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(hintTxt: 'adress', controller: _pays),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              StreamBuilder<List<UserModel>>(
                  stream: _readData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final users = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        height: 500,
                        child: ListView.builder(
                          itemCount: users?.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: GestureDetector(
                                  onTap: () {
                                    _deleteData(users![index].id!);
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    size: 50,
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(context, "/update");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UpDateData(
                                            users: users![index],
                                          ),
                                        ));
                                    // print(users[0]);
                                    // _updateData(UserModel(
                                    //     id: user.id,
                                    //     username: _name.text,
                                    //     adress: _pays.text));
                                  },
                                  child: const Icon(
                                    Icons.update,
                                    size: 50,
                                  ),
                                ),
                                title: Text(
                                  users![index].username!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                  ),
                                ),
                                subtitle: Text(
                                  users[index].adress!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ));
                          },
                        ),
                      ),
                    );
                  }),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                GestureDetector(
                  onTap: () {
                    _createData(UserModel(
                        username: _name.text, adress: _pays.text, age: 12));
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 9, 178, 230)),
                    child: const Center(
                        child: Text(
                      'Create Data',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, "/login");
                    Fluttertoast.showToast(msg: 'SUCCEFULLY SIGN OUT');
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 9, 178, 230)),
                    child: const Center(
                        child: Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    )),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }

  Stream<List<UserModel>> _readData() {
    final userCollection = FirebaseFirestore.instance.collection("users");
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapShot(e)).toList());
  }

  void _createData(UserModel userModel) {
    final userCollection = FirebaseFirestore.instance.collection("users");
    userModel.username = _name.text;
    userModel.adress = _pays.text;
    String id = userCollection.doc().id;

    final newUser = UserModel(
      username: userModel.username.toString(),
      age: userModel.age,
      adress: userModel.adress.toString(),
      id: id,
    ).toJson();

    userCollection.doc(id).set(newUser);
  }

  // void updateData(UserModel usermodel) {
  //   final userCollection = FirebaseFirestore.instance.collection("users");
  //   final newData = UserModel(
  //     username: usermodel.username,
  //     age: usermodel.age,
  //     adress: usermodel.adress,
  //     id: usermodel.id,
  //   ).toJson();
  //   userCollection.doc(usermodel.id).update(newData);
  // }

  void _deleteData(String id) {
    final userCollection = FirebaseFirestore.instance.collection("users");
    userCollection.doc(id).delete();
  }
}
