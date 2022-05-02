import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Instructions extends StatelessWidget {
  const Instructions({Key? key}) : super(key: key);
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
            image: AssetImage('assets/image/instructions_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column (
          children: [
            const SizedBox(height: 530,),
            Image.asset('assets/image/drawing.png', height: 120),
            const SizedBox(height: 20),
            GestureDetector(
              child: Image.asset('assets/image/back.png', width: 100),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}