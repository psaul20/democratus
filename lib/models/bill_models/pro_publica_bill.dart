import 'dart:convert';
import 'dart:io';

import 'package:democratus/globals/enums/bill_source.dart';
import 'package:democratus/globals/enums/bill_type.dart';
import 'package:democratus/globals/strings.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/models/bill_models/bill_action.dart';
import 'package:democratus/models/bill_models/committee.dart';
import 'package:democratus/models/bill_models/sponsor.dart';

class ProPublicaBill extends Bill {
  ProPublicaBill.fromMap(Map<String, dynamic> map)
      : super(
          actions: map['actions'] != null
              ? List<BillAction>.from(
                  (map['actions'] as List)
                      .map(
                        (e) => BillAction(
                          actionCode: e['id'].toString(),
                          actionDate: DateTime.parse(e['datetime']),
                          description: e['description'],
                          type: e['action_type'],
                        ),
                      )
                      .toList(),
                )
              : [
                  BillAction(
                      actionCode: 1.toString(),
                      actionDate:
                          DateTime.parse(map['latest_major_action_date']),
                      description: map['latest_major_action'],
                      type: 'Unknown',)
                ],
          committees: [
            Committee(
              description: map['committees'],
              code: List<String>.from(map['committee_codes']).isNotEmpty
                  ? List<String>.from(map['committee_codes'])[0]
                  : null,
            )
          ],
          congress: int.tryParse(map['congress'] ?? '') ??
              int.parse(map['bill_id'].toString().split('-')[1]),
          introducedDate: DateTime.parse(map['introduced_date']),
          latestAction: map['latest_major_action'],
          number: int.tryParse(map['bill_slug']
                  .toString()
                  .replaceAll(RegExp(r'[^0-9]'), '')) ??
              int.parse(
                  map['number'].toString().replaceAll(RegExp(r'[^0-9]'), '')),
          sponsors: [
            BillSponsor(
                sponsorId: map['sponsor_id'],
                sponsorName: map['sponsor'] ?? map['sponsor_name'],
                sponsorParty: map['sponsor_party'],
                sponsorState: map['sponsor_state'],
                sponsorTitle: map['sponsor_title'],
                sponsorUri: Uri.parse(map['sponsor_uri']))
          ],
          subjects: [map['primary_subject']],
          crsSummaries: map['summary'] != null ? [map['summary']] : null,
          title: map['title'],
          shortTitle: map['short_title'],
          type: BillType.values.firstWhere(
              (e) => e.toString() == 'BillType.${map['bill_type']}'),
          lastUpdateDate: map['last_update_date'],
          source: BillSource.proPublica,
          congressGovUrl: Uri.tryParse(map['congressdotgov_url'] ?? ''),
          govtrackUrl: Uri.tryParse(map['govtrack_url'] ?? ''),
          gpoUrl: Uri.tryParse(map['gpo_pdf_uri'] ?? ''),
        );

  factory ProPublicaBill.fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    return ProPublicaBill.fromMap(map);
  }

  factory ProPublicaBill.fromResponseBody(String responseBody) {
    Map<String, dynamic> map = jsonDecode(responseBody);
    return ProPublicaBill.fromMap(map['results'][0]);
  }

  static List<ProPublicaBill> fromResponseBodyList(String responseBody) {
    Map<String, dynamic> map = jsonDecode(responseBody);
    //Changes depending on type of search
    List<Map<String, dynamic>> billResults =
        List<Map<String, dynamic>>.from(map['results']);
    billResults =
        billResults.where((element) => element.containsKey('bills')).isEmpty
            ? billResults
            : List.from(Map<String, dynamic>.from(
                billResults.firstWhere(
                  (element) => element.containsKey('bills'),
                ),
              )['bills']);
    List<ProPublicaBill> bills = [];
    for (final Map<String, dynamic> bill in billResults) {
      bills.add(ProPublicaBill.fromMap(bill));
    }
    return bills;
  }

  static ProPublicaBill fromExample() {
    String billpath = '${Strings.billFilePath}/pro_publica_bill_example.json';
    String billString = File(billpath).readAsStringSync();
    return ProPublicaBill.fromMap(jsonDecode(billString)['results'][0]);
  }

  static List<ProPublicaBill> fromExampleSubjectSearch() {
    String billpath =
        '${Strings.billFilePath}/pro_publica_bills_by_subject_example.json';
    String billString = File(billpath).readAsStringSync();
    return fromResponseBodyList(billString);
  }

  static List<ProPublicaBill> fromExampleKeywordSearch() {
    String billpath =
        '${Strings.billFilePath}/pro_publica_bill_search_example.json';
    String billString = File(billpath).readAsStringSync();
    return fromResponseBodyList(billString);
  }
}
