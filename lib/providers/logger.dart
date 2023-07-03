import 'dart:developer';

import 'package:democratus/models/package.dart';
import 'package:democratus/models/packages_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    //TODO: Figure out why we can't consolidate this (getting logical operator error)
    if (provider.runtimeType == StateProvider<List<Package>>) {
      newValue = newValue as List<Package>;
      List packageIds = newValue.map((e) => e.packageId).toList();
      log('[${provider.name ?? provider.runtimeType}] value: $packageIds');
    }
    if (provider.runtimeType ==
        StateNotifierProvider<PackagesProvider, List<Package>>) {
      newValue = newValue as List<Package>;
      List packageIds = newValue.map((e) => e.packageId.toString()).toList();
      log('[${provider.name ?? provider.runtimeType}] value: $packageIds');
    } else
      log('[${provider.name ?? provider.runtimeType}] value: $newValue');
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}
