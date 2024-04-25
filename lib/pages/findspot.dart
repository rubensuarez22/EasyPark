import 'package:flutter/material.dart';

class FindSpot extends StatelessWidget {
  const FindSpot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/images/udlap_logo.png',
              height: 100,
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}