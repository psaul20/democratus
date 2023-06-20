// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

// See https://api.govinfo.gov/collections?api_key=DEMO_KEY for example
class CollectionList {
  List<Collection> collectionsList;
  CollectionList({
    required this.collectionsList,
  });

  List<String> getCollectionNames() {
    List<String> collectionNames = [];
    for (var element in collectionsList) {
      collectionNames.add(element.collectionName);
    }
    return collectionNames;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'collectionsList': collectionsList.map((x) => x.toMap()).toList(),
    };
  }

  factory CollectionList.fromMap(Map<String, dynamic> map) {
    return CollectionList(
      collectionsList: List<Collection>.from(
        (map['collectionsList'] as List<int>).map<Collection>(
          (x) => Collection.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectionList.fromJson(String source) =>
      CollectionList.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Collection {
  String collectionCode;
  String collectionName;
  int packageCount;
  int? granuleCount;
  Collection({
    required this.collectionCode,
    required this.collectionName,
    required this.packageCount,
    this.granuleCount,
  });

  Collection copyWith({
    String? collectionCode,
    String? collectionName,
    int? packageCount,
    int? granuleCount,
  }) {
    return Collection(
      collectionCode: collectionCode ?? this.collectionCode,
      collectionName: collectionName ?? this.collectionName,
      packageCount: packageCount ?? this.packageCount,
      granuleCount: granuleCount ?? this.granuleCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'collectionCode': collectionCode,
      'collectionName': collectionName,
      'packageCount': packageCount,
      'granuleCount': granuleCount,
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      collectionCode: map['collectionCode'] as String,
      collectionName: map['collectionName'] as String,
      packageCount: map['packageCount'] as int,
      granuleCount:
          map['granuleCount'] != null ? map['granuleCount'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Collection.fromJson(String source) =>
      Collection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Collection(collectionCode: $collectionCode, collectionName: $collectionName, packageCount: $packageCount, granuleCount: $granuleCount)';
  }

  @override
  bool operator ==(covariant Collection other) {
    if (identical(this, other)) return true;

    return other.collectionCode == collectionCode &&
        other.collectionName == collectionName &&
        other.packageCount == packageCount &&
        other.granuleCount == granuleCount;
  }

  @override
  int get hashCode {
    return collectionCode.hashCode ^
        collectionName.hashCode ^
        packageCount.hashCode ^
        granuleCount.hashCode;
  }
}