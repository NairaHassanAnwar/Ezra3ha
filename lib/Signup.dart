import 'package:application_project/Home.dart';
import 'package:application_project/Signin.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final fullName = TextEditingController();
  final email = TextEditingController();
  final age  = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  String gender = "Male";
  bool ? outdoor = false;
  bool ? indoor = false;
  bool ? office = false;
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  void registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    if (password.text != confirmPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    try {
      final userCred = await auth.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      await firestore.collection('users').doc(userCred.user!.uid).set({
        'uid': userCred.user!.uid,
        'email': email.text.trim(),
        'name': fullName.text.trim(),
        'age': int.parse(age.text.trim()),
        'gender': gender,
        'outdoor': outdoor,
        'indoor': indoor,
        'office': office
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Signin()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          // Decorative plant image in top right
          Positioned(
            top: 30,
            right: 10,
            child: Image.network(
              "https://th.bing.com/th/id/R.ee0b5153d2261f8715e27191327e52a9?rik=fL4x5Y5z%2b%2bGZVg&pid=ImgRaw&r=0",
              width: 150,
              fit: BoxFit.contain,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF3A5A40),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),

                      SizedBox(height: 30),

                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text('Register',
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF212121),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('Create new account',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF004D40),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 40),

                      TextFormField(
                        controller: fullName,
                        validator: (value) =>
                        (value == null || value.isEmpty) ? 'Required' : null,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF3A5A40)),
                          ),
                        ),
                      ),

                      SizedBox(height: 16),

                      TextFormField(
                        controller: email,
                        validator: (value) =>
                        (value == null || value.isEmpty) ? 'Required' : null,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Color(0xFF3A5A40)),
                          ),
                        ),
                      ),

                      SizedBox(height: 16),

                      TextFormField(
                        controller: age,
                        validator: (value) =>
                        (value == null || value.isEmpty) ? 'Required' : null,
                        decoration: InputDecoration(
                          labelText: 'Age',
                          prefixIcon: Icon(Icons.cake, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Color(0xFF3A5A40)),
                          ),
                        ),
                      ),

                      SizedBox(height: 16,),

                      Row(
                        children: [
                          Icon(Icons.wc,color: Colors.grey,),
                          SizedBox(width: 10),
                          Text("Gender: "),
                          Radio(
                              value: 'Male',
                              groupValue: gender,
                              onChanged: (val) => setState(() => gender = val!)
                          ),
                          Text("Male"),
                          Radio(value: 'Female',
                              groupValue: gender,
                              onChanged: (val) => setState(() => gender = val!)
                          ),
                          Text("Female"),
                        ],
                      ),

                      SizedBox(height: 16,),

                      Row(
                        children: [
                          Text("What Planets do you prefer?"),
                          Icon(Icons.school, color: Colors.grey),
                        ],
                      ),

                      Row(
                        children: [
                          Checkbox(
                              value: outdoor,
                              onChanged: (val) => setState(() => outdoor = val!
                          )),
                          Text("Outdoor"),
                          Checkbox(
                              value: indoor,
                              onChanged: (val) => setState(() => indoor = val!
                          )),
                          Text("Indoor"),
                          Checkbox(
                              value: office,
                              onChanged: (val) => setState(() => office = val!
                          )),
                          Text("Offuce"),
                        ],
                      ),

                      SizedBox(height: 16,),

                      TextFormField(
                        controller: password,
                        validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon:
                          Icon(Icons.lock_outline, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF3A5A40)),
                          ),
                        ),
                      ),

                      SizedBox(height: 16),

                      TextFormField(
                        controller: confirmPassword,
                        validator: (value) =>
                        (value == null || value.isEmpty) ? 'Required' : null,
                        obscureText: !_isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF3A5A40)),
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: registerUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF3A5A40),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('SIGN UP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      Center(
                        child: Text('or',
                          style: TextStyle(
                              color: Color(0xFF004D40), fontSize: 16),
                        ),
                      ),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Icon(Icons.facebook, size: 24, color: Colors.blueAccent),
                            ),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Image.network(
                                "https://cdn1.iconfinder.com/data/icons/google-new-logos-1/32/google_search_new_logo-512.png",
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already Have an Account? ',
                            style: TextStyle(
                                color: Color(0xFF004D40), fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Signin(),),
                              );
                            },
                            child: Text('Login',
                              style: TextStyle(
                                color: Color(0xFF004D40),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
