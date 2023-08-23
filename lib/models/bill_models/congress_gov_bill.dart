// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import
import 'dart:convert';
import 'dart:math';

import 'package:democratus/enums/bill_source.dart';
import 'package:democratus/enums/bill_type.dart';
import 'package:equatable/equatable.dart';

//TODO: Conform to Bill class
class CongressGovBill extends Equatable {
  //From CongressGov API
  final Map<String, dynamic>? actions;
  final Map<String, dynamic>? amendments;
  final List<Map<String, dynamic>>? cboCostEstimates;
  final List<Map<String, dynamic>>? committeeReports;
  final Map<String, dynamic>? committees;
  final int congress;
  final String? constitutionalAuthorityStatementText;
  final Map<String, dynamic>? cosponsors;
  final DateTime? introducedDate;
  final Map<String, dynamic>? latestAction;
  final List<Map<String, String>>? laws;
  final int number;
  final String? originChamber;
  final Map<String, String>? policyArea;
  final Map<String, dynamic>? relatedBills;
  final List<Map<String, dynamic>>? sponsors;
  final Map<String, dynamic>? subjects;
  final Map<String, dynamic>? summaries;
  final String title;
  final Map<String, dynamic>? titles;
  final BillType type;
  final DateTime? updateDate;
  final DateTime? updateDateIncludingText;
  final BillSource? source;
  //From CSV
  final String? congressString;
  final Uri? url;

  const CongressGovBill({
    required this.type,
    required this.number,
    required this.title,
    required this.congress,
    this.source,
    this.actions,
    this.amendments,
    this.cboCostEstimates,
    this.committeeReports,
    this.committees,
    this.constitutionalAuthorityStatementText,
    this.cosponsors,
    this.introducedDate,
    this.latestAction,
    this.laws,
    this.originChamber,
    this.policyArea,
    this.relatedBills,
    this.sponsors,
    this.subjects,
    this.summaries,
    this.titles,
    this.updateDate,
    this.updateDateIncludingText,
    this.congressString,
    this.url,
  });

  factory CongressGovBill.fromCongressGovSearch(Map<String, dynamic> map) {
    //List of string replacement words
    String typeString = map['Legislation Number'].toString().split(' ')[0];
    int number = int.parse(map['Legislation Number'].toString().split(' ')[1]);
    String congressString = map['Congress'];

    //Separate out congress number
    String intString = congressString.split(' ')[0];
    intString = intString.substring(0, intString.length - 2);

    int congress = int.parse(intString);
    return CongressGovBill(
        type: typeString.billTypeFromCodeFormatted,
        number: number,
        title: map['Title'],
        congress: congress,
        source: BillSource.congressGovSearch,
        congressString: congressString,
        url: Uri.parse(map['URL']));
  }

  @override
  List<Object?> get props => [
        actions,
        amendments,
        cboCostEstimates,
        committeeReports,
        committees,
        congress,
        constitutionalAuthorityStatementText,
        cosponsors,
        introducedDate,
        latestAction,
        laws,
        number,
        originChamber,
        policyArea,
        relatedBills,
        sponsors,
        subjects,
        summaries,
        title,
        titles,
        type,
        updateDate,
        updateDateIncludingText,
        source,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'actions': actions,
      'amendments': amendments,
      'cboCostEstimates': cboCostEstimates,
      'committeeReports': committeeReports,
      'committees': committees,
      'congress': congress,
      'constitutionalAuthorityStatementText':
          constitutionalAuthorityStatementText,
      'cosponsors': cosponsors,
      'introducedDate': introducedDate?.toIso8601String(),
      'latestAction': latestAction,
      'laws': laws,
      'number': number,
      'originChamber': originChamber,
      'policyArea': policyArea,
      'relatedBills': relatedBills,
      'sponsors': sponsors,
      'subjects': subjects,
      'summaries': summaries,
      'title': title,
      'titles': titles,
      'type': type.typeCode.toString(),
      'updateDate': updateDate?.toIso8601String(),
      'updateDateIncludingText': updateDateIncludingText?.toIso8601String(),
      'source': source?.toString(),
      'congressString': congressString,
      'url': url?.toString(),
    };
  }

  factory CongressGovBill.fromMap(Map<String, dynamic> map) {
    return CongressGovBill(
      actions: map['actions'] != null
          ? Map<String, dynamic>.from((map['actions'] as Map<String, dynamic>))
          : null,
      amendments: map['amendments'] != null
          ? Map<String, dynamic>.from(
              (map['amendments'] as Map<String, dynamic>))
          : null,
      cboCostEstimates: map['cboCostEstimates'] != null
          ? List<Map<String, dynamic>>.from(map['cboCostEstimates'])
          : null,
      committeeReports: map['committeeReports'] != null
          ? List<Map<String, dynamic>>.from(map['committeeReports'])
          : null,
      committees: map['committees'] != null
          ? Map<String, dynamic>.from((map['committees']))
          : null,
      congress: map['congress'] as int,
      constitutionalAuthorityStatementText:
          map['constitutionalAuthorityStatementText'] != null
              ? map['constitutionalAuthorityStatementText'] as String
              : null,
      cosponsors: map['cosponsors'] != null
          ? Map<String, dynamic>.from((map['cosponsors']))
          : null,
      introducedDate: map['introducedDate'] != null
          ? DateTime.parse(map['introducedDate'] as String)
          : null,
      latestAction: map['latestAction'] != null
          ? Map<String, dynamic>.from((map['latestAction']))
          : null,
      laws: map['laws'] != null
          ? List<Map<String, String>>.from(
              map['laws'].map((e) => Map<String, String>.from(e)).toList())
          : null,
      number: int.parse(map['number'].toString()),
      originChamber:
          map['originChamber'] != null ? map['originChamber'] as String : null,
      policyArea: map['policyArea'] != null
          ? Map<String, String>.from((map['policyArea']))
          : null,
      relatedBills: map['relatedBills'] != null
          ? Map<String, dynamic>.from((map['relatedBills']))
          : null,
      sponsors: map['sponsors'] != null
          ? List<Map<String, dynamic>>.from(map['sponsors'])
          : null,
      subjects: map['subjects'] != null
          ? Map<String, dynamic>.from((map['subjects']))
          : null,
      summaries: map['summaries'] != null
          ? Map<String, dynamic>.from((map['summaries']))
          : null,
      title: map['title'] as String,
      titles: map['titles'] != null
          ? Map<String, dynamic>.from((map['titles']))
          : null,
      type: map['type'].toString().toLowerCase().billTypeFromCode,
      updateDate: map['updateDate'] != null
          ? DateTime.parse(map['updateDate'] as String)
          : null,
      updateDateIncludingText: map['updateDateIncludingText'] != null
          ? DateTime.parse(map['updateDateIncludingText'] as String)
          : null,
      source: map['source'] != null
          ? BillSource.values.firstWhere((element) =>
              element.toString() == map['source'].toString().toLowerCase())
          : null,
      congressString: map['congressString'] != null
          ? map['congressString'] as String
          : null,
      url: map['url'] != null ? Uri.parse(map['url'].toString()) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CongressGovBill.fromJson(String source) =>
      CongressGovBill.fromMap(json.decode(source) as Map<String, dynamic>);
}
