import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whack_a_mole/widget/mole.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/services.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final ValueNotifier<bool> _redText = ValueNotifier<bool>(true);

  late List<Mole> moles;

  _GameState() {
    moles = [
      Mole(200, 33, addScore),
      Mole(200, 245, addScore),
      Mole(235, 138, addScore),
      Mole(275, 33, addScore),
      Mole(275, 240, addScore),
    ];
    startGame();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
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
      _redText.value = false;
      Timer(const Duration(milliseconds: 500), () {_redText.value = true;});
      Timer(const Duration(milliseconds: 1000), () {_redText.value = false;});
      Timer(const Duration(milliseconds: 1500), () {_redText.value = true;});
      Timer(const Duration(milliseconds: 2000), () {_redText.value = false;});
      Timer(const Duration(milliseconds: 2500), () {_redText.value = true;});
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
    if (mounted) {
      var random = [false, false, false, false, false];
      Random x = Random();
      for (var i = 0; i < random.length; i++) {
        random[i] = x.nextBool();
      }

      for (var i = 0; i < random.length; i++) {
        random[i] ? moles[i].show() : moles[i].hide();
      }
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
            image: AssetImage('assets/image/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: 350,
          child: Stack(
            fit: StackFit.loose,
            children: [
              const Image(image: AssetImage('assets/image/stand_back.png')),
              const Positioned(
                top: 230,
                width: 350,
                child: Image(image: AssetImage('assets/image/stand_top_under.png'),),
              ),
              const Positioned(
                  top: 230,
                  width: 350,
                  child: Image(image: AssetImage('assets/image/top_4.png'),),),
              moles[0],
              moles[1],
              const Positioned(
                top: 270,
                width: 350,
                child: IgnorePointer(
                  ignoring: true,
                  child: Image(
                    image: AssetImage('assets/image/top_3.png'),
                  ),
                ),
              ),
              const Positioned(
                top: 307,
                width: 350,
                child: Image(
                  image: AssetImage('assets/image/stand_top_divider.png'),
                ),
              ),
              moles[2],
              const Positioned(
                top: 307,
                width: 350,
                child: IgnorePointer(
                  ignoring: true,
                  child: Image(
                    image: AssetImage('assets/image/top_2.png'),
                  ),
                ),
              ),
              moles[3],
              moles[4],
              const Positioned(
                top: 382,
                width: 350,
                child: Image(
                  image: AssetImage('assets/image/stand_front.png'),
                ),
              ),
              const Positioned(
                top: 346,
                width: 350,
                child: IgnorePointer(
                  ignoring: true,
                  child: Image(
                    image: AssetImage('assets/image/top_1.png'),
                  ),
                ),
              ),
              Positioned(
                top: 175,
                left: 131,
                child: Container(
                  height: 50,
                  width: 90,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.green),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(20)),
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ValueListenableBuilder2<int, bool>(
                      first: _counter,
                      second: _redText,
                      builder: (BuildContext context, int value1, bool value2, Widget? child) {
                        return Text(
                          value1.toString().length == 4
                              ? value1.toString()
                              : value1.toString().length == 3
                                  ? "0" + value1.toString()
                                  : value1.toString().length == 2
                                      ? "00" + value1.toString()
                                      : "000" + value1.toString(),
                          style: TextStyle(
                            fontFamily: 'Digital',
                            fontSize: 30,
                            color: value2 ? Colors.red : Colors.black,
                            fontFeatures: const [
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.transparent,
        child: Image.asset('assets/image/back.png', width: 100,),
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
class ValueListenableBuilder2<A, B> extends StatelessWidget {
  const ValueListenableBuilder2({
    required this.first,
    required this.second,
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final ValueListenable<A> first;
  final ValueListenable<B> second;
  final Widget? child;
  final Widget Function(BuildContext context, A a, B b, Widget? child) builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<A>(
    valueListenable: first,
    builder: (_, a, __) {
      return ValueListenableBuilder<B>(
        valueListenable: second,
        builder: (context, b, __) {
          return builder(context, a, b, child);
        },
      );
    },
  );
}