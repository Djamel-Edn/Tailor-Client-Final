import 'package:flutter/material.dart';
import 'package:projetfinprepa/Pages/registration/SIGNUPT.dart';

import 'package:projetfinprepa/Pages/registration/signupclient.dart';

class CircleIcon extends StatefulWidget {
  final bool isSelected;
  final Function(bool)? onTap;

  const CircleIcon({
    required this.isSelected,
    this.onTap,
  });

  @override
  _CircleIconState createState() => _CircleIconState();
}

class _CircleIconState extends State<CircleIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap?.call(!widget.isSelected);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          color: widget.isSelected ? Color(0xFF84643D) : Colors.transparent,
        ),
      ),
    );
  }
}

class fily extends StatefulWidget {
  const fily({Key? key}) : super(key: key);

  @override
  _filyState createState() => _filyState();
}

class _filyState extends State<fily> {
  int _selectedCircleIndex = -1;

  void _handleCircleTap(int circleIndex) {
    setState(() {
      if (_selectedCircleIndex == circleIndex) {
        
        _selectedCircleIndex = -1;
      } else {
        _selectedCircleIndex = circleIndex;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F6),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 90),
            child: Image.asset('images/shad.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0, left: 0, right: 60, top: 410),
            child: Image.asset('images/mimi.png'),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ SizedBox(height: 100,),
              const Text(
                'ARE YOU ...?',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'Please choose to sign up ',
                  style: TextStyle(fontSize: 15),
                ),
              ),
             
              Padding(
                padding: const EdgeInsets.only(left: 35 , right: 35 , top: 50, bottom:32 ),
                child: SizedBox( height: 115,
                  child: Card( shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), 
                      side: BorderSide(color: Colors.black, width: 1), 
                    ),
                    color:const Color(0xFFFCF9F6),
     
                    child: Center(
                      child: ListTile(
                        leading: CircleIcon(
                          isSelected: _selectedCircleIndex == 0,
                          onTap: (isSelected) => _handleCircleTap(0),
                        ),
                        title: const Text('  TAYLOR', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), ),
                        subtitle: RichText( 
          text: const TextSpan(
            text: '   A paragraph of ',
            style: TextStyle(
              color: Colors.black,
         
               fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'text ',
                style: TextStyle(
                  color: Colors.red,
                 
                )),
                TextSpan(
                text: 'with an ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
         
              TextSpan( 
                text: ' \n   unassigned link   ',
                style: TextStyle( 
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              )
              ]))
                      ),
                    ),
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: SizedBox( height: 115,
                  child: Card( shape: RoundedRectangleBorder( 
                      borderRadius: BorderRadius.circular(15), 
                      side: BorderSide(color: Colors.black, width: 1), 
                    ),
                    color:const Color(0xFFFCF9F6),
                    child: Center(
                      child: ListTile(
                        leading: CircleIcon(
                          isSelected: _selectedCircleIndex == 1,
                          onTap: (isSelected) => _handleCircleTap(1),
                        ),
                        title: const Text('  CLIENT' ,  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                        subtitle: RichText( 
          text: const TextSpan(
            text: '   A paragraph of ',
            style: TextStyle(
              color: Colors.black,
              
               fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'text ',
                style: TextStyle(
                  color: Colors.red,
                 
                )),
                TextSpan(
                text: 'with an ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
         
              TextSpan( 
                text: ' \n   unassigned link   ',
                style: TextStyle( 
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              )
              ]))
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 170,),
              
                

                Padding(
                  padding: const EdgeInsets.only(left: 95),
                  child: Row(
                   children: [  Text ("Don't have an account ? ",
                              style: TextStyle(
                                color: Colors.black,
                                
                                 fontWeight: FontWeight.bold,
                              ),),
                   GestureDetector(
  onTap: () {
    if (_selectedCircleIndex != -1) {
      if (_selectedCircleIndex != 0){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (e) => const SignUpScreen(),
        ),
      );} else  { Navigator.push(
        context,
        MaterialPageRoute(
          builder: (e) => const SignUpScreen1(),
        ),);}
    }
  },
  child: Text(
    '  Sign up', 
    style: TextStyle( 
      fontWeight: FontWeight.bold,
      color:  Color(0xFF84643D),
    ),
  ),
),

                   ],
                                 ),
                ),



            ],
          ),
        ],
      ),
    );
  }
}


