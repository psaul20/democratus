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
  }
}

// class PackageListColumn extends StatelessWidget {
//   const PackageListColumn({
//     super.key,
//     required this.packages,
//   });
//   final List<Package> packages;

//   @override
//   Widget build(BuildContext context) {
//     if (packages.isEmpty) {
//       return const SizedBox.shrink();
//     } else {
//       List<Widget> tiles = [];
//       for (var package in packages) {
//         tiles.add(BlocProvider<PackageBloc>(
//           create: (_) => PackageBloc(package),
//           child: const PackageTile(),
//         ));
//       }
//       return Column(children: tiles);
//     }
//   }
// }
