import 'package:democratus/providers/search_providers.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateTextField extends ConsumerStatefulWidget {
  const DateTextField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends ConsumerState<DateTextField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DateTime? initialDate = ref.read(startDateInputProvider.notifier).state;
    String initialString = '';
    initialDate != null
        ? initialString = DateFormat("y-MM-dd").format(initialDate)
        : initialString;
    return Form(
      key: _formKey,
      child: TextFormField(
        initialValue: initialString,
        style: TextStyles.inputStyle,
        // inputFormatters: [
        // Not working with iOS Simulator on Mac
        // FilteringTextInputFormatter.allow(RegExp(r'^\d{4}-\d{2}-\d{2}$')),
        // ],
        decoration: const InputDecoration(
          hintText: "Format: 1776-04-07",
        ),
        validator: (value) {
          if (value != null && DateTime.tryParse(value) != null) {
            return null;
          } else if (value == null) {
            return null;
          } else {
            return "Format must be YYYY-MM-DD";
          }
        },
        onChanged: (value) {
          if (_formKey.currentState!.validate()) {
            ref.read(startDateInputProvider.notifier).state =
                DateTime.parse(value);
          } else {
            ref.read(startDateInputProvider.notifier).state = null;
          }
        },
      ),
    );
  }
}
