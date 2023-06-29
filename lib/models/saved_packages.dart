import 'package:democratus/models/package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Better to use AsyncNotifier?
class SavedPackages extends StateNotifier<List<Package>> {
  SavedPackages() : super([]);

  void savePackage(Package package) {
    state = [...state, package.copyWith(isSaved: true)];
    package.isSaved = true;
  }

  void removePackage(Package package) {
    state = [
      for (final package in state)
        if (package.packageId != package.packageId) package,
    ];
    package.isSaved = false;
  }
}
