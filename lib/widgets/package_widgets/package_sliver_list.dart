import 'package:democratus/blocs/package_bloc.dart';
import 'package:democratus/models/package.dart';
import 'package:democratus/widgets/package_widgets/package_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageSliverList extends StatelessWidget {
  const PackageSliverList({
    super.key,
    required this.packages,
  });

  final List<Package> packages;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate(
      [
        //TODO: Update with fetch data button while fetching
        PackageListColumn(
          packages: packages,
        )
      ],
    ));
  }
}

class PackageListColumn extends StatelessWidget {
  const PackageListColumn({
    super.key,
    required this.packages,
  });
  final List<Package> packages;

  @override
  Widget build(BuildContext context) {
    if (packages.isEmpty) {
      return const SizedBox.shrink();
    } else {
      List<Widget> tiles = [];
      for (var package in packages) {
        tiles.add(BlocProvider<PackageBloc>(
          create: (_) => PackageBloc(package),
          child: const PackageTile(),
        ));
      }
      return Column(children: tiles);
    }
  }
}
