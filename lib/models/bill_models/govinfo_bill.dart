import 'dart:convert';
import 'dart:io';

import 'package:democratus/globals/converters/string_converters.dart';
import 'package:democratus/globals/enums/bill_source.dart';
import 'package:democratus/globals/enums/bill_type.dart';
import 'package:democratus/globals/strings.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/models/bill_models/bill_action.dart';
import 'package:democratus/models/bill_models/committee.dart';
import 'package:democratus/models/bill_models/sponsor.dart';
import 'package:xml/xml.dart';

class GovinfoBill extends Bill {
  const GovinfoBill({
    required DateTime introducedDate,
    required String govInfoId,
    int? pages,
    required BillType type,
    required int congress,
    String? originChamber,
    required int number,
    required DateTime lastUpdateDate,
    required String title,
    required BillSource source,
    required String version,
    Uri? billStatusLink,
    Uri? gpoUrl,
    List<Committee>? committees,
    List<BillAction>? actions,
    List<BillSponsor>? sponsors,
    String? policyArea,
    List<String>? subjects,
    List<String>? crsSummaries,
  }) : super(
            introducedDate: introducedDate,
            govInfoId: govInfoId,
            pages: pages,
            type: type,
            congress: congress,
            originChamber: originChamber,
            number: number,
            lastUpdateDate: lastUpdateDate,
            title: title,
            source: source,
            version: version,
            billStatusLink: billStatusLink,
            gpoUrl: gpoUrl,
            committees: committees,
            actions: actions,
            sponsors: sponsors,
            policyArea: policyArea,
            subjects: subjects,
            crsSummaries: crsSummaries);

  factory GovinfoBill.fromDetailBody(String body) {
    Map<String, dynamic> map;
    XmlDocument? xmlDocument;
    if (body.contains('|')) {
      List<String> strings = body.split('|');
      map = jsonDecode(strings[0]);
      xmlDocument = XmlDocument.parse(strings[1]);
    } else {
      map = jsonDecode(body);
    }

    return GovinfoBill(
      introducedDate: DateTime.parse(map['dateIssued']),
      gpoUrl: map['detailsLink'] != null ? Uri.parse(map['detailsLink']) : null,
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
      billStatusLink:
          map['related'] != null && map['related']['billStatusLink'] != null
              ? Uri.parse(map['related']['billStatusLink'])
              : null,
      committees:
          xmlDocument != null ? getCommitteesFromXml(xmlDocument) : null,
      actions: xmlDocument != null ? getActionsFromXml(xmlDocument) : null,
      sponsors: xmlDocument != null ? getSponsorsFromXml(xmlDocument) : null,
      policyArea:
          xmlDocument != null ? getPolicyAreaFromXml(xmlDocument) : null,
      subjects: xmlDocument != null &&
              xmlDocument.findAllElements('subjects').isNotEmpty
          ? xmlDocument
              .findAllElements('subjects')
              .first
              .findAllElements('legislativeSubjects')
              .first
              .findAllElements('name')
              .map((e) => e.text)
              .toList()
          : null,
      crsSummaries: xmlDocument != null &&
              xmlDocument.findAllElements('summaries').isNotEmpty
          ? xmlDocument
              .findAllElements('summaries')
              .first
              .findAllElements('text')
              .map((e) => e.text)
              .toList()
          : null,
    );
  }

  static String? getPolicyAreaFromXml(XmlDocument xmlDocument) {
    if (xmlDocument.findAllElements('policyArea').isEmpty) {
      return null;
    }

    return xmlDocument
        .findAllElements('policyArea')
        .first
        .findAllElements('name')
        .first
        .text;
  }

  static List<BillSponsor> getSponsorsFromXml(XmlDocument xmlDocument) {
    List<BillSponsor> sponsors = [];
    if (xmlDocument.findAllElements('sponsors').isEmpty) {
      return sponsors;
    }
    Iterable<XmlElement> sponsorElements =
        xmlDocument.findAllElements('sponsors').first.childElements;
    for (XmlElement sponsorElement in sponsorElements) {
      String sponsorName = sponsorElement.findElements('fullName').first.text;
      sponsors.add(BillSponsor(
        sponsorFullName: sponsorName,
      ));
    }
    return sponsors;
  }

  static List<BillAction> getActionsFromXml(XmlDocument xmlDocument) {
    List<BillAction> actions = [];
    if (xmlDocument.findAllElements('actions').isEmpty) {
      return actions;
    }
    Iterable<XmlElement> actionElements =
        xmlDocument.findAllElements('actions').first.childElements;
    for (XmlElement actionElement in actionElements) {
      String? actionCode = actionElement.findElements('actionCode').isNotEmpty
          ? actionElement.findElements('actionCode').first.text
          : null;
      String actionDescription = actionElement.findElements('text').first.text;
      String actionDate = actionElement.findElements('actionDate').first.text;
      String actionType = actionElement.findElements('type').first.text;
      actions.add(BillAction(
        type: actionType,
        actionCode: actionCode,
        description: actionDescription,
        actionDate: DateTime.parse(actionDate),
      ));
    }
    return actions;
  }

  static List<Committee> getCommitteesFromXml(XmlDocument xmlDocument) {
    List<Committee> committees = [];
    if (xmlDocument.findAllElements('committees').isEmpty) {
      return committees;
    }
    Iterable<XmlElement> committeeElements =
        xmlDocument.findAllElements('committees').first.childElements;
    for (XmlElement committeeElement in committeeElements) {
      String committeeName = committeeElement.findElements('name').first.text;
      String committeeCode =
          committeeElement.findElements('systemCode').first.text;
      committees.add(Committee(
        description: committeeName,
        code: committeeCode,
      ));
    }
    return committees;
  }

  static String getVersionFromPackageId(String packageId) {
    List<String> strings =
        StringConverters.splitStringIntoChunksCharsOrNums(packageId);
    return strings[4];
  }

  static BillType getTypeFromPackageId(String packageId) {
    List<String> strings =
        StringConverters.splitStringIntoChunksCharsOrNums(packageId);
    String typeString = strings[2];
    return BillType.values
        .firstWhere((element) => typeString == element.typeCode);
  }

  static int getCongressFromPackageId(String packageId) {
    //Split packageID into numbers and characters
    List<String> strings =
        StringConverters.splitStringIntoChunksCharsOrNums(packageId);
    return int.parse(strings[1]);
  }

  static int getBillNumFromPackageId(String packageId) {
    //Split packageID into numbers and characters
    List<String> strings =
        StringConverters.splitStringIntoChunksCharsOrNums(packageId);
    return int.parse(strings[3]);
  }

  factory GovinfoBill.fromResponseBody(String responseBody) {
    return GovinfoBill.fromDetailBody(responseBody);
  }

  static List<GovinfoBill> fromResponseBodyList(String responseBody) {
    final List<Map<String, dynamic>> bills =
        List<Map<String, dynamic>>.from(jsonDecode(responseBody)['results']);
    return List<GovinfoBill>.from(
        bills.map((e) => GovinfoBill.fromDetailBody(jsonEncode(e))));
  }

  factory GovinfoBill.fromExampleJson() {
    String billpath = '${Strings.billFilePath}/govinfo_bill_example.json';
    String billString = File(billpath).readAsStringSync();
    return GovinfoBill.fromResponseBody(billString);
  }

  factory GovinfoBill.fromExampleDetails() {
    String billpathJson = '${Strings.billFilePath}/govinfo_bill_example.json';
    String jsonString = File(billpathJson).readAsStringSync();
    String billpathXml =
        '${Strings.billFilePath}/govinfo_bill_status_example.xml';
    String xmlString = File(billpathXml).readAsStringSync();
    String billString = '$jsonString|$xmlString';
    return GovinfoBill.fromDetailBody(billString);
  }

  static List<GovinfoBill> fromExampleKeywordSearch() {
    String billpath =
        '${Strings.billFilePath}/govinfo_bill_search_example.json';
    String billString = File(billpath).readAsStringSync();
    return fromResponseBodyList(billString);
  }
}
