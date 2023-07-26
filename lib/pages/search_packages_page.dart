// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:democratus/blocs/filtered_packages/filtered_packages_bloc.dart';
import 'package:democratus/blocs/package_search_bloc.dart';
import 'package:democratus/blocs/saved_package_bloc.dart';
import 'package:democratus/models/package.dart';
import 'package:democratus/widgets/generic/errors.dart';
import 'package:democratus/widgets/package_widgets/package_sliver_list.dart';
import 'package:democratus/widgets/search_widgets/package_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: Sort by last action date
// TODO: Search by text

class SearchPackagesPage extends StatelessWidget {
  const SearchPackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: Can probably be simplified
      body: CustomScrollView(slivers: [
        const PackageSearchBar(),
        BlocBuilder<PackageSearchBloc, PackageSearchState>(
            builder: (context, state) {
          List<Package> packages = state.searchPackages;
          switch (state.status) {
            case PackageSearchStatus.failure:
              {
                return SliverList(
                    delegate: SliverChildListDelegate([
                  const Center(child: Expanded(child: ErrorText())),
                ]));
              }
            case PackageSearchStatus.success:
              {
                return BlocProvider(
                  create: (context) =>
                      FilteredPackagesBloc()..add(InitPackages(packages)),
                  child: BlocListener<PackageSearchBloc, PackageSearchState>(
                    listener: (context, state) {
                      context.read<FilteredPackagesBloc>().add(InitPackages(
                          context
                              .read<PackageSearchBloc>()
                              .state
                              .searchPackages));
                    },
                    child: const FilterPackageSliverList(),
                  ),
                );
              }
            case PackageSearchStatus.initial:
              {
                return SliverList(delegate: SliverChildListDelegate([]));
              }
          }
        })
      ]),
    );
  }
}
