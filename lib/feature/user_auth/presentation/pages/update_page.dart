import 'package:datafire/feature/user_auth/presentation/pages/myhomepage.dart';
import 'package:datafire/feature/user_auth/presentation/pages/userModel.dart';
import 'package:datafire/feature/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:flutter/material.dart';

class UpDateData extends StatelessWidget {
  final UserModel? users;
  static TextEditingController? userNameUpdataController =
      TextEditingController();
  static TextEditingController? adressUpdataController =
      TextEditingController();
  const UpDateData({super.key, this.users});
  static UserModel? oldUsermodel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('this is page update'),
              FormContainerWidget(
                controller: userNameUpdataController,
                hintTxt: users?.username ?? 'userName',
              ),
              const SizedBox(
                height: 20,
              ),
              FormContainerWidget(
                controller: adressUpdataController,
                hintTxt: users?.adress ?? 'address',
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    UserModel usermodel = UserModel(
                        username:
                            userNameUpdataController!.text ?? users?.username,
                        adress: adressUpdataController!.text ?? users?.adress,
                        id: users?.id);
                    MyHomePage.updateData(usermodel).then((onValue) {
                      Navigator.pop(context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.amber),
                  child: const Text('Update'))
            ],
          ),
        ),
      ),
    );
  }
}
