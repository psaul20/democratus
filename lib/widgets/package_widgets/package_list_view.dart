import 'package:democratus/models/package.dart';
import 'package:democratus/widgets/package_widgets/package_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PackageListView extends ConsumerWidget {
  const PackageListView({
    super.key,
    required this.packagesProvider,
  });
  final StateNotifierProvider<PackagesProvider, List<Package>> packagesProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Package> packages = ref.watch(packagesProvider);
    return ListView.builder(
        itemCount: packages.length,
        itemBuilder: ((context, index) {
          Package package = packages.elementAt(index);
          return PackageTile(packagesProvider: packagesProvider, packageId: package.packageId,);
        }));
  }
}
