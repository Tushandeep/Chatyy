import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';

import '../models/error.dart';

enum DialogType {
  success,
  warning,
  error,
}

class DialogBox extends StatefulWidget {
  const DialogBox({
    super.key,
    required this.error,
    required this.type,
    this.actions,
  });

  final CustomError error;
  final DialogType type;
  final List<Widget>? actions;

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  late ThemeData _theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    late IconData icon;
    late Color iconColor;
    if (widget.type == DialogType.error) {
      icon = Iconsax.close_circle;
      iconColor = Colors.red;
    } else if (widget.type == DialogType.warning) {
      icon = Iconsax.warning_2;
      iconColor = Colors.yellow;
    } else if (widget.type == DialogType.success) {
      icon = Iconsax.tick_circle;
      iconColor = Colors.greenAccent.shade200;
    } else {
      icon = Iconsax.close_circle;
    }
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 20,
              left: 30,
              right: 30,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: _theme.colorScheme.secondary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    widget.error.title,
                    style: _theme.textTheme.titleLarge?.copyWith(
                      color: iconColor,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      .animate(
                        autoPlay: true,
                        delay: const Duration(milliseconds: 50),
                      )
                      .fadeIn(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.error.message,
                  style: _theme.textTheme.bodyLarge?.copyWith(
                    color: _theme.scaffoldBackgroundColor,
                    letterSpacing: 1.05,
                  ),
                )
                    .animate(
                      autoPlay: true,
                      delay: const Duration(milliseconds: 50),
                    )
                    .fadeIn(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    ),
                if (widget.actions != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: widget.actions!,
                  ),
              ],
            ),
          ),
          Positioned(
            top: -26,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _theme.colorScheme.secondary,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 30,
              )
                  .animate(
                    autoPlay: true,
                    delay: const Duration(milliseconds: 300),
                  )
                  .scaleXY(
                    begin: 0,
                    end: 1.3,
                    duration: const Duration(milliseconds: 500),
                    curve: const Interval(
                      0,
                      .7,
                      curve: Curves.easeIn,
                    ),
                  )
                  .scaleXY(
                    begin: 1.3,
                    end: 1,
                    duration: const Duration(milliseconds: 300),
                    delay: const Duration(milliseconds: 200),
                    curve: const Interval(
                      .7,
                      1,
                      curve: Curves.easeOut,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
