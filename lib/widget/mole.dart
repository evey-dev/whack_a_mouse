import 'package:flutter/cupertino.dart';

//ignore: must_be_immutable
class Mole extends StatefulWidget {
  double topLocation;
  final double showTopLocation;
  final double leftLocation;
  Duration duration;
  bool shown = true;

  Mole(this.topLocation, this.showTopLocation, this.leftLocation, this.duration, {Key? key}) : super(key: key);
  void show() {
    topLocation = showTopLocation;
    shown = true;
  }
  void hide() {
    topLocation = showTopLocation + 100;
    shown = false;
  }
  @override
  State<Mole> createState() => _MoleState(); //topLocation, showTopLocation, leftLocation, duration
}

class _MoleState extends State<Mole> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        top: widget.topLocation,
        left: widget.leftLocation,
        width: 75,
        duration: widget.duration,
        child: IgnorePointer(
          ignoring: !widget.shown,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: const Image(image: AssetImage('game/mole.png')),
            onTap: () {
              setState(() {
                widget.hide();
              });
            },
          ),
        )
    );
  }
}