import 'package:flutter/material.dart';
import 'game.dart';
import 'package:flutter/services.dart';

class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);
  late int highscore = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: Container(
        width: 500,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 85, left: 40, right: 40),
          child: Column(
            children: [
              Image.asset('assets/image/title.png', height: 200),
              const SizedBox(height: 30),
              Image.asset('assets/image/drawing.png', height: 200),
              IconButton(
                iconSize: 200,
                icon: Image.asset('assets/image/start.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Game()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}