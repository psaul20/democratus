import 'package:democratus/models/package.dart';
import 'package:democratus/models/packages_provider.dart';
import 'package:democratus/widgets/package_widgets/package_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PackageListColumn extends ConsumerWidget {
  const PackageListColumn({
    super.key,
    required this.packagesProvider,
  });
  final StateNotifierProvider<PackagesProvider, List<Package>> packagesProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Package> packages = ref.watch(packagesProvider);
    List<Widget> tiles = [];
    for (var element in packages) {
      StateNotifierProvider<PackageProvider, Package> packageProvider =
          StateNotifierProvider<PackageProvider, Package>(
              (ref) => PackageProvider(element));
      tiles.add(PackageTile(
        packageProvider: packageProvider,
      ));
    }
    return Column(children: tiles);
  }
}
