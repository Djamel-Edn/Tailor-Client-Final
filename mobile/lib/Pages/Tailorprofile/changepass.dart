import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetfinprepa/Providers/LocalDB.dart';
import 'package:projetfinprepa/Providers/Tailors%20copy.dart';
import 'package:provider/provider.dart';

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<Password> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _currentPasswordError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _errorMsg;
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkCurrentPasswordValidity(String value) {
    setState(() {
      _currentPasswordError =
          value.isEmpty ? 'Please enter your current password' : null;
    });
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

    final String currentPassword = _currentPasswordController.text;
    final String newPassword = _newPasswordController.text;

    try {
      final response = await http.post(
        Uri.parse(
            'https://tailor-client-ps9z.onrender.com/updatePassword'), // Change to your backend URL
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        }),
      );

      final data = jsonDecode(response.body);
      if (!data.containsKey('name')) {
        setState(() {
          _errorMsg = data.toString();
        });
        return;
      }

      // // Password saved successfully, navigate to sign-in page
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const UserProfilePage(), // Navigate to your sign-in page
      //   ),
      // );
    } catch (error) {
      // Handle network or other errors
      setState(() {
        _errorMsg = 'Failed to save password';
      });
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown)),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    if (_currentPasswordError == null &&
                        _passwordError == null &&
                        _confirmPasswordError == null &&
                        !_isLoading) {
                      print("ssssssssssssssss ${_newPasswordController.text}");
                      Provider.of<ClientProvider>(context, listen: false)
                          .EditPasswordClient(
                              Provider.of<LocalDbProvider>(context,
                                      listen: false)
                                  .id,
                              _newPasswordController.text,
                              context);
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
                        ? CircularProgressIndicator()
                        : const Text(
                            'Save Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 253, 250),
                            ),
                          ),
                  ),
                ),
                if (_errorMsg != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      _errorMsg!,
                      style: TextStyle(color: Colors.red),
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
