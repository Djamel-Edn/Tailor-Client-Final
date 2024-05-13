import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:projetfinprepa/Pages/FirstPage.dart';
import 'package:projetfinprepa/Pages/registration/forget.dart';
import 'package:projetfinprepa/Pages/registration/file.dart';

import 'package:shared_preferences/shared_preferences.dart';

class sign extends StatefulWidget {
  const sign({Key? key}) : super(key: key);

  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<sign> {
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = false;
  bool _isPasswordVisible = false;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late GoogleSignIn _googleSignIn;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();

    _googleSignIn = GoogleSignIn();
    _loadSavedCredentials();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailController.text = prefs.getString('email') ?? '';
      if (prefs.containsKey('password') && rememberPassword) {
        _passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  Future<void> _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailController.text);
    if (rememberPassword) {
      await prefs.setString('password', _passwordController.text);
    } else {
      await prefs.remove('password');
    }
  }

  Future<void> _signIn() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://255.255.255.0:5001/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FirstPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign in. Please try again.'),
        ),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final String email = googleSignInAccount.email ?? '';
        String? password = await _getSavedPassword(email);

        if (password == null) {
          password = await _fetchPasswordFromBackend(email);
          if (password != null) {
            await _saveCredentials(); // Save email and password locally
          }
        }

        final authenticated = await _authenticateWithBackend(email, password ?? '');
        if (authenticated) {
          _emailController.text = email;
          _passwordController.text = password ?? '';

          FocusScope.of(context).nextFocus();
          FocusScope.of(context).requestFocus(FocusNode());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to sign in with Google. Please try again.'),
            ),
          );
        }
      }
    } catch (error) {
      print(error);
    }
  }

  Future<String?> _getSavedPassword(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }

  Future<bool> _authenticateWithBackend(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://255.255.255.0:5001/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    return response.statusCode == 200;
  }

  Future<String?> _fetchPasswordFromBackend(String email) async {
    // Replace this with your actual backend URL
    final url = Uri.parse('http://your-backend-url/api/fetch-password');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{'email': email}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['password'];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F6),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 5,right: 5),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 90),
              child: Image.asset('images/shad.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0, left: 0, right: 62, top: 410),
              child: Image.asset('images/mimi.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 90),
              child: Form(
                key: _formSignInKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF84643D),
                      ),
                    ),
 SizedBox(height: 20),
                     Text(
          ' Hi ! Welcom back you have been missed ',
          style: TextStyle(
            fontSize: 16,
           
           // color: Colors.black,
          ),
        ), 
                    const SizedBox(
                      height: 50.0,
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text(
                          'Email',
                          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
                        ),
                        hintText: 'Enter Email',
                        suffixIcon: const Icon(Icons.email),
                        hintStyle: const TextStyle(
                          color: Colors.black26,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.brown,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      obscureText: !_isPasswordVisible,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        label: const Text(
                          'Password',
                          style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        hintText: 'Enter Password',
                        hintStyle: const TextStyle(
                          color: Colors.black26,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.brown,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberPassword,
                              onChanged: (bool? value) {
                                setState(() {
                                  rememberPassword = value!;
                                });
                              },
                              activeColor: Color(0xFF84643D),
                            ),
                            const Text(
                              'Remember me',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (e) => const forget(),
                              ),
                            );
                          },
                          child: const Text(
                            'Forget password?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF84643D),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:() {Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FirstPage(),
        ),
      );},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF84643D)),
                        ),
                        child: const Text(
                          'Sign in ',
                          style: TextStyle(color: Color(0xFFFCF9F6), fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                  
                   MaterialButton(
  onPressed: _signInWithGoogle,
  color: Color.fromARGB(255, 231, 218, 206),
  elevation: 3, // Add elevation for a slight shadow
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50), // Set border radius
  ),
  child: Padding(
    padding: const EdgeInsets.only (top: 4.5,  bottom:   4.5),
    child: Row( 
     // mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container( 
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white
          ),
         padding: EdgeInsets.all(5),
          child: Logo(Logos.google
            ,
            size: 25,
         
          ),
        ),
        SizedBox(width: 25,),
        Text(
          'Continue with Google',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    ),
  ),
),

                    const SizedBox(
                      height: 100.0,
                    ),
                    // Don't have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (e) => const fily(),
                              ),
                            );
                          },
                          child: Text(
                            '  Sign up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF84643D),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
