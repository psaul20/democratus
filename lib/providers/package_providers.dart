import 'package:democratus/models/package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final savedPackagesProvider =
    StateNotifierProvider<PackagesProvider, List<Package>>(
  (ref) => PackagesProvider([]),
);