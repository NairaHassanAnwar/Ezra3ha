import 'dart:developer';
import 'package:application_project/BottomNavBar.dart';
import 'package:application_project/Signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:application_project/Home.dart';
import 'package:application_project/Location.dart';
import 'package:application_project/Search.dart';
import 'package:application_project/Bag.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _fbStore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  Map<String,dynamic> ? userData = {};

  void initState(){
    super.initState();
    _fetchUserDataFromFirebase();
  }

  void _fetchUserDataFromFirebase () async{
    setState(() {
      isLoading = true;
    });
    try{
      final response = await
          _fbStore.collection("users").doc((user!.uid)).get();
      if(response.exists && response.data() != null){
        userData = response.data();
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User has no Data Stored")));
      }
    }
    catch(e){
      log("Error from Fetch User Data $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fetch User Error: $e"))
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Location()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Search()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Bag()),
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome ${user?.email}"),
          actions: [
            IconButton(
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => Signin())
                  );
                },
                icon: Icon(Icons.logout)
            )
          ],
        ),
        body: isLoading ? Center(
          child: CircularProgressIndicator(),
        ): userData != null && userData!.isNotEmpty ? Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0)
            ),
            elevation: 4,
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.green),
                      title: Text("Name"),
                      subtitle: Text("${userData!['name']}"),
                    ),
                    ListTile(
                      leading: Icon(Icons.email, color: Colors.green),
                      title: Text("Email"),
                      subtitle: Text("${userData!['email']}"),
                    ),
                    ListTile(
                      leading: Icon(Icons.cake, color: Colors.green),
                      title: Text("Age"),
                      subtitle: Text("${userData!['age']}"),
                    ),
                    ListTile(
                      leading: Icon(Icons.wc, color: Colors.green),
                      title: Text("Gender"),
                      subtitle: Text("${userData!['gender']}"),
                    ),
                    ListTile(
                      leading: Icon(Icons.park, color: Colors.green),
                      title: Text("You Interested in Outdoor Plant Type"),
                      subtitle: Text("${userData!['outdoor']}"),
                    ),
                    ListTile(
                      leading: Icon(Icons.home, color: Colors.green),
                      title: Text("You Interested in Outdoor Plant Type"),
                      subtitle: Text("${userData!['indoor']}"),
                    ),
                    ListTile(
                      leading: Icon(Icons.work, color: Colors.green),
                      title: Text("You Interested in Outdoor Plant Type"),
                      subtitle: Text("${userData!['office']}"),
                    ),
                  ],
                )
            ),
          ),
        )
            :Center(
              child: Text("This User has No Data"),
            ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: 4,
          onItemTapped: (index) => _onItemTapped(context, index),
        )
    );
  }
}

