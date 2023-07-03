import 'package:democratus/models/package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Better to use AsyncNotifier?
class PackagesProvider extends StateNotifier<List<Package>> {
  PackagesProvider(List<Package> packages) : super(packages);

  void replacePackages(List<Package> packages) {
    state = packages;
  }

  void addPackage(Package package) {
    state = [...state, package];
  }

  void removePackage(Package package) {
    state = [
      for (final package in state)
        if (package.packageId != package.packageId) package,
    ];
  }
}
