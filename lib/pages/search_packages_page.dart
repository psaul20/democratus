// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:democratus/blocs/package_search_bloc.dart';
import 'package:democratus/models/package.dart';
import 'package:democratus/widgets/generic/errors.dart';
import 'package:democratus/widgets/package_widgets/package_sliver_list.dart';
import 'package:democratus/widgets/search_widgets/package_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: Update search to load 10 at a time, not just 10
// TODO: Sort by last action date
// TODO: Search by text

class SearchPackagesPage extends StatelessWidget {
  const SearchPackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        const SliverAppBar(
          title: Text("Search Documents"),
          //TODO: Figure out how to make this flexible size
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(240),
            child: PackageSearchBar(),
          ),
          floating: true,
        ),
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
                return PackageSliverList(packages: packages);
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
