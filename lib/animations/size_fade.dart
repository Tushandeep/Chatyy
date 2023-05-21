import 'package:flutter/material.dart';

class FadeSizeTransition extends StatefulWidget {
  const FadeSizeTransition({
    super.key,
    required this.child,
    required this.controller,
    this.fadeTween,
    this.sizeTween,
  });

  final AnimationController controller;
  final Tween<double>? fadeTween, sizeTween;
  final Widget child;

  @override
  State<FadeSizeTransition> createState() => _FadeSizeTransitionState();
}

class _FadeSizeTransitionState extends State<FadeSizeTransition> {
  late AnimationController _controller;
  late Animation<double> _opacity, _sizeFator;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller;

    _opacity = (widget.fadeTween ?? Tween<double>(begin: 0, end: 1)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          .3,
          1,
          curve: Curves.easeIn,
        ),
      ),
    );

    _sizeFator = (widget.sizeTween ?? Tween<double>(begin: 0, end: 1)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0,
          .4,
          curve: Curves.easeIn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SizeTransition(
        sizeFactor: _sizeFator,
        axis: Axis.vertical,
        axisAlignment: 0,
        child: widget.child,
      ),
    );
  }
}
