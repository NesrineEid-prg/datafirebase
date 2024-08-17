import 'package:datafire/feature/user_auth/firebase_auth/firebase_auth_service.dart';
import 'package:datafire/feature/user_auth/presentation/pages/signup_page.dart';
import 'package:datafire/feature/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _issign = false;
  final TextEditingController _emailcontroller = TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _passcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: const Text('Login',
      //         style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 27,
      //             fontWeight: FontWeight.bold)),
      //     backgroundColor: const Color.fromARGB(255, 9, 178, 230)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                    color: Color.fromARGB(255, 9, 178, 230),
                    fontSize: 38,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
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
                controller: _passcontroller,
                hintTxt: 'Password',
                ispass: true,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  _signIn();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 9, 178, 230)),
                  child: Center(
                    child: _issign
                        ? const CircularProgressIndicator(color: Colors.white)
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
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  signInWithGoogle();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'sign in With Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),
                  const SizedBox(
                    width: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text(
                      'Sign Up',
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

// }
//  -signInWithGoogle()async{
//     final GoogleSignIn _googleSignIn = GoogleSignIn();

//     try{
//       final GoogleSignInAccount? googleSignInAccount= await _googleSignIn.signIn();
// if(GoogleSignInAuthentication != null){
//   GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
//   final AuthCredential credential =GoogleAuthProvider.credential(
//     idToken: googleSignInAuthentication.idToken,
//     accessToken:  googleSignInAuthentication.accessToken
//   );
//   await _firebaseAuth.signupwithCredential(credential);
//   Navigator.pushNamed(context, "/home");
// }
//     }catch(e){
//       Fluttertoast.showToast(msg: 'someerror${e}');
//     }

//   }

  void _signIn() async {
    setState(() {
      _issign = true;
    });

    String email = _emailcontroller.text;
    String password = _passcontroller.text;

    User? user = await _auth.signinwithemailandpass(email, password);

    setState(() {
      _issign = false;
    });

    if (user != null) {
      Fluttertoast.showToast(msg: "User is successfully signed in");
      Navigator.pushNamed(context, "/home");
    } else {
      Fluttertoast.showToast(msg: "some error occured");
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
