import 'package:flutter/material.dart';
import 'package:projetfinprepa/Pages/FirstPage.dart';
import 'package:projetfinprepa/Pages/registration/dd.dart';

import 'package:projetfinprepa/Pages/registration/sign.dart';
import 'package:projetfinprepa/Pages/registration/signupclient.dart';

class Sign extends StatelessWidget {
  const Sign({Key? key}) : super(key: key);

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
            padding: const EdgeInsets.only(bottom: 0, left: 0, right: 62, top: 410),
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                   Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => const FirstPage(),
                                ),
                              );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 166, 131, 89),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 12),
                    child: const Text(
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

          Center(
   child: Container( 
    decoration: BoxDecoration( border: Border.all(
                color: Colors.black, // Border color
                width: 2.0,),
                borderRadius: BorderRadius.circular(10),
                color:const Color(0xFFFCF9F6)),
     
              height: 360, width: 300, // Adjust this value to control the height of the container
             
     child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  [
                  
                  Icon(  size: 60,
            Icons.verified_user, ),
                  
                  Text(
                    'Well done!',
                    style: TextStyle(
                      color: Color.fromARGB(255, 41, 38, 38),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text( textAlign: TextAlign.center,
                    'you have succefully change \n password. \n please use your new password \n when sign in  !',
                    style: TextStyle(
                      color: Color.fromARGB(255, 41, 38, 38),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (e) => const sign(),
      ),
    );
  },
  style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 25),
   side: BorderSide(color: Colors.black),
  
  elevation: 2,
    backgroundColor: Color.fromARGB(255, 242, 240, 237), // Background color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Set border radius here
    ),
  ),
  child: Text(
    '  Sign in to continue ',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
),

                ],
              ),
            ),
 ),
   
        ],
      ),
    );
  }
}
