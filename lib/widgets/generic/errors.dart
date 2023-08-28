import 'package:democratus/globals/enums/errors.dart';
import 'package:democratus/theming/text_styles.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final Errors error;

  const ErrorText({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessages[error]!,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
      textAlign: TextAlign.center,
    );
  }
}
