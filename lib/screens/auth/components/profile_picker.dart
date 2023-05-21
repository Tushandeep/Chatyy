part of '../auth_screen.dart';

class ProfilePickerWidget extends StatefulWidget {
  const ProfilePickerWidget({
    super.key,
  });

  @override
  State<ProfilePickerWidget> createState() => _ProfilePickerWidgetState();
}

class _ProfilePickerWidgetState extends State<ProfilePickerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  void _setImage(File image) {
    setState(() {
      _photo.value = image;
    });
  }

  Function() get listener => () {
        if (_photo.value == null && _controller.isCompleted) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      };

  @override
  void initState() {
    super.initState();

    _photo = ValueNotifier(null);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _photo.addListener(listener);
  }

  @override
  void dispose() {
    _photo.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickerOptions(context, _setImage),
      child: Align(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _theme.colorScheme.secondary,
                  image: (_photo.value != null)
                      ? DecorationImage(
                          image: FileImage(_photo.value!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                alignment: Alignment.center,
              ),
              AnimatedPositioned(
                right: (_photo.value != null) ? 10 : null,
                bottom: (_photo.value != null) ? 10 : null,
                duration: const Duration(seconds: 1),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: (_photo.value != null)
                      ? BoxDecoration(
                          color: _theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        )
                      : null,
                  child: Icon(
                    Iconsax.user,
                    color: _theme.scaffoldBackgroundColor,
                  )
                      .animate(
                        autoPlay: false,
                        controller: _controller,
                      )
                      .scaleXY(
                        begin: 3,
                        end: 1,
                        duration: const Duration(milliseconds: 100),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
