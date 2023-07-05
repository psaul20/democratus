import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:democratus/models/package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final collectionsProvider = FutureProvider<List<Collection>>((ref) async {
  CollectionList collections = await GovinfoApi().getCollections();
  return collections.asList;
});

final selectedCollectionProvider = StateProvider<Collection?>((ref) {
  final collections = ref.watch(collectionsProvider);
  if (collections.hasValue) {
    return collections.value?.first;
  }
  return null;
});

final startDateInputProvider = StateProvider<DateTime?>(
  (ref) => null,
);

final endDateInputProvider = StateProvider<DateTime?>(
  (ref) => null,
);

final queryParamsProvider = StateProvider<Map>((ref) {
  final Map<String, String?> queryParams = {};
  queryParams["collectionCode"] =
      ref.watch(selectedCollectionProvider)?.collectionCode;
  queryParams["startDate"] = ref.watch(startDateInputProvider).toString();
  queryParams["endDate"] = ref.watch(endDateInputProvider).toString();
  return queryParams;
});

final canSearchProvider = StateProvider<bool>((ref) {
  bool canSearch = false;
  if (ref.watch(selectedCollectionProvider) != null &&
      ref.watch(startDateInputProvider) != null &&
      ref.watch(endDateInputProvider) != null) {
    canSearch = true;
  }
  return canSearch;
});

final searchPackagesProvider =
    StateNotifierProvider<PackagesProvider, List<Package>>(
        (ref) => PackagesProvider([]));
