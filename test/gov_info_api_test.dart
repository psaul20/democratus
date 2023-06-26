import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:democratus/models/package.dart';
import 'package:test/test.dart';

void main() {
  test('Collection retrieval test', () async {
    CollectionList collections = await GovinfoApi().getCollections();
    expect(collections.getCollectionNames().first, "Congressional Bills");
  });
  test('Package Retrieval Test', () async {
    DateTime startDate = DateTime(2019, 1, 1);
    DateTime endDate = DateTime(2019, 7, 31);
    List collectionCodes = ["BILLS"];
    PackageList result =
        await GovinfoApi().searchPackages(startDate: startDate, collectionCodes: collectionCodes);
    expect(result.packages.first.toMap()["packageId"], "BILLS-116hr809ih");
  });
}
