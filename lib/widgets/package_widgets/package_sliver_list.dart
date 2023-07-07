import 'package:democratus/models/package.dart';
import 'package:democratus/providers/package_providers.dart';
import 'package:democratus/widgets/package_widgets/package_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        packages.isEmpty
            ? const SizedBox.shrink()
            : PackageListColumn(
              packages: packages,
            )
      ],
    ));
  }
}

class PackageListColumn extends ConsumerWidget {
  const PackageListColumn({
    super.key,
    required this.packages,
  });
  final List<Package> packages;

  //TODO: write test to ensure packageprovider checksaved is working
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (packages.isEmpty) {
      return const SizedBox.shrink();
    } else {
      List<Widget> tiles = [];
      for (var package in packages) {
        tiles.add(ProviderScope(
          overrides: [thisPackageProvider.overrideWith((ref) => PackageProvider(package))],
          child: const PackageTile(),
        ));
      }
      return Column(children: tiles);
    }
  }
}
