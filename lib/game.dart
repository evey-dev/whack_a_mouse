import 'dart:async';
import 'package:flutter/material.dart';
import 'package:whack_a_mole/widget/mole.dart';
import 'dart:math';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game>{
  List<double> moleLoc = [400.0, 400.0, 450.0, 500.0, 500.0];
  double speed = 1;
  int points = 0;
  int showTime = 3000;
  Stopwatch s = Stopwatch();


  late List<Mole> moles;
  _GameState() {
    moles = [
      Mole(moleLoc[0], moleLoc[0] - 100, 53, const Duration(milliseconds: 500)),
      Mole(moleLoc[1], moleLoc[1] - 100, 323, const Duration(milliseconds: 500)),
      Mole(moleLoc[2], moleLoc[2] - 100, 188, const Duration(milliseconds: 500)),
      Mole(moleLoc[3], moleLoc[3] - 100, 53, const Duration(milliseconds: 500)),
      Mole(moleLoc[4], moleLoc[4] - 100, 323, const Duration(milliseconds: 500)),
    ];

    startGame();
  }

  void startGame() {
    s.start();
    Timer t = Timer.periodic(const Duration(milliseconds: 3000), showMoles);
    for(var i = 0; i < 6; i++) {
      Timer(Duration(seconds: i == 0 || i == 3 ? 9 : 10),(){
        t.cancel();
        t = Timer.periodic(Duration(milliseconds: 3000 - i * 500), showMoles);
      });
    }
  }

  void showMoles(timer) {
    moles[0].hide();
    moles[1].hide();
    moles[2].hide();
    moles[3].hide();
    moles[4].hide();

    var random = [false,false,false,false,false];
    Random x = Random();
    for(var i = 0; i < random.length; i++) {
      random[i] = x.nextBool();
      //안영하세요
    }

    for (var i = 0; i < random.length; i++) {
      if(random[i]){
        moles[i].show();
        print('showing '+i.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
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