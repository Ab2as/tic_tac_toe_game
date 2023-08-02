import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/ui/theme/color.dart';
import 'package:tic_tac_toe_game/utils/game_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //adding the variables
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0; //to check the draw
  String gameResult = "";

  List<int> scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
  //the score are for the different combination of the game [Row 1,2,3, Column 1,2,3 Diagonal 1,2];

  //declaring a new game components
  Game game = Game();

  //init the GameBoard
  //initState() method is called only and only once and is used generally
  // for initializing the previously defined variables of the stateful
  //widget. initState() method is overridden mostly because as mentioned
  //earlier it is called only once in its lifetime.

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
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "It's ${lastValue} turn".toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 58),
          ),
          const SizedBox(
            height: 20.0,
          ),

          //now we will create the game board
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardLength ~/ 3,
              //the ~/ operator allows to evide to integer and return an Int as a result
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing:
                  8.0, //axisspacing will divide the container into parts
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardLength, (index) {
                return InkWell(
                  onTap: gameOver
                      ? null
                      : () {
                          //when we click we need to add the new value to the
                          //board and refresh the screen

                          //we also need to toggle the player

                          //now we need to apply the click only if the field is empty
                          if (game.board![index] == "") {
                            setState(() {
                              game.board![index] = lastValue;
                              turn++;
                              gameOver = game.winnerCheck(
                                  lastValue, index, scoreBoard, 3);
                              if (gameOver) {
                                gameResult = "$lastValue is the winner";
                              } else if (!gameOver && turn == 9) {
                                gameResult = "It's a Draw";
                                gameOver = true;
                              }
                              if (lastValue == "X") {
                                lastValue = "O";
                              } else {
                                lastValue = "X";
                              }
                            });
                          }
                        },
                  child: Container(
                    width: Game.blockSize,
                    height: Game.blockSize,
                    decoration: BoxDecoration(
                      color: MainColor.secondaryColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                          color: game.board![index] == "X"
                              ? Colors.blue
                              : Colors.pink,
                          fontSize: 64.0,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          Text(
            gameResult,
            style: const TextStyle(color: Colors.white, fontSize: 54.0),
          ),
          //creating a button to repeat the game
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameOver = false;
                turn = 0;
                gameResult = "";
                scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
              });
            },
            icon: const Icon(Icons.replay),
            label: const Text("Repeat the Game"),
          ),
        ],
      ),
    );
  }
}
