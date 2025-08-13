import 'package:flutter/material.dart';
import 'package:payzone/accounts.dart';
import 'dart:math';

class logo extends StatelessWidget {
  const logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.purple,
            automaticallyImplyLeading: false,
            expandedHeight: 100,
          ),
          SliverToBoxAdapter(child:SizedBox(height: 100,) ,),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: pi / 4,
                    child: Image.asset(
                      "assets/images/triangle.png",
                      height: 250,
                      width: 250,
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        'PayZone',
                        style: TextStyle(
                          fontFamily: 'AtkinsonHyperlegible',
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 10
                            ..color = Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => accounts()),
                          );
                        },
                        child: Text(
                          'PayZone',
                          style: TextStyle(
                            fontFamily: 'AtkinsonHyperlegible',
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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