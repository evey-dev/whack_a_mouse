import 'dart:async';
import 'package:flutter/material.dart';
import 'package:whack_a_mole/widget/mole.dart';
import 'dart:math';
import 'dart:ui';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  late List<Mole> moles;

  _GameState() {
    moles = [
      Mole(300, 53, addScore),
      Mole(300, 323, addScore),
      Mole(350, 188, addScore),
      Mole(400, 53, addScore),
      Mole(400, 323, addScore),
    ];

    startGame();
  }

  void startGame() {
    var timerDurations = [9, 9 + 10, 9 + 10 + 9, 9 + 10 + 9 + 10];
    var moleDurations = [400, 300, 200, 100];
    var showDurations = [2000, 1500, 1000, 750];
    Timer t = Timer.periodic(const Duration(milliseconds: 3000), showMoles);
    for (var i = 0; i < 4; i++) {
      Timer(Duration(seconds: timerDurations[i]), () {
        t.cancel();
        t = Timer.periodic(Duration(milliseconds: showDurations[i]), showMoles);
        for (Mole m in moles) {
          m.changeDuration(moleDurations[i]);
        }
      });
    }
    Timer(const Duration(seconds: 9 + 10 + 9 + 10 + 15), () {
      t.cancel();
      for (Mole m in moles) {
        m.hide();
      }
    });
  }

  void addScore() {
    switch (moles[0].duration.inMilliseconds) {
      case 500:
        _counter.value += 5;
        break;
      case 400:
        _counter.value += 10;
        break;
      case 300:
        _counter.value += 15;
        break;
      case 200:
        _counter.value += 20;
        break;
      default:
        _counter.value += 25;
        break;
    }
  }

  void showMoles(timer) {
    var random = [false, false, false, false, false];
    Random x = Random();
    for (var i = 0; i < random.length; i++) {
      random[i] = x.nextBool();
    }

    for (var i = 0; i < random.length; i++) {
      random[i] ? moles[i].show() : moles[i].hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('game/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: 450,
          child: Stack(
            fit: StackFit.loose,
            children: [
              const Image(image: AssetImage('game/stand_back.png')),
              const Positioned(
                top: 300,
                width: 450,
                child:
                    Image(image: AssetImage('game/stand_top_under.png'),),
              ),
              const Positioned(
                  top: 300,
                  width: 450,
                  child: Image(image: AssetImage('game/top_4.png'),),),
              moles[0],
              moles[1],
              const Positioned(
                top: 351,
                width: 450,
                child: IgnorePointer(
                  ignoring: true,
                  child: Image(
                    image: AssetImage('game/top_3.png'),
                  ),
                ),
              ),
              const Positioned(
                top: 400,
                width: 450,
                child: Image(
                  image: AssetImage('game/stand_top_divider.png'),
                ),
              ),
              moles[2],
              const Positioned(
                top: 399,
                width: 450,
                child: IgnorePointer(
                  ignoring: true,
                  child: Image(
                    image: AssetImage('game/top_2.png'),
                  ),
                ),
              ),
              moles[3],
              moles[4],
              const Positioned(
                top: 492,
                width: 450,
                child: Image(
                  image: AssetImage('game/stand_front.png'),
                ),
              ),
              const Positioned(
                top: 449,
                width: 450,
                child: IgnorePointer(
                  ignoring: true,
                  child: Image(
                    image: AssetImage('game/top_1.png'),
                  ),
                ),
              ),
              Positioned(
                top: 225,
                left: 169,
                child: Container(
                  height: 64,
                  width: 110,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.green),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(20)),
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ValueListenableBuilder<int>(
                      valueListenable: _counter,
                      builder: (BuildContext context, int value,
                          Widget? child) {
                        return Text(
                          value.toString().length == 4
                              ? value.toString()
                              : value.toString().length == 3
                                  ? "0" + value.toString()
                                  : value.toString().length == 2
                                      ? "00" + value.toString()
                                      : "000" + value.toString(),
                          style: const TextStyle(
                            fontFamily: 'Digital',
                            fontSize: 45,
                            color: Colors.red,
                            fontFeatures: [
                              FontFeature.tabularFigures(),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
