import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayX0 = ['', '', '', '', '', '', '', '', '', ''];
  List<int> matchedIndexes = [];
  int attempts = 0;
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  String resultDeclaration = '';
  bool winnerFound = false;

  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;

  static var customFontWhite = GoogleFonts.coiny(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSeconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Player 0',
                        style: customFontWhite,
                      ),
                      Text(
                        oScore.toString(),
                        style: customFontWhite,
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Player X',
                        style: customFontWhite,
                      ),
                      Text(
                        xScore.toString(),
                        style: customFontWhite,
                      )
                    ],
                  )
                ],
              )),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 5,
                            color: MainColor.primaryColor,
                          ),
                          color: matchedIndexes.contains(index)
                              ? MainColor.accentcolor
                              : MainColor.secondarycolor,
                        ),
                        child: Center(
                          child: Text(
                            displayX0[index],
                            style: GoogleFonts.coiny(
                                textStyle: TextStyle(
                                    fontSize: 64,
                                    color: MainColor.primaryColor)),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      resultDeclaration,
                      style: customFontWhite,
                    ),
                    SizedBox(height: 10),
                    _buildTimer()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      setState(() {
        if (oTurn && displayX0[index] == '') {
          displayX0[index] = '0';
          filledBoxes++;
        } else if (!oTurn && displayX0[index] == '') {
          displayX0[index] = 'x';
          filledBoxes++;
        }
        oTurn = !oTurn;
        _checkwinner();
      });
    }
  }

  void _checkwinner() {
    // check 1st row
    if (displayX0[0] == displayX0[1] &&
        displayX0[0] == displayX0[2] &&
        displayX0[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[0] + ' Wins!';
        matchedIndexes.addAll([0, 1, 2]);
        stopTimer();
        _updateScore(displayX0[0]);
      });
    }

    // check 2nd row
    if (displayX0[3] == displayX0[4] &&
        displayX0[3] == displayX0[5] &&
        displayX0[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[3] + ' Wins!';
        matchedIndexes.addAll([3, 4, 5]);
        stopTimer();
        _updateScore(displayX0[3]);
      });
    }

    // check 3rd row
    if (displayX0[6] == displayX0[7] &&
        displayX0[6] == displayX0[8] &&
        displayX0[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[6] + ' Wins!';
        matchedIndexes.addAll([6, 7, 8]);
        stopTimer();
        _updateScore(displayX0[6]);
      });
    }

    // check 1st column
    if (displayX0[0] == displayX0[3] &&
        displayX0[0] == displayX0[6] &&
        displayX0[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[0] + ' Wins!';
        matchedIndexes.addAll([0, 3, 6]);
        stopTimer();
        _updateScore(displayX0[0]);
      });
    }

    // check 2nd column
    if (displayX0[1] == displayX0[4] &&
        displayX0[1] == displayX0[7] &&
        displayX0[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[1] + ' Wins!';
        matchedIndexes.addAll([1, 4, 7]);
        stopTimer();
        _updateScore(displayX0[1]);
      });
    }
    // check 3rd column
    if (displayX0[2] == displayX0[5] &&
        displayX0[2] == displayX0[8] &&
        displayX0[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[2] + ' Wins!';
        matchedIndexes.addAll([2, 5, 8]);
        stopTimer();
        _updateScore(displayX0[2]);
      });
    }

    // check diagonal
    if (displayX0[0] == displayX0[4] &&
        displayX0[0] == displayX0[8] &&
        displayX0[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[0] + ' Wins!';
        matchedIndexes.addAll([0, 4, 8]);
        stopTimer();
        _updateScore(displayX0[0]);
      });
    }

    // check diagonal
    if (displayX0[6] == displayX0[4] &&
        displayX0[6] == displayX0[2] &&
        displayX0[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayX0[6] + ' Wins!';
        matchedIndexes.addAll([6, 4, 2]);
        stopTimer();
        _updateScore(displayX0[6]);
      });
    }
    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Nobody Wins!';
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayX0[i] = '';
      }
      resultDeclaration = '';
      matchedIndexes = [];
    });
    filledBoxes = 0;
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: MainColor.accentcolor,
                ),
                Center(
                  child: Text(
                    '$seconds',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
              ],
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            onPressed: () {
              startTimer();
              _clearBoard();
              attempts++;
            },
            child: Text(
              attempts == 0 ? 'Start' : 'Play Again!',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          );
  }
}
