import 'package:flutter/cupertino.dart';

//ignore: must_be_immutable
class Mole extends StatefulWidget {
  double topLocation;
  final double showTopLocation;
  final double leftLocation;
  Duration duration;
  bool shown = true;

  Mole(this.topLocation, this.showTopLocation, this.leftLocation, this.duration, {Key? key}) : super(key: key);
  final _MoleState ms = _MoleState();

  void show() {
    ms.show();
  }
  void hide() {
    ms.hide();
  }
  void changeDuration(int m) {
    ms.changeDuration(m);
  }
  @override
  State<StatefulWidget> createState() => ms;
}

class _MoleState extends State<Mole> {
  late AnimatedPositioned anim;
  void show() {
    setState(() {
      widget.topLocation = widget.showTopLocation;
      widget.shown = true;
    });

  }
  void hide() {
    setState(() {
      widget.topLocation = widget.showTopLocation + 100;
      widget.shown = false;
    });
  }
  void changeDuration(int m) {
    setState(() {
      widget.duration = Duration(milliseconds: m);
    });
  }
  @override
  Widget build(BuildContext context) {
    anim = AnimatedPositioned(
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
    return anim;
  }
}