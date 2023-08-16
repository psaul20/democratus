import 'package:equatable/equatable.dart';

class Bill extends Equatable {
  final Map<String, dynamic> actions;
  final Map<String, dynamic> amendments;
  final List<Map<String, dynamic>> cboCostEstimates;
  final List<Map<String, String>> committeeReports;
  final Map<String, dynamic> committees;
  final int congress;
  final String constitutionalAuthorityStatement;
  final Map<String, dynamic> cosponsors;
  final DateTime introducedDate;
  final Map<String, dynamic> latestAction;
  final List laws;
  final String number;
  final String originChamber;
  final Map<String, String> policyArea;
  final Map<String, dynamic> relatedBills;
  final List<Map<String, dynamic>> sponsors;
  final Map<String, dynamic> subjects;
  final Map<String, dynamic> summaries;
  final String title;
  final Map<String, dynamic> titles;
  final String type;
  final DateTime updatedDate;
  final DateTime updatedDateIncludingText;

  const Bill({
    required this.actions,
    required this.amendments,
    required this.cboCostEstimates,
    required this.committeeReports,
    required this.committees,
    required this.congress,
    required this.constitutionalAuthorityStatement,
    required this.cosponsors,
    required this.introducedDate,
    required this.latestAction,
    required this.laws,
    required this.number,
    required this.originChamber,
    required this.policyArea,
    required this.relatedBills,
    required this.sponsors,
    required this.subjects,
    required this.summaries,
    required this.title,
    required this.titles,
    required this.type,
    required this.updatedDate,
    required this.updatedDateIncludingText,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      actions: json['actions'],
      amendments: json['amendments'],
      cboCostEstimates: json['cboCostEstimates'],
      committeeReports: json['committeeReports'],
      committees: json['committees'],
      congress: json['congress'],
      constitutionalAuthorityStatement: json['contitutionalAuthorityStatement'],
      cosponsors: json['cosponsors'],
      introducedDate: DateTime.parse(json['introducedDate']),
      latestAction: json['latestAction'],
      laws: json['laws'],
      number: json['number'],
      originChamber: json['originChamber'],
      policyArea: json['policyArea'],
      relatedBills: json['relatedBills'],
      sponsors: json['sponsors'],
      subjects: json['subjects'],
      summaries: json['summaries'],
      title: json['title'],
      titles: json['titles'],
      type: json['type'],
      updatedDate: DateTime.parse(json['updatedDate']),
      updatedDateIncludingText:
          DateTime.parse(json['updatedDateIncludingText']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actions': actions,
      'amendments': amendments,
      'cboCostEstimates': cboCostEstimates,
      'committeeReports': committeeReports,
      'committees': committees,
      'congress': congress,
      'contitutionalAuthorityStatement': constitutionalAuthorityStatement,
      'cosponsors': cosponsors,
      'introducedDate': introducedDate.toIso8601String(),
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
      'type': type,
      'updatedDate': updatedDate.toIso8601String(),
      'updatedDateIncludingText': updatedDateIncludingText.toIso8601String(),
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      actions: map['actions'],
      amendments: map['amendments'],
      cboCostEstimates: map['cboCostEstimates'],
      committeeReports: map['committeeReports'],
      committees: map['committees'],
      congress: map['congress'],
      constitutionalAuthorityStatement: map['contitutionalAuthorityStatement'],
      cosponsors: map['cosponsors'],
      introducedDate: DateTime.parse(map['introducedDate']),
      latestAction: map['latestAction'],
      laws: map['laws'],
      number: map['number'],
      originChamber: map['originChamber'],
      policyArea: map['policyArea'],
      relatedBills: map['relatedBills'],
      sponsors: map['sponsors'],
      subjects: map['subjects'],
      summaries: map['summaries'],
      title: map['title'],
      titles: map['titles'],
      type: map['type'],
      updatedDate: DateTime.parse(map['updatedDate']),
      updatedDateIncludingText: DateTime.parse(map['updatedDateIncludingText']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'actions': actions,
      'amendments': amendments,
      'cboCostEstimates': cboCostEstimates,
      'committeeReports': committeeReports,
      'committees': committees,
      'congress': congress,
      'contitutionalAuthorityStatement': constitutionalAuthorityStatement,
      'cosponsors': cosponsors,
      'introducedDate': introducedDate.toIso8601String(),
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
      'type': type,
      'updatedDate': updatedDate.toIso8601String(),
      'updatedDateIncludingText': updatedDateIncludingText.toIso8601String(),
    };
  }

  

  @override
  List<Object?> get props => [
        actions,
        amendments,
        cboCostEstimates,
        committeeReports,
        committees,
        congress,
        constitutionalAuthorityStatement,
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
        updatedDate,
        updatedDateIncludingText,
      ];
}
