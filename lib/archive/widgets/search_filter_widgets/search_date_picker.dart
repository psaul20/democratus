
import 'package:democratus/archive/bloc/filtered_packages/filtered_packages_bloc.dart';
import 'package:democratus/archive/bloc/package_search_bloc.dart';
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
    return BlocBuilder<FilteredPackagesBloc, FilteredPackagesState>(
        buildWhen: (previous, current) =>
            (previous.startDateFilter, previous.endDateFilter) !=
            (current.startDateFilter, current.endDateFilter),
        builder: (context, state) {
          DateTime? selectedDate;
          isStartDate != null && isStartDate!
              ? selectedDate = state.startDateFilter
              : selectedDate = state.endDateFilter;

          Future<void> selectDate(BuildContext context) async {
            final capturedContext = context;

            DateTime? lastDate;
            DateTime? firstDate;

            if (isStartDate == true) {
              lastDate = state.endDateFilter;
            } else if (isEndDate == true) {
              firstDate = state.startDateFilter;
            }

            final DateTime? picked = await showDatePicker(
              context: capturedContext,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: firstDate ?? DateTime(1776, 7, 4),
              lastDate: lastDate ?? DateTime.now(),
            );

            if (picked != null) {
              context.read<FilteredPackagesBloc>().add(isStartDate == true
                  ? UpdateStartDateFilter(picked)
                  : UpdateEndDateFilter(picked));
              try {
                context.read<PackageSearchBloc>().add(isStartDate == true
                    ? SelectStartDate(picked)
                    : SelectEndDate(picked));
              } catch (_) {}
            }
          }

          return TextButton.icon(
              icon: const Icon(Icons.calendar_month),
              onPressed: () => selectDate(context),
              label: Builder(builder: (context) {
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
