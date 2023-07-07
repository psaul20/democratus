import 'package:democratus/models/package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final savedPackagesProvider =
    StateNotifierProvider<PackagesProvider, List<Package>>(
  (ref) => PackagesProvider([]),
);

final thisPackageProvider = StateNotifierProvider<PackageProvider, Package>((ref) =>
    throw UnimplementedError("Did not implement thisPackage for this scope"));
