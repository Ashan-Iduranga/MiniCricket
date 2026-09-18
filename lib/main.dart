import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

// Icons downloaded from https://uxwing.com (free, no attribution required).
const String batImageUrl =
    'https://uxwing.com/wp-content/themes/uxwing/download/sport-and-awards/cricket-bat-icon.png';
const String ballImageUrl =
    'https://uxwing.com/wp-content/themes/uxwing/download/sport-and-awards/cricket-ball-icon.png';

void main() {
  runApp(const MiniCricketApp());
}

class MiniCricketApp extends StatelessWidget {
  const MiniCricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Cricket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF1E88E5),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Random _random = Random();

  int runs = 0;
  int ballsLeft = 6;
  int batNumber = 0;
  int bowlNumber = 0;
  bool isSpinning = false;
  bool isOut = false;
  String resultText = '';

  bool get isGameOver => isOut || ballsLeft == 0;

  // Simulates one ball: spin random numbers for a moment, then compare them.
  void playBall() {
    if (isSpinning || isGameOver) return;

    setState(() {
      isSpinning = true;
      resultText = '';
    });

    int ticks = 0;
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        batNumber = _random.nextInt(7); // random number from 0 to 6
        bowlNumber = _random.nextInt(7);
      });

      ticks++;
      if (ticks == 8) {
        timer.cancel();
        finishBall();
      }
    });
  }

  // Decides the outcome once the numbers stop spinning.
  void finishBall() {
    setState(() {
      isSpinning = false;

      final bool isWicket = batNumber == bowlNumber && batNumber != 0;
      if (isWicket) {
        isOut = true;
        resultText = 'OUT!';
      } else {
        runs += batNumber;
        ballsLeft--;
        resultText = batNumber == 0 ? 'No Runs' : '$batNumber Runs';
      }
    });
  }

  void restartGame() {
    setState(() {
      runs = 0;
      ballsLeft = 6;
      batNumber = 0;
      bowlNumber = 0;
      isSpinning = false;
      isOut = false;
      resultText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E88E5),
      appBar: AppBar(
        title: const Text('Mini Cricket'),
        backgroundColor: const Color(0xFF0D47A1),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StatBox(imageUrl: batImageUrl, label: 'Runs', value: runs),
                const SizedBox(width: 40),
                StatBox(
                  imageUrl: ballImageUrl,
                  label: 'Balls',
                  value: ballsLeft,
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 40,
              child: Center(
                child: isSpinning
                    ? Text(
                        '$batNumber   vs   $bowlNumber',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        resultText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: isSpinning
                  ? null
                  : (isGameOver ? restartGame : playBall),
              style: ElevatedButton.styleFrom(
                backgroundColor: isGameOver
                    ? Colors.red
                    : const Color(0xFF1565C0),
                disabledBackgroundColor: const Color(0xFF1565C0),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                isGameOver ? 'Restart' : (isSpinning ? 'Ball' : 'Bat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// A white card showing an icon, a label ("Runs"/"Balls") and its value.
class StatBox extends StatelessWidget {
  final String imageUrl;
  final String label;
  final int value;

  const StatBox({
    super.key,
    required this.imageUrl,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.network(
            imageUrl,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.sports_cricket),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white70)),
        Text(
          '$value',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
