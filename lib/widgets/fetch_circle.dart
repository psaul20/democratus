import 'package:flutter/material.dart';

class FetchCircle extends StatelessWidget {
  const FetchCircle({super.key, TextStyle? txtStyle});
  final TextStyle? txtStyle = null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Fetching Data",
            style: txtStyle,
          ),
          const CircularProgressIndicator()
        ],
      ),
    );
  }
}
