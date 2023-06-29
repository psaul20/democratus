import 'package:democratus/styles/text_styles.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.onTap, required this.isSaved});
  final void Function()? onTap;
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(isSaved ? Icons.favorite : Icons.favorite_border),
                Text(
                  isSaved ? "Saved" : "Save",
                  textAlign: TextAlign.center,
                  style: TextStyles.iconText,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReadMoreButton extends StatelessWidget {
  const ReadMoreButton({
    super.key,
    required this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.chrome_reader_mode_outlined),
                Text(
                  "Read More",
                  textAlign: TextAlign.center,
                  style: TextStyles.iconText,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
