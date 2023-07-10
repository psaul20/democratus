import 'package:democratus/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Something went wrong...", style: TextStyles.errorText,);
  }
}