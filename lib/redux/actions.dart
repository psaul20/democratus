// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:democratus/models/collection.dart';

class GetCollectionsAction {
  List<Collection> collections;
  GetCollectionsAction(this.collections);
}

class SelectCollectionAction {
  Collection collection;
  SelectCollectionAction(this.collection);
}

class QueryUpdateAction {
  Map<String, String> queryParams;
  QueryUpdateAction(this.queryParams);
}

class CollectionSelectionAction {
  Collection collection;
  final String _paramsKey = "selectedCollection";
  CollectionSelectionAction(this.collection);

  String get paramsKey => _paramsKey;
}

class PackageSearchAction {}

class SearchParamsUpdateAction {
  Collection collection;
  DateTime startDate;
  DateTime endDate;
  SearchParamsUpdateAction({
    required this.collection,
    required this.startDate,
    required this.endDate,
  });
}

class GetPackagesAction {}
