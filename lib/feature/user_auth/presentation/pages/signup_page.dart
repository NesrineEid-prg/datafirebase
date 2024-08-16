import 'package:datafire/feature/user_auth/firebase_auth/firebase_auth_service.dart';
import 'package:datafire/feature/user_auth/presentation/pages/login_page.dart';
import 'package:datafire/feature/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _issignup = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _passcontroller = TextEditingController();

  @override
  void dispose() {
    _usernamecontroller.dispose();
    _emailcontroller.dispose();
    _passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up',
            style: TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 9, 178, 230),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                    color: Color.fromARGB(255, 9, 178, 230),
                    fontSize: 38,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                hintTxt: 'Username',
                controller: _usernamecontroller,
                ispass: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _emailcontroller,
                hintTxt: 'Email',
                ispass: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                hintTxt: 'Password',
                controller: _passcontroller,
                ispass: true,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  _signup();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 9, 178, 230)),
                  child: Center(
                    child: _issignup
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          // ignore: prefer_const_constructors
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signup() async {
    setState(() {
      _issignup = true;
    });
    String username = _usernamecontroller.text;
    String email = _emailcontroller.text;
    String password = _passcontroller.text;
    User? user = await _auth.signupwithemailandpass(email, password);
    setState(() {
      _issignup = false;
    });
    if (user != null) {
      Fluttertoast.showToast(msg: 'user is succefully👍👍');
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/home");
    } else {
      Fluttertoast.showToast(msg: 'some error');
    }
  }
}
