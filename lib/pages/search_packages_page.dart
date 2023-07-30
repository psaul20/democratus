// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';
import 'package:democratus/blocs/filtered_packages/filtered_packages_bloc.dart';
import 'package:democratus/blocs/package_search_bloc.dart';
import 'package:democratus/widgets/generic/errors.dart';
import 'package:democratus/widgets/package_widgets/package_sliver_list.dart';
import 'package:democratus/widgets/search_widgets/package_search_bar.dart';
import 'package:democratus/widgets/search_widgets/search_filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPackagesPage extends StatelessWidget {
  const SearchPackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageSearchBloc, PackageSearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Legislation Search",
              style: const TextStyle()
                  .copyWith(color: Theme.of(context).colorScheme.onSecondary),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => BlocProvider.value(
                              value:
                                  BlocProvider.of<PackageSearchBloc>(context),
                              child: const SearchFilterDialog(),
                            ));
                  },
                  icon: Icon(
                    Icons.filter_list,
                    color: Theme.of(context).colorScheme.onSecondary,
                  )),
            ],
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          body: BlocProvider(
            create: (context) =>
                FilteredPackagesBloc()..add(InitPackages(state.searchPackages)),
            child: BlocConsumer<PackageSearchBloc, PackageSearchState>(
                listener: (context, state) {
              context.read<FilteredPackagesBloc>().add(InitPackages(
                  context.read<PackageSearchBloc>().state.searchPackages));
            }, builder: (context, state) {
              switch (state.status) {
                case PackageSearchStatus.failure:
                  {
                    return const Center(
                      child: ErrorText(),
                    );
                  }
                default:
                  {
                    return const CustomScrollView(
                      slivers: [
                        PackageSearchBar(),
                        FilterPackageSliverList(),
                      ],
                    );
                  }
              }
            }),
          ),
        );
      },
    );
  }
}
