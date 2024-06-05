import 'dart:convert';

import 'package:dzair_data_usage/daira.dart';
import 'package:dzair_data_usage/dzair.dart';
import 'package:dzair_data_usage/langs.dart';
import 'package:dzair_data_usage/postCode.dart';
import 'package:dzair_data_usage/wilaya.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icons_plus/icons_plus.dart';
import 'package:projetfinprepa/LogiquesFonctions/RegistaerLogique.dart';
import 'package:projetfinprepa/Pages/FirstPage.dart';
import 'package:projetfinprepa/Pages/registration/sign.dart';
import 'package:projetfinprepa/Pages/registration/verfy.dart';

class SignUpScreen1 extends StatefulWidget {
  const SignUpScreen1({Key? key}) : super(key: key);

  @override
  State<SignUpScreen1> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen1> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  Dzair dzair = Dzair();

  List<Wilaya?>? wilayas;
  List<Daira?>? dairas;
  List<PostCode?>? postcodes;
  String? selectedGender;

  String? selectedWilaya;
  var contexdialog;

  Future<void> _signUp(String email, String password, String fullName,
      String gender, String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse('http://255.255.255.0:5001/register/client'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'Fullname': fullName,
          'Gender': gender,
          'phoneNumber': phoneNumber,
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
            content: Text('Failed to sign up. Please try again.'),
          ),
        );
      }
    } catch (error) {
      print('Error during signup: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('An error occurred during signup. Please try again later.'),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wilayas = dzair.getWilayat();
    dairas = dzair.getDairat();
    postcodes = dzair.getPostCodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F6),
      body: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 0, left: 0, right: 62, top: 410),
            child: Image.asset('images/mimi.png'),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text('SIGN UP', style: TextStyle(fontSize: 30)),
                    )),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Full name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.brown,
                              width: 2), // Change border color when focused
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        prefixIcon: Icon(Icons.account_circle),
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Colors.brown),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue;
                        });
                      },
                      items: <String>['Male', 'Female']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value.isEmpty ? 'Select Gender' : value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.brown,
                              width: 2), // Change border color when focused
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        border: OutlineInputBorder(),
                        labelText: 'Gender',
                        labelStyle: TextStyle(color: Colors.brown),
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: selectedWilaya,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedWilaya = newValue;
                        });
                      },
                      items: wilayas?.map((Wilaya? wilaya) {
                        return DropdownMenuItem<String>(
                          value: wilaya?.getWilayaName(Language.FR),
                          child: Text(wilaya?.getWilayaName(Language.FR) ?? ''),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown, width: 2),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        border: OutlineInputBorder(),
                        labelText: 'Wilaya',
                        labelStyle: TextStyle(color: Colors.brown),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains("@")) {
                          return 'Wrong Email ';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown, width: 2),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.brown),
                        prefixIcon: Icon(Iconsax.direct),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (!value.startsWith('+213')) {
                          return 'Please enter a valid Algerian phone number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown, width: 2),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.brown),
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.brown,
                              width: 2), // Change border color when focused
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        prefixIcon: Icon(Iconsax.eye_slash),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.brown),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.brown,
                              width: 2), // Change border color when focused
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        prefixIcon: Icon(Iconsax.password_check),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.brown),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Builder(
                      builder: (ctx) => Center(
                        child: GestureDetector(
                          onTap: () {
                            // Check if the form is valid before signing up
                            if (_formKey.currentState?.validate() ?? false) {
                              //                _signUp(
                              //   _emailController.text,
                              //   _passwordController.text,
                              //   _nameController.text,
                              //   _phoneNumberController.text,
                              //   selectedGender ?? '' // Ensure selectedGender is not null
                              // );sss
                              showDialog(
                                context: context,
                                builder: (contextk) {
                                  contexdialog = contextk;

                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xFFFFF4DE),
                                    ),
                                  );
                                },
                              );

                              Register.CreateAccountTailor(
                                      _emailController.text,
                                      _nameController.text,
                                      _passwordController.text,
                                      selectedGender,
                                      selectedWilaya,
                                      _phoneNumberController.text,
                                      context)
                                  .then((value) {
                                Navigator.pop(contexdialog);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Verify(
                                      index: 0,
                                    ),
                                  ),
                                );
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF84643D),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 126, vertical: 11),
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  color: Color(0xFFFCF9F6), fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Color(0xFF84643D),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                            child: Text(
                              'Or',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Color.fromARGB(255, 55, 40, 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Logo(Logos.facebook_f),
                        Logo(Logos.google),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          const Text(
                            "Already have an account ? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => const sign(),
                                ),
                              );
                            },
                            child: const Text(
                              '  Sign in',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF84643D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
