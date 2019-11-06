import 'package:flutter/material.dart';

class ToggleWidgetView extends StatefulWidget {
  final Widget child;
  final bool show;
  final Offset begin;
  final Offset end;

  ToggleWidgetView({
    @required this.child,
    @required this.show,
    @required this.begin,
    @required this.end,
  });

  @override
  _ToggleWidgetViewState createState() => new _ToggleWidgetViewState();
}

class _ToggleWidgetViewState extends State<ToggleWidgetView>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: Duration(milliseconds: 200), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.show) {
      controller.forward();
    } else {
      controller.reverse();
    }

    return SlideTransition(
      position: Tween<Offset>(
        begin: widget.begin,
        end: widget.end,
      ).animate(controller),
      child: widget.child,
    );
  }
}
