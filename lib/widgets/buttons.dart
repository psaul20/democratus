
import 'package:democratus/styles/text_styles.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.onTap, required this.isSaved});
  final void Function()? onTap;
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(isSaved ? Icons.favorite : Icons.favorite_border),
          Text(
            isSaved ? "Saved" : "Save",
            textAlign: TextAlign.center,
            style: TextStyles.iconText,
          )
        ],
      ),
    );
  }
}
