import 'package:flutter/material.dart';
import 'package:tictac_game/game_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlayer = 'x';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child:MediaQuery.of(context).orientation==Orientation.portrait? Column(
        children: [
          ...firstBlock(),
          _mainBody(context),
          ...secondBlock(),
          const SizedBox(
            height: 10,
          )
        ],
      ):Row(
        children: [
          Expanded(
            child: Column(
              children: [
              ...firstBlock(),
              ...secondBlock()
              ],
            ),
          ),
          _mainBody(context)
        ],
      )),
    );
  }

  List<Widget> secondBlock() {
    return [
      Text(
        result,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 42,
        ),
        textAlign: TextAlign.center,
      ),
      ElevatedButton.icon(
        onPressed: () {
          setState(() {
            Player.playerX = [];
            Player.playerO = [];
            activePlayer = 'x';
            gameOver = false;
            turn = 0;
            result = '';
          });
        },
        icon: const Icon(Icons.replay),
        label: const Text(
          'Restart game',
          style: TextStyle(color: Colors.black),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(Theme.of(context).splashColor),
        ),
      ),
    ];
  }

  List<Widget> firstBlock() {
    return [
      SwitchListTile.adaptive(
        title: const Text(
          'Turn on/off two player',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
          textAlign: TextAlign.center,
        ),
        value: isSwitched,
        onChanged: (newVal) {
          setState(() {
            isSwitched = newVal;
          });
        },
      ),
      Text(
        !gameOver ? 'It\'s $activePlayer turn'.toUpperCase() : 'GAME OVER!',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 52,
        ),
        textAlign: TextAlign.center,
      ),
    ];
  }

  Expanded _mainBody(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
        children: List.generate(
            9,
            (index) => InkWell(
                  onTap: gameOver ? null : () => _onTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).shadowColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                      child: Text(
                        Player.playerX.contains(index)
                            ? 'X'
                            : Player.playerO.contains(index)
                                ? 'O'
                                : '',
                        style: TextStyle(
                          color: Player.playerX.contains(index)
                              ? Colors.green
                              : Colors.pink,
                          fontSize: 52,
                        ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }

  _onTap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.playGame(index, activePlayer);
      updateState();

      if (!isSwitched && !gameOver) {
        await game.autoPlay(activePlayer);
        updateState();
      }
    }
  }

  void updateState() {
    setState(() {
      activePlayer = activePlayer == 'x' ? 'o' : 'x';
      turn++;
      String winnerPlayer = game.checkWinner();
      if (winnerPlayer != '') {
        gameOver = true;
        result = '$winnerPlayer is the winner';
      } else if (!gameOver && turn == 9) {
        gameOver = true;
        result = 'It\'s draw';
      }
    });
  }
}
