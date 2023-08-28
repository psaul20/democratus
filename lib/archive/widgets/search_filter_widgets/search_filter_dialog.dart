import 'package:democratus/archive/bloc/filtered_packages/filtered_packages_bloc.dart';
import 'package:democratus/archive/bloc/package_search_bloc.dart';
import 'package:democratus/theming/theme_data.dart';
import 'package:democratus/archive/widgets/search_filter_widgets/search_date_picker.dart';
import 'package:democratus/archive/widgets/search_filter_widgets/docclass_filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFilterDialog extends StatelessWidget {
  const SearchFilterDialog({super.key});
  @override
  Widget build(BuildContext context) {
    FilteredPackagesState initState =
        context.read<FilteredPackagesBloc>().state;
    return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "FILTERS",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 2,
                color: DemocScheme.scheme.onBackground,
              ),
              const SizedBox(
                height: 10,
              ),
              Text('DATE PUBLISHED',
                  style: Theme.of(context).textTheme.bodyLarge),
              Row(
                children: [
                  const SearchDatePicker(isStartDate: true),
                  Text(
                    'to',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SearchDatePicker(isEndDate: true),
                ],
              ),
              Text('TYPE', style: Theme.of(context).textTheme.bodyLarge),
              const DocClassFilterList(),
              Center(
                child: TextButton(
                    onPressed: () {
                      FilteredPackagesState newState =
                          context.read<FilteredPackagesBloc>().state;
                      // If filter state changed, submit search
                      if (newState != initState) {
                        try {
                          context.read<PackageSearchBloc>().add(SubmitSearch());
                        } catch (_) {}
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('DONE')),
              )
            ],
          ),
        ));
  }
}
