import 'package:democratus/blocs/package_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SearchDatePicker extends StatelessWidget {
  const SearchDatePicker({super.key, this.isStartDate, this.isEndDate});
  final bool? isStartDate;
  final bool? isEndDate;

  @override
  Widget build(BuildContext context) {
    assert(!(isStartDate == true && isEndDate == true));
    assert(isStartDate == true || isEndDate == true);
    return BlocBuilder<PackageSearchBloc, PackageSearchState>(
        builder: (context, state) {
      DateTime? selectedDate;
      isStartDate != null && isStartDate!
          ? selectedDate = state.startDate
          : selectedDate = state.endDate;

      Future<void> selectDate(BuildContext context) async {
        final capturedContext = context;

        DateTime? lastDate;
        DateTime? firstDate;

        if (isStartDate == true && state.endDate != null) {
          lastDate = state.endDate;
        } else if (isEndDate == true && state.startDate != null) {
          firstDate = state.startDate;
        }

        final DateTime? picked = await showDatePicker(
          context: capturedContext,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(1776),
          lastDate: lastDate ?? DateTime.now(),
        );

        if (picked != null) {
          //TODO: Determine if this is actually an issue
          capturedContext.read<PackageSearchBloc>().add(isStartDate == true
              ? SelectStartDate(picked)
              : SelectEndDate(picked));
        }
      }

      return ElevatedButton(
          onPressed: () => selectDate(context),
          child: Builder(builder: (context) {
            if (selectedDate != null) {
              return Text(DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                  .format(selectedDate));
            } else {
              return const Text("Select Date");
            }
          }));
    });
  }
}
