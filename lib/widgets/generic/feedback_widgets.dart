import 'package:democratus/theming/theme_data.dart';
import 'package:flutter/material.dart';

class LoadingFeedback extends StatelessWidget {
  const LoadingFeedback({
    super.key,
    required this.loadingTxt,
  });
  final String loadingTxt;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 4),
        Text(
          loadingTxt,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class ErrorFeedback extends StatelessWidget {
  const ErrorFeedback({super.key, required this.errorMessage});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: DemocScheme.scheme.error,
          ),
      textAlign: TextAlign.center,
    );
  }
}
