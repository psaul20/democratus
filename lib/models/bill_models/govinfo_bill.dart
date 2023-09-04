import 'dart:convert';
import 'dart:io';

import 'package:democratus/globals/converters/string_converters.dart';
import 'package:democratus/globals/enums/bill_source.dart';
import 'package:democratus/globals/enums/bill_type.dart';
import 'package:democratus/globals/strings.dart';
import 'package:democratus/models/bill_models/bill.dart';

class GovinfoBill extends Bill {
  GovinfoBill.fromMap(Map<String, dynamic> map)
      : super(
          introducedDate: DateTime.parse(map['dateIssued']),
          gpoUrl:
              map['detailsLink'] != null ? Uri.parse(map['detailsLink']) : null,
          govInfoId: map['packageId'],
          pages: map['pages'] != null ? int.parse(map['pages']) : null,
          type: getTypeFromPackageId(map['packageId']),
          congress: getCongressFromPackageId(map['packageId']),
          originChamber: map['originChamber'],
          number: getBillNumFromPackageId(map['packageId']),
          lastUpdateDate: DateTime.parse(map['lastModified']),
          title: map['title'],
          source: BillSource.govinfo,
          version: getVersionFromPackageId(map['packageId']),
        );

    static String getVersionFromPackageId(String packageId) {
    List<String> strings = StringConverters.splitStringIntoChunks(packageId);
    return strings[4];
  }

  static BillType getTypeFromPackageId(String packageId) {
    List<String> strings = StringConverters.splitStringIntoChunks(packageId);
    String typeString = strings[2];
    return BillType.values
        .firstWhere((element) => typeString == element.typeCode);
  }

  static int getCongressFromPackageId(String packageId) {
    //Split packageID into numbers and characters
    List<String> strings = StringConverters.splitStringIntoChunks(packageId);
    return int.parse(strings[1]);
  }

  static int getBillNumFromPackageId(String packageId) {
    //Split packageID into numbers and characters
    List<String> strings = StringConverters.splitStringIntoChunks(packageId);
    return int.parse(strings[3]);
  }

  factory GovinfoBill.fromResponseBody(String responseBody) {
    return GovinfoBill.fromMap(
        Map<String, dynamic>.from(jsonDecode(responseBody)));
  }

  static List<GovinfoBill> fromResponseBodyList(String responseBody) {
    final List<Map<String, dynamic>> bills =
        List<Map<String, dynamic>>.from(jsonDecode(responseBody)['results']);
    return List<GovinfoBill>.from(bills.map((e) => GovinfoBill.fromMap(e)));
  }

  factory GovinfoBill.fromExample() {
    String billpath = '${Strings.billFilePath}/govinfo_bill_example.json';
    String billString = File(billpath).readAsStringSync();
    return GovinfoBill.fromResponseBody(billString);
  }

  static List<GovinfoBill> fromExampleKeywordSearch() {
    String billpath =
        '${Strings.billFilePath}/govinfo_bill_search_example.json';
    String billString = File(billpath).readAsStringSync();
    return fromResponseBodyList(billString);
  }
}
