import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetfinprepa/Pages/registration/verfy.dart';

class forget extends StatefulWidget {
  const forget({Key? key}) : super(key: key);

  @override
  _ForgetState createState() => _ForgetState();
}

class _ForgetState extends State<forget> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final String email = _emailController.text.trim();
    final bool isValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    setState(() {
      _isEmailValid = isValid;
    });
  }
Future<void> _sendEmail(BuildContext context) async {
  final String email = _emailController.text;
  if (_formKey.currentState!.validate() && _isEmailValid) {
    try {
      final response = await http.post(
        Uri.parse('http://255.255.255.0:5001/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
       
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Verify(),
          ),
        );
      } else {
       
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send email. Please try again.'),
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An unexpected error occurred.'),
        ),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 240, 235),
      body: Center(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25), 
                const Text(
                  'Forget password',
                  style: TextStyle(fontSize: 35),
                ),
                const SizedBox(height: 30), 
                const Text(
                  ' Please enter your email address. \n You will receive a code to create \n a new password via email.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 60), 
                Form(
                  key: _formKey,
                  child:TextFormField(
    controller: _emailController,
    decoration: InputDecoration(
      label: const Text(
        'Email',
        style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
      ),
      hintText: 'Enter Email',
      suffixIcon: const Icon(Icons.email),
      hintStyle: const TextStyle(color: Colors.black26),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.brown, width: 2.0),
        borderRadius: BorderRadius.circular(25),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(25),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      }
      if (!_isEmailValid) {
        return 'Please enter a valid email';
      }
      return null;
    },
  ),
),
const SizedBox(height: 40), 
ElevatedButton(
  onPressed: () => _sendEmail(context),
  
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      Color(0xFF84643D), 
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 94, vertical: 8),
    child: Text(
      'Send Email ',
      style: TextStyle(color: Color(0xFFFCF9F6), fontSize: 20),
    ),
  ),
),
              ],
            ),
          ),
        ),
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
floatingActionButton: IconButton(
  onPressed: () => Navigator.pop(context),
  iconSize: 25,
  icon: Icon(Icons.arrow_back, color: Colors.brown),
)


    );}}