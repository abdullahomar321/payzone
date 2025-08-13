import 'package:flutter/material.dart';
import 'package:payzone/accounts.dart';
import 'package:confetti/confetti.dart';


class success extends StatefulWidget {
  const success({super.key});

  @override
  State<success> createState() => _successState();
}

class _successState extends State<success> with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  bool _showButton = false;
  late AnimationController _tickController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();

    _tickController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 110),
    );

    _scaleAnimation =
        CurvedAnimation(parent: _tickController, curve: Curves.elasticOut);

    Future.delayed(const Duration(milliseconds: 600), () {
      _tickController.forward();
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showButton = true;
      });
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _tickController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0.5,
              numberOfParticles: 30,
              maxBlastForce: 20,
              minBlastForce: 5,
              gravity: 0.3,
              colors: const [
                Colors.green,
                Colors.red,
                Colors.orange,
                Colors.pink,
              ],
            ),
          ),
          const SizedBox(height: 80),
          ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.pink.shade300,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 1.8,
                ),
              ),
              padding: const EdgeInsets.all(30),
              child: const Icon(
                Icons.check,
                size: 60,
                color: Colors.green,
                weight: 3500,
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "Verification Success!",
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Jost',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 50),
          if (_showButton)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shadowColor: Colors.black,
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const accounts()),
                );
              },
              child: const Text(
                'Go To login',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: 'Jost',
                    color: Colors.black
                ),
              ),
            ),
        ],
      ),
    );
  }
}