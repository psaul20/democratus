import 'package:democratus/models/package.dart';
import 'package:democratus/models/packages_provider.dart';
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
          StateNotifierProvider<PackageProvider, Package> packageProvider =
              StateNotifierProvider<PackageProvider, Package>(
                  (ref) => PackageProvider(packages.elementAt(index)));
          return PackageTile(packageProvider: packageProvider);
        }));
  }
}
