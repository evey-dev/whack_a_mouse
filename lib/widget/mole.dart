import 'package:flutter/cupertino.dart';

class Mole extends StatefulWidget {
  late double topLocation;
  final double showTopLocation;
  final double leftLocation;
  late Duration duration;
  bool shown = true;
  final scoreFunction;

  Mole(this.showTopLocation, this.leftLocation, this.scoreFunction, {Key? key})
      : super(key: key) {
    duration = const Duration(milliseconds: 500);
    topLocation = showTopLocation + 100;
  }

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
    if (mounted) {
      setState(() {
        widget.topLocation = widget.showTopLocation + 100;
        widget.shown = false;
      });
    }
  }

  void changeDuration(int m) {
    if (mounted) {
      setState(() {
        widget.duration = Duration(milliseconds: m);
      });
    }
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
          child: const Image(image: AssetImage('assets/image/mole.png')),
          onTap: () {
            setState(() {
              widget.hide();
              widget.scoreFunction();
            });
          },
        ),
      ),
    );
    return anim;
  }
}
