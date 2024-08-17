import 'package:datafire/feature/app/splash_screen.dart';
import 'package:datafire/feature/user_auth/presentation/pages/login_page.dart';
import 'package:datafire/feature/user_auth/presentation/pages/myhomepage.dart';
import 'package:datafire/feature/user_auth/presentation/pages/signup_page.dart';
import 'package:datafire/feature/user_auth/presentation/pages/update_page.dart';
// import 'package:datafire/myhome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBMzlLIBydGdcjcWEGs8WNCQlGOGAkIVFs",
          authDomain: "datafire-762a1.firebaseapp.com",
          projectId: "datafire-762a1",
          storageBucket: "datafire-762a1.appspot.com",
          messagingSenderId: "879774412425",
          appId: "1:879774412425:web:771c0977bfa193920ba058"));

  runApp(const MyApp());
}
// nesrine@gmail.com
// 123456

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => SplashScreen(child: const LoginPage()),
          '/login': (context) => const LoginPage(),
          '/signUp': (context) => const SignUpPage(),
          '/home': (context) => const MyHomePage(),
          '/update': (context) => const UpDateData()
        });
  }
}
