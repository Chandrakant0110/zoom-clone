import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_ui/resources/auth_methods.dart';
import 'package:whatsapp_ui/screens/home_screen.dart';
import 'package:whatsapp_ui/screens/login_screen.dart';
import 'package:whatsapp_ui/screens/video_call_screen.dart';
import 'package:whatsapp_ui/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zoom Clone',
      debugShowCheckedModeBanner: false,
      
      theme:  ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/video-call': (context) => const VideoCallScreen(),
      },
      home: StreamBuilder(
        stream:  AuthMethods().authChanges,
        builder: (context , snapshot){
          
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData){
            return const HomeScreen();
          }
          return const LoginScreen(); 
        },
      ),
      
    );
  }
}
