import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key, required this.onChanged});
  final void Function(String text) onChanged;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.search),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextField(
            controller: controller,
            decoration:
                const InputDecoration().copyWith(hintText: 'Keyword Search'),
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
