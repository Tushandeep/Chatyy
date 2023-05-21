import 'package:flutter/material.dart';

class ScaleOutFadeIn extends StatefulWidget {
  const ScaleOutFadeIn({
    super.key,
    required this.controller,
    this.fadeTween,
    this.scaleTween,
    required this.child,
  });

  final AnimationController controller;
  final Tween<double>? fadeTween, scaleTween;
  final Widget child;

  @override
  State<ScaleOutFadeIn> createState() => _ScaleOutFadeInState();
}

class _ScaleOutFadeInState extends State<ScaleOutFadeIn> {
  late AnimationController _controller;
  late Animation<double> _opacity, _scale;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller;

    _opacity = (widget.fadeTween ?? Tween<double>(begin: 0, end: 1)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0,
          1,
          curve: Curves.easeIn,
        ),
      ),
    );

    _scale = (widget.scaleTween ?? Tween<double>(begin: 3, end: 1)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0,
          1,
          curve: Curves.easeIn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ScaleTransition(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
