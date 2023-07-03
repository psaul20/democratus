import 'dart:developer';

import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:democratus/models/package.dart';
import 'package:test/test.dart';

void main() async {
  String testID = 'BILLS-116hr809ih';
  test('Get Package by ID Test', () async {
    Package testPackage = await GovinfoApi().getPackageById(testID);
    expect(testPackage.packageId, testID);
  });

  test('Collection retrieval test', () async {
    CollectionList collections = await GovinfoApi().getCollections();
    expect(collections.getCollectionNames().first, "Congressional Bills");
  });
  test('Package Retrieval Test', () async {
    DateTime startDate = DateTime(2019, 1, 1);
    DateTime endDate = DateTime(2019, 7, 31);
    List collectionCodes = ["BILLS"];
    PackageList result = await GovinfoApi()
        .searchPackages(startDate: startDate, collectionCodes: collectionCodes);
    expect(result.packages.length, greaterThan(0));
  });
  test('HTML Retrieval Test', () async {
    Package testPackage = await GovinfoApi().getPackageById(testID);
    String result = await GovinfoApi().getHtml(testPackage);
    log("Test HTML: $result");
    expect(result.isNotEmpty, true);
  });
}
