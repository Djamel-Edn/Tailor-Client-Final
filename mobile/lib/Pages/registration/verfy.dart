import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetfinprepa/Pages/registration/Newpassword.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  late List<TextEditingController> _otpControllers;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(4, (index) => TextEditingController());
  }

  @override
  void dispose() {
    _otpControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _verifyOTP(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    final String otp = _otpControllers.map((controller) => controller.text).join();
    try {
      final response = await http.post(
        Uri.parse('your_backend_verification_link'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'otp': otp,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final bool isOTPValid = responseData['isOTPValid'];

        if (isOTPValid) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewPassword(),
            ),
          );
        } else {
          // Handle invalid OTP case
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Invalid OTP'),
              content: const Text('The entered OTP is invalid. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        // Handle other status codes
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to verify OTP. Error code: ${response.statusCode}'),
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
          content: const Text('An unexpected error occurred. Please try again later.'),
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
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
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
                padding: const EdgeInsets.only(bottom: 0, left: 0, right: 62, top: 410),
                child: Image.asset('images/mimi.png'),
              ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Verify Code',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 40),
                    const Text(
                      'Enter the verification code sent \n to your email.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        4,
                        (index) => Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: TextField(
                            controller: _otpControllers[index],
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              if (value.length == 1) {
                                if (index < _otpControllers.length - 1) {
                                  FocusScope.of(context).nextFocus();
                                } else {
                                  _verifyOTP(context);
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't receive OTP?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Add logic to resend OTP here
                          },
                          child: Text(
                            'Resend OTP',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 35),
                        GestureDetector(
                          onTap: () {
                            _verifyOTP(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 166, 131, 89),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 12),
                            child: _isLoading
                                ? CircularProgressIndicator() // Show loading indicator while verifying OTP
                                : const Text(
                                    'Verify',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 255, 253, 250),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 70)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
