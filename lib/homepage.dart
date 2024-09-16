// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:fllapy_bird/barriers.dart';
import 'package:fllapy_bird/bird.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  static double birdyaxis = 0;
  double time = 0;
  double height = 0;
  // ignore: non_constant_identifier_names
  double init_height = birdyaxis as double;
  bool gameStarted = false;
  static double barrierone = 2;
  double barriertwo = barrierone + 1.2;

  double birdHeight = 0.5;
  double barrierWidth = 0.5;
  double barrierGap = 1;
  int currentScore = 0;
  double birdWidth = 0.5;
  int highScore = 0;

  void showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Your Score: $currentScore"),
              Text("High Score: $highScore"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Play Again"),
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      birdyaxis = 0;
      time = 0;
      height = 0;
      barrierone = 2;
      barriertwo = barrierone + 1.2;
      gameStarted = false;

      if (currentScore > highScore) {
        highScore = currentScore;
      }
      currentScore = 0;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      init_height = birdyaxis;
    });
  }

  // Define the bird width to use for barrier checks

  void startGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdyaxis = (init_height - height);
      });

      // Update barrier positions
      setState(() {
        if (barrierone < -1.5) {
          barrierone += 3;
        } else {
          barrierone -= 0.07;
        }
      });
      setState(() {
        if (barriertwo < -1.5) {
          barriertwo += 3;
        } else {
          barriertwo -= 0.07;
        }
      });

      // Barrier size and gap configuration
      double barrierHeight = 0.55; // Adjust as per your UI
      double barrierGap =
          0.4; // Adjust the gap size between top and bottom barriers

      // Check for collision with the first barrier
      if (barrierone > -birdWidth && barrierone < birdWidth) {
        // Check collision with the bottom barrier
        if (birdyaxis > 1 - barrierHeight) {
          timer.cancel();
          gameStarted = false;
          showGameOverDialog();
        }

        // Check collision with the top barrier
        if (birdyaxis < -1 + barrierGap) {
          timer.cancel();
          gameStarted = false;
          showGameOverDialog();
        }
      }

      // Check for collision with the second barrier
      if (barriertwo > -birdWidth && barriertwo < birdWidth) {
        // Check collision with the bottom barrier
        if (birdyaxis > 1 - barrierHeight) {
          timer.cancel();
          gameStarted = false;
          showGameOverDialog();
        }

        // Check collision with the top barrier
        if (birdyaxis < -1 + barrierGap) {
          timer.cancel();
          gameStarted = false;
          showGameOverDialog();
        }
      }

      // Increment the score when the bird passes the first barrier
      if (barrierone < -birdWidth && barrierone > -birdWidth - 0.05) {
        setState(() {
          currentScore += 1; // Increment the score
        });
      }

      // Increment the score when the bird passes the second barrier
      if (barriertwo < -birdWidth && barriertwo > -birdWidth - 0.05) {
        setState(() {
          currentScore += 1; // Increment the score
        });
      }

      // Game over if bird hits the ground
      if (birdyaxis > 1) {
        timer.cancel();
        gameStarted = false;
        showGameOverDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, birdyaxis),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue.shade200,
                      child: MyBird(),
                    ),
                    Container(
                        alignment: Alignment(0, -0.3),
                        child: gameStarted
                            ? Text("")
                            : const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                    Text(
                                      "F L A P P Y  B I R D",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      "T A P  T O  P L A Y",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ])),
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: 0,
                      ),
                      alignment: Alignment(barrierone, 1.1),
                      child: MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: 0,
                      ),
                      alignment: Alignment(barrierone, -1.1),
                      child: MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: 0,
                      ),
                      alignment: Alignment(barriertwo, 1.1),
                      child: MyBarrier(
                        size: 150.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: 0,
                      ),
                      alignment: Alignment(barriertwo, -1.1),
                      child: MyBarrier(
                        size: 250.0,
                      ),
                    ),
                  ],
                )),
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade300,
              ),
              height: 20,
            ),
            Expanded(
              child: Container(
                color: Colors.brown.shade600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "SCORE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                            Text(
                              "$currentScore",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "BEST",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                            Text(
                              "$highScore",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'BY - R O C H A N',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
