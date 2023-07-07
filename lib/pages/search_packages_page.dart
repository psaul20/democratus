// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:democratus/models/package.dart';
import 'package:democratus/providers/package_providers.dart';
import 'package:democratus/providers/search_providers.dart';
import 'package:democratus/widgets/package_widgets/package_sliver_list.dart';
import 'package:democratus/widgets/package_widgets/package_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Consolidate providers?
// TODO: Update search to load 10 at a time, not just 10
// TODO: Sort by last action date
// TODO: Search by text
// TODO: Make search parameters a drawer/Sliverlist
// TODO: Fix search/remove button look and feel (possible as an overlay)
// TODO: Hero animation transition
// TODO: Reader page
// TODO: Better date specification//Basing Riverpod implementation off of https://www.youtube.com/watch?v=Zp7

class SearchPackagesPage extends ConsumerWidget {
  const SearchPackagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Package> packages = ref.watch(searchPackagesProvider);
    return Scaffold(
      body: CustomScrollView(slivers: [
        const SliverAppBar(
          title: Text("Search Documents"),
          //TODO: Figure out how to make this flexible size
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(240), child: PackageSearchBar()),
          floating: true,
        ),
        PackageSliverList(packages: packages)
      ]),
    );
  }
}
