
import 'package:democratus/archive/bloc/filtered_packages/filtered_packages_bloc.dart';
import 'package:democratus/archive/bloc/package_bloc.dart';
import 'package:democratus/archive/widgets/package_widgets/package_tile.dart';
import 'package:democratus/models/package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterPackageSliverList extends StatelessWidget {
  const FilterPackageSliverList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredPackagesBloc, FilteredPackagesState>(
      builder: (context, state) {
        List<Package> packages = state.filteredList;
        return packages.isEmpty
            ? SliverList(
                delegate: SliverChildListDelegate([const SizedBox.shrink()]),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                return BlocProvider<PackageBloc>(
                    key: ValueKey(packages[index].packageId),
                    create: (_) => PackageBloc(packages[index]),
                    child: const PackageTile());
              }, childCount: packages.length));
      },
    );
  }
}
