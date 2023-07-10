import 'dart:developer';

import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:democratus/models/package.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';

void main() async {
  String testID = 'BILLS-116hr809ih';
  test('Get Package by ID Test', () async {
    Response response = await GovinfoApi().getPackageById(testID);
    Package testPackage = Package.fromJson(response.body);
    expect(testPackage.packageId, testID);
  });

  test('Collection retrieval test', () async {
    Response response = await GovinfoApi().getCollections();
    CollectionList collections = CollectionList.fromJson(response.body);
    expect(collections.getCollectionNames().first, "Congressional Bills");
  });

  test('Package List Retrieval Test', () async {
    DateTime startDate = DateTime(2019, 1, 1);
    DateTime endDate = DateTime(2019, 7, 31);
    List collectionCodes = ["BILLS"];
    Response response = await GovinfoApi().searchPackages(
        startDate: startDate,
        endDate: endDate,
        collectionCodes: collectionCodes);
    PackageList result = PackageList.fromJson(response.body);
    expect(result.packages.length, greaterThan(0));
    Package package = result.packages.first;
    response = await GovinfoApi().getPackageById(package.packageId);
    package = Package.fromJson(response.body);
    expect(package.collectionCode, collectionCodes[0]);
  });
  test('HTML Retrieval Test', () async {
    Response response = await GovinfoApi().getPackageById(testID);
    Package package = Package.fromJson(response.body);
    String result = await GovinfoApi().getHtml(package);
    log("Test HTML: $result");
    expect(result.isNotEmpty, true);
  });
}
