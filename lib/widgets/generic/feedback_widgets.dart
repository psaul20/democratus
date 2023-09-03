// ignore_for_file: public_member_api_docs, sort_constructors_first
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
        const SizedBox(height: 8),
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
  const ErrorFeedback({
    Key? key,
    required this.errorMessage,
    this.onRetry,
  }) : super(key: key);
  final String errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Text(errorMessage,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: DemocScheme.scheme.error,
              ),
          textAlign: TextAlign.center),
      const SizedBox(height: 8),
    ];
    if (onRetry != null) {
      children.add(ElevatedButton(
        onPressed: onRetry,
        child: const Text("RETRY"),
      ));
    }
    children.add(const SizedBox(height: 8));
    children.add(ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("BACK")));

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, children: children));
  }
}
