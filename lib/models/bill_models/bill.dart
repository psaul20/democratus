// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:democratus/globals/converters/date_converters.dart';
import 'package:democratus/globals/converters/string_converters.dart';
import 'package:democratus/globals/enums/bill_source.dart';
import 'package:democratus/globals/enums/bill_type.dart';
import 'package:democratus/models/bill_models/bill_action.dart';
import 'package:democratus/models/bill_models/committee.dart';
import 'package:democratus/models/bill_models/govinfo_bill.dart';
import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:democratus/models/bill_models/sponsor.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';

//TODO: Implement govinfo bill

class Bill extends Equatable {
  final List<BillAction>? actions;
  final List<Map<String, dynamic>>? amendments;
  final List<Committee>? committees;
  final int congress;
  final List<BillSponsor>? cosponsors;
  final DateTime? introducedDate;
  final String? latestAction;
  final int number;
  final String? originChamber;
  final String? policyArea;
  final List<BillSponsor>? sponsors;
  final List<String>? subjects;
  final List<String>? crsSummaries;
  final String title;
  final String? shortTitle;
  final BillType type;
  final DateTime? lastUpdateDate;
  final BillSource source;
  final Uri? congressGovUrl;
  final Uri? govtrackUrl;
  final Uri? gpoUrl;
  final bool hasDetails;
  final bool isSaved;
  final String? govInfoId;
  final int? pages;
  final String? currentChamber;
  final String? version;
  final Uri? billStatusLink;

  String get billId =>
      '${congress.toString()}-${type.typeCode}-${number.toString()}${version ?? ''}-${lastUpdateDate?.toIso8601String() ?? ''}';

  String? get displaySummary => crsSummaries != null
      ? StringConverters.removeHtmlTags(crsSummaries!.first).trim()
      : null;

  String get displayTitle => shortTitle ?? title;
  String get displayNumber => '${type.typeCodeFormatted.toUpperCase()} $number';
  String? get displayOriginChamber =>
      StringConverters.toTitleCase(originChamber);

  List get datesForDisplay {
    List<Map> dates = [];
    if (introducedDate != null) {
      dates.add({
        'title': 'Introduced: ',
        'date': DateConverters.formatDate(introducedDate!),
      });
    }
    if (lastUpdateDate != null) {
      dates.add({
        'title': 'Last Updated: ',
        'date': DateConverters.formatDate(introducedDate!),
      });
    }
    return dates;
  }

  Future<Uri?> get url async {
    if (gpoUrl != null && await canLaunchUrl(gpoUrl!)) {
      return gpoUrl!;
    }
    if (congressGovUrl != null && await canLaunchUrl(congressGovUrl!)) {
      return congressGovUrl!;
    }
    if (govtrackUrl != null && await canLaunchUrl(govtrackUrl!)) {
      return govtrackUrl!;
    }
    return null;
  }

  const Bill({
    this.actions,
    this.amendments,
    this.committees,
    required this.congress,
    this.cosponsors,
    this.introducedDate,
    this.latestAction,
    required this.number,
    this.originChamber,
    this.policyArea,
    this.sponsors,
    this.subjects,
    this.crsSummaries,
    required this.title,
    required this.type,
    this.lastUpdateDate,
    required this.source,
    this.shortTitle,
    this.congressGovUrl,
    this.govtrackUrl,
    this.gpoUrl,
    this.hasDetails = false,
    this.isSaved = false,
    this.govInfoId,
    this.pages,
    this.currentChamber,
    this.version,
    this.billStatusLink,
  });

  @override
  List<Object?> get props => [
        billId,
        congress,
        number,
        lastUpdateDate,
        hasDetails,
      ];

  Bill copyWith({
    List<BillAction>? actions,
    List<Map<String, dynamic>>? amendments,
    List<Committee>? committees,
    int? congress,
    List<BillSponsor>? cosponsors,
    DateTime? introducedDate,
    String? latestAction,
    int? number,
    String? originChamber,
    String? policyArea,
    List<BillSponsor>? sponsors,
    List<String>? subjects,
    List<String>? crsSummaries,
    String? title,
    String? shortTitle,
    BillType? type,
    DateTime? lastUpdateDate,
    BillSource? source,
    Uri? congressGovUrl,
    Uri? govtrackUrl,
    Uri? gpoUrl,
    bool? hasDetails,
    bool? isSaved,
    String? govInfoId,
    int? pages,
    String? currentChamber,
    String? version,
    Uri? billStatusLink,
  }) {
    return Bill(
      actions: actions ?? this.actions,
      amendments: amendments ?? this.amendments,
      committees: committees ?? this.committees,
      congress: congress ?? this.congress,
      cosponsors: cosponsors ?? this.cosponsors,
      introducedDate: introducedDate ?? this.introducedDate,
      latestAction: latestAction ?? this.latestAction,
      number: number ?? this.number,
      originChamber: originChamber ?? this.originChamber,
      policyArea: policyArea ?? this.policyArea,
      sponsors: sponsors ?? this.sponsors,
      subjects: subjects ?? this.subjects,
      crsSummaries: crsSummaries ?? this.crsSummaries,
      title: title ?? this.title,
      shortTitle: shortTitle ?? this.shortTitle,
      type: type ?? this.type,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
      source: source ?? this.source,
      congressGovUrl: congressGovUrl ?? this.congressGovUrl,
      govtrackUrl: govtrackUrl ?? this.govtrackUrl,
      gpoUrl: gpoUrl ?? this.gpoUrl,
      hasDetails: hasDetails ?? this.hasDetails,
      isSaved: isSaved ?? this.isSaved,
      govInfoId: govInfoId ?? this.govInfoId,
      pages: pages ?? this.pages,
      currentChamber: currentChamber ?? this.currentChamber,
      version: version ?? this.version,
      billStatusLink: billStatusLink ?? this.billStatusLink,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'actions': actions,
      'amendments': amendments,
      'committees': committees,
      'congress': congress,
      'cosponsors': cosponsors,
      'introducedDate': introducedDate?.toIso8601String(),
      'latestAction': latestAction,
      'number': number,
      'originChamber': originChamber,
      'policyArea': policyArea,
      'sponsors': sponsors,
      'subjects': subjects,
      'summaries': crsSummaries,
      'title': title,
      'type': type.typeCode.toString(),
      'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      'source': source.toString(),
      'shortTitle': shortTitle,
      'congressGovUrl': congressGovUrl?.toString(),
      'govtrackUrl': govtrackUrl?.toString(),
      'gpoUrl': gpoUrl?.toString(),
      'hasDetails': hasDetails,
      'isSaved': isSaved,
      'govInfoId': govInfoId,
      'pages': pages.toString(),
      'currentChamber': currentChamber,
      'version': version,
      'billStatusLink': billStatusLink?.toString(),
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      actions:
          map['actions'] != null ? List<BillAction>.from(map['actions']) : null,
      amendments: map['amendments'] != null
          ? List<Map<String, dynamic>>.from(map['amendments'])
          : null,
      committees: map['committees'] != null
          ? List<Committee>.from(map['committees'])
          : null,
      congress: map['congress'] as int,
      cosponsors: map['cosponsors'] != null
          ? List<BillSponsor>.from(map['cosponsors'])
          : null,
      introducedDate: map['introducedDate'] != null
          ? DateTime.parse(map['introducedDate'])
          : null,
      latestAction: map['latestAction'] as String,
      number: map['number'] as int,
      originChamber:
          map['originChamber'] != null ? map['originChamber'] as String : null,
      policyArea:
          map['policyArea'] != null ? map['policyArea'] as String : null,
      sponsors: map['sponsors'] != null
          ? List<BillSponsor>.from(map['sponsors'])
          : null,
      subjects:
          map['subjects'] != null ? List<String>.from(map['subjects']) : null,
      crsSummaries: map['crsSummaries'] != null
          ? List<String>.from(map['summaries'])
          : null,
      title: map['title'] as String,
      type: map['type'].toString().toLowerCase().billTypeFromCode,
      lastUpdateDate: map['lastUpdateDate'] != null
          ? DateTime.parse(map['lastUpdateDate'])
          : null,
      source: BillSource.values.firstWhere((element) =>
          element.toString() == map['source'].toString().toLowerCase()),
      shortTitle:
          map['shortTitle'] != null ? map['shortTitle'] as String : null,
      congressGovUrl: map['congressGovUrl'] != null
          ? Uri.parse(map['congressGovUrl'])
          : null,
      govtrackUrl:
          map['govtrackUrl'] != null ? Uri.parse(map['govtrackUrl']) : null,
      gpoUrl: map['gpoUrl'] != null ? Uri.parse(map['gpoUrl']) : null,
      hasDetails: map['hasDetails'] as bool,
      isSaved: map['isSaved'] as bool,
      govInfoId: map['govInfoId'] as String?,
      pages: map['pages'] != null ? int.parse(map['pages']) : null,
      currentChamber: map['currentChamber'] != null
          ? map['currentChamber'] as String
          : null,
      version: map['version'] != null ? map['version'] as String : null,
      billStatusLink: map['billStatusLink'] != null
          ? Uri.parse(map['billStatusLink'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bill.fromJson(String source) =>
      Bill.fromMap(json.decode(source) as Map<String, dynamic>);

  //TODO: Bad practice, probably needs repository to make this cleaner
  static Bill fromResponseBody(String responseBody, BillSource source) {
    switch (source) {
      case BillSource.proPublica:
        return ProPublicaBill.fromResponseBody(responseBody);
      case BillSource.govinfo:
        return GovinfoBill.fromResponseBody(responseBody);

      default:
        throw Exception('Bill source not implemented');
    }
  }

  static List<Bill> fromResponseBodyList(
      String responseBody, BillSource source) {
    switch (source) {
      case BillSource.proPublica:
        return ProPublicaBill.fromResponseBodyList(responseBody);
      case BillSource.govinfo:
        return GovinfoBill.fromResponseBodyList(responseBody);

      default:
        throw Exception('Bill source not implemented');
    }
  }

  @override
  bool get stringify => true;
}
