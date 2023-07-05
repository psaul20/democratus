import 'package:democratus/models/package.dart';
import 'package:democratus/widgets/package_widgets/package_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PackageListColumn extends ConsumerWidget {
  const PackageListColumn({
    super.key,
    required this.packagesProvider,
  });
  final StateNotifierProvider<PackagesProvider, List<Package>> packagesProvider;

  //TODO: write test to ensure packageprovider checksaved is working
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Package> packages = ref.watch(packagesProvider);
    List<Widget> tiles = [];
    for (var package in packages) {
      tiles.add(PackageTile(
        packagesProvider: packagesProvider,
        packageId: package.packageId,
      ));
    }
    return Column(children: tiles);
  }
}
