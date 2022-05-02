import 'package:flutter/material.dart';
import 'game.dart';
import 'package:flutter/services.dart';

import 'instructions.dart';

class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
              const SizedBox(height: 20),
              GestureDetector(
                child: Image.asset('assets/image/start.png', width: 300),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Game()),
                  );
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: Image.asset('assets/image/instructions.png', width: 300),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Instructions()),
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