import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/game.dart';

class GameScreen extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];

  Game game = Game();

  @override
  void initState() {
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "It's ${lastValue} turn".toUpperCase(),
            style: GoogleFonts.kalam(
              textStyle: TextStyle(
                color: Colors.pinkAccent,
                fontSize: 58,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              padding: EdgeInsets.all(16),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              crossAxisCount: Game.boardLength ~/ 3,
              children: List.generate(Game.boardLength, (index) {
                return InkWell(
                  onTap: gameOver
                      ? null
                      : () {
                          if (game.board![index] == '') {
                            setState(() {
                              game.board![index] = lastValue;
                              turn++;
                              gameOver = game.winnerCheck(
                                  lastValue, index, scoreboard, 3);
                              if (gameOver) {
                                result = '$lastValue is the Winner';
                              } else if (!gameOver && turn == 9) {
                                result = "It's a Draw!";
                                gameOver = true;
                              }
                              if (lastValue == 'X')
                                lastValue = 'O';
                              else
                                lastValue = 'X';
                            });
                          }
                        },
                  child: Material(
                    elevation: 2,
                    child: Container(
                      width: Game.blockSize,
                      height: Game.blockSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.cyanAccent,
                          width: 1.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                            color: game.board![index] == 'X'
                                ? Colors.red
                                : Colors.green,
                            fontSize: 64,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            result,
            style: TextStyle(
              color: Colors.cyanAccent,
              fontSize: 54,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 40,
            width: 100,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
                  game.board = Game.initGameBoard();
                  lastValue = 'X';
                  gameOver = false;
                  turn = 0;
                  result = '';
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.purpleAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.replay),
                  Text('Restart'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
