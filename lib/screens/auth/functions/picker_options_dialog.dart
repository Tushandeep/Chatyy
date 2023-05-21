part of '../auth_screen.dart';

void _pickerOptions(
  BuildContext context,
  Function(File) setImage,
) async {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: _theme.colorScheme.secondary,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPickerTile(
                      Iconsax.gallery,
                      "Gallery",
                      () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery, setImage);
                      },
                    ),
                    const SizedBox(width: 40),
                    _buildPickerTile(
                      Iconsax.camera,
                      "Camera",
                      () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera, setImage);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: -34,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _theme.colorScheme.secondary,
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: _theme.colorScheme.primary,
                  size: 34,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPickerTile(
  IconData icon,
  String label,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _theme.colorScheme.primary,
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: _theme.scaffoldBackgroundColor,
            size: 38,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: _theme.textTheme.bodyLarge?.copyWith(
              color: _theme.scaffoldBackgroundColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    ),
  );
}
