import 'package:application_project/Signup.dart';
import 'package:application_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:application_project/Signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Main(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center( // Center the entire column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo and Title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://cdn1.iconfinder.com/data/icons/summer-filled-line/614/1500_-_Leaves-1024.png",
                    height: width * 0.08, // Reduced size for logo
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'EZRA3HA',
                    style: TextStyle(
                      fontSize: width * 0.05, // Reduced font size for title
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.05), // Proportional spacing

              // Slogan - Centered with green color and dynamic resizing
              Text(
                'The best app for',
                style: TextStyle(
                  fontSize: width * 0.031, // Reduced font size for slogan
                  color: const Color(0xFF004D40), // Green color
                ),
              ),
              Text(
                'your Plants',
                style: TextStyle(
                  fontSize: width * 0.031, // Reduced font size for slogan
                  color: const Color(0xFF004D40), // Green color
                ),
              ),
              SizedBox(height: height * 0.08), // Proportional spacing

              // Sign Up Button
              SizedBox(
                width: width * 0.4, // Reduced width for button
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Signup()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004D40),
                    padding: EdgeInsets.symmetric(vertical: height * 0.008), // Smaller vertical padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'sign up',
                    style: TextStyle(
                      fontSize: width * 0.03, // Reduced font size for button text
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Login Button
              SizedBox(
                width: width * 0.4, // Reduced width for button
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Signin()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004D40),
                    padding: EdgeInsets.symmetric(vertical: height * 0.008), // Smaller vertical padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'login',
                    style: TextStyle(
                      fontSize: width * 0.03, // Reduced font size for button text
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}