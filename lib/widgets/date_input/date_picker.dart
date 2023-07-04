import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MyDatePicker extends ConsumerStatefulWidget {
  const MyDatePicker(
      {super.key, required this.dateProvider, this.afterDateProvider});
  final StateProvider<DateTime?>? afterDateProvider;
  final StateProvider<DateTime?> dateProvider;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MyDatePickerState();
}

class MyDatePickerState extends ConsumerState<MyDatePicker> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? firstDate;
    DateTime? selectedDate = ref.read(widget.dateProvider);
    if (widget.afterDateProvider != null) {
      firstDate = ref.watch(widget.afterDateProvider!);
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1776),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      ref.read(widget.dateProvider.notifier).state = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate = ref.watch(widget.dateProvider);
    return ElevatedButton(
        onPressed: () => _selectDate(context),
        child: Builder(builder: (context) {
          if (selectedDate != null) {
            return Text(DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                .format(selectedDate));
          } else {
            return const Text("Select Date");
          }
        }));
  }
}
