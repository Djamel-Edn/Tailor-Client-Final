import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetfinprepa/LogiquesFonctions/RegistaerLogique.dart';
import 'package:projetfinprepa/Pages/registration/sign.dart';

class NewPassword extends StatefulWidget {
  var IDUSER;
  NewPassword({required this.IDUSER});

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _passwordError;
  String? _confirmPasswordError;
  bool _isLoading = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkPasswordValidity(String value) {
    setState(() {
      if (value.length < 8) {
        _passwordError = 'Password must be at least 8 characters long';
      } else {
        _passwordError = null;
      }
    });
  }

  void _checkConfirmPasswordValidity(String value) {
    setState(() {
      if (value != _newPasswordController.text) {
        _confirmPasswordError = 'Passwords do not match';
      } else {
        _confirmPasswordError = null;
      }
    });
  }

  Future<void> _savePassword(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    final String newPassword = _newPasswordController.text;

    try {
      final response = await http.post(
        Uri.parse('your_backend_save_password_url'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const sign(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(
                'Failed to save password. Error code: ${response.statusCode}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // Handle network or other errors
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'An unexpected error occurred. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F6),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
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
            padding:
                const EdgeInsets.only(bottom: 0, left: 0, right: 62, top: 410),
            child: Image.asset('images/mimi.png'),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create New Password',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Enter your new password below.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    onChanged: _checkPasswordValidity,
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      errorText: _passwordError,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    onChanged: _checkConfirmPasswordValidity,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      errorText: _confirmPasswordError,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown)),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    if (_passwordError == null &&
                        _confirmPasswordError == null) {
                      print(
                          "sssssssssssssssssss ${_newPasswordController.text}");
                      Register.EditForgotPassword(
                          widget.IDUSER, _newPasswordController.text, context);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 166, 131, 89),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 110, vertical: 12),
                    child: _isLoading
                        ? CircularProgressIndicator() // Show loading indicator while saving password
                        : const Text(
                            'Save Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 253, 250),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
