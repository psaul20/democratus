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
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Fetching Data",
              style: txtStyle,
            ),
          ),
          const CircularProgressIndicator()
        ],
      ),
    );
  }
}
