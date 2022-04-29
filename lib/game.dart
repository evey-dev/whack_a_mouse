import 'package:flutter/material.dart';
import 'package:whack_a_mole/widget/mole.dart';
class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game>{
  List<double> moleLoc = [400.0, 400.0, 450.0, 500.0, 500.0];
  late List<Mole> moles;
  _GameState() {
    moles = [
      Mole(moleLoc[0], moleLoc[0] - 100, 53, const Duration(seconds: 1)),
      Mole(moleLoc[1], moleLoc[1] - 100, 323, const Duration(seconds: 1)),
      Mole(moleLoc[2], moleLoc[2] - 100, 188, const Duration(seconds: 1)),
      Mole(moleLoc[3], moleLoc[3] - 100, 53, const Duration(seconds: 1)),
      Mole(moleLoc[4], moleLoc[4] - 100, 323, const Duration(seconds: 1)),
    ];

    startGame();
  }
  void startGame() {
    moles[0].show();
    moles[1].show();
    moles[2].show();
    moles[3].show();
    moles[4].show();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          image: const DecorationImage(
            image: AssetImage('game/background.png'),
            fit: BoxFit.fill,
          )
        ),
        child: Align(
          alignment: Alignment.center,
          child: Wrap(
            children: [
              Container(
                alignment: Alignment.center,
                width: 450,
                child: Stack (
                  fit: StackFit.loose,
                  children: [
                    const Image(image: AssetImage('game/stand_back.png')),
                    const Positioned(
                      top: 300,
                      width: 450,
                      child: Image(image: AssetImage('game/stand_top_under.png')),
                    ),
                    const Positioned(
                        top: 300,
                        width: 450,
                        child: Image(image: AssetImage('game/top_4.png'))
                    ), // top_4
                    moles[0],
                    moles[1],
                    const Positioned(
                        top: 351,
                        width: 450,
                        child: IgnorePointer(ignoring: true, child: Image(image: AssetImage('game/top_3.png')))
                    ), // top_3
                    const Positioned(
                        top: 400,
                        width: 450,
                        child: Image(image: AssetImage('game/stand_top_divider.png'))
                    ), // stand_top_divider
                    moles[2],
                    const Positioned(
                        top: 399,
                        width: 450,
                        child: IgnorePointer(ignoring: true, child: Image(image: AssetImage('game/top_2.png')))
                    ), // top_2
                    moles[3],
                    moles[4],
                    const Positioned(
                        top: 480,
                        width: 450,
                        child: Image(image: AssetImage('game/stand_front.png'))
                    ), // stand_front
                    const Positioned(
                        top: 449,
                        width: 450,
                        child: IgnorePointer(ignoring: true, child: Image(image: AssetImage('game/top_1.png')))
                    ), // top_1
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }

}