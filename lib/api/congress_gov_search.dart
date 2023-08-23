// ignore_for_file: unused_import

import 'dart:io';
import 'dart:developer';
import 'package:csv/csv.dart';
import 'package:democratus/models/bill_models/congress_gov_bill.dart';

class CongressGovSearch {
  static Uri getSearchUri({
    // REMEMBER THAT THESE FIELDS AND THEIR VALUES MUST BE IN THE SAME ORDER AS THEY APPEAR WHEN USING THE CONGRESS.GOV ADVANCED SEARCH
    List<int> congresses = const <int>[118, 117, 116],
    String legislationNumbers = '',
    String restrictionType = 'includeBillText',
    List<String> restrictionFields = const <String>[
      'allBillTitles',
      'summary',
    ],
    String summaryField = 'billSummary',
    String enterTerms = '',
    bool wordVariants = true,
    List<String> legislationTypes = const <String>[
      'hr',
      'hjres',
      'hamdt',
      's',
      'sjres',
      'samdt',
    ],
    bool public = true,
    bool private = true,
    String chamber = 'all',
    String actionTerms = '',
    bool legislativeActionWordVariants = true,
    String dateOfActionOperator = 'equal',
    String dateOfActionStartDate = '',
    String dateOfActionEndDate = '',
    String dateOfActionIsOptions = 'yesterday',
    String dateOfActionToggle = 'multi',
    String legislativeAction = 'Any',
    String sponsorState = 'One',
    String member = '',
    List<String> sponsorTypes = const <String>['sponsor'],
    String sponsorTypeBool = 'OR',
    String dateOfSponsorshipOperator = 'equal',
    String dateOfSponsorshipStartDate = '',
    String dateOfSponsorshipEndDate = '',
    String dateOfSponsorshipIsOptions = 'yesterday',
    List<String> committeeActivity = const <String>[
      '0',
      '3',
      '11',
      '12',
      '4',
      '2',
      '5',
      '9'
    ],
    String search = '',
    String submitted = 'Submitted',
    List<String> status = const <String>[
      // "introduced"
      "committee",
      "floor",
      "failed-one",
      "passed-one",
      "passed-both",
      "president",
      "law",
      "resolving",
      "veto"
    ],
    List<String> subjects = const <String>[],
    List<String> policyAreas = const <String>[],
    bool getCsv = false,
  }) {
    Map<String, dynamic> queryParameters = {
      'congresses[]': congresses.map((e) => e.toString()).toList(),
      'legislationNumbers': legislationNumbers,
      'restrictionType': restrictionType,
      'restrictionFields[]': restrictionFields,
      'summaryField': summaryField,
      'enterTerms': enterTerms,
      'wordVariants': wordVariants.toString(),
      'legislationTypes[]': legislationTypes,
      'public': public.toString(),
      'private': private.toString(),
      'chamber': chamber,
      'actionTerms': actionTerms,
      'legislativeActionWordVariants': legislativeActionWordVariants.toString(),
      'dateOfActionOperator': dateOfActionOperator,
      'dateOfActionStartDate': dateOfActionStartDate,
      'dateOfActionEndDate': dateOfActionEndDate,
      'dateOfActionIsOptions': dateOfActionIsOptions,
      'dateOfActionToggle': dateOfActionToggle,
      'legislativeAction': legislativeAction,
      'sponsorState': sponsorState,
      'member': member,
      'sponsorTypes[]': sponsorTypes,
      'sponsorTypeBool': sponsorTypeBool,
      'dateOfSponsorshipOperator': dateOfSponsorshipOperator,
      'dateOfSponsorshipStartDate': dateOfSponsorshipStartDate,
      'dateOfSponsorshipEndDate': dateOfSponsorshipEndDate,
      'dateOfSponsorshipIsOptions': dateOfSponsorshipIsOptions,
      'committeeActivity[]': committeeActivity,
      'satellite': subjects.isNotEmpty
          ? {
              '"Legislative Subject Terms"': {
                '"operator"': '"OR"',
                '"subjects"': subjects.map((e) => '"$e"').toList(),
              }.toString()
            }.toString()
          : '[]',
      'search': search,
      'submitted': submitted,
      'q': {
        '"source"': '"legislation"',
        '"bill-status"': status.map((e) => '"$e"').toList(),
        '"subject"': policyAreas.map((e) => '"$e"').toList(),
      }.toString(),
    };
    String baseUrl = 'https://www.congress.gov/advanced-search/legislation?';
    if (getCsv) {
      queryParameters['1ddcb92ade31c8fbd370001f9b29a7d9'] =
          '628cb5675ff524f3e719b7aa2e88fe3f';
      queryParameters['fieldsToInclude'] =
          'latestTitle,amendsBill,sponsor,dateOffered,dateOfIntroduction,numberOfCosponsors,dateSubmitted,dateProposed,committees,latestAction,latestActionDate,cosponsors,subjects,relatedBillsCount,relatedBill,latestSummary';
    }

    return Uri.parse(baseUrl).replace(queryParameters: queryParameters);
  }

  static //headers map
      Map<String, String> headers = {
    'authority': 'www.congress.gov',
    'accept':
        'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8',
    'accept-encoding': 'gzip, deflate, br',
    'accept-language': 'en-US,en;q=0.6',
    'cache-control': 'max-age=0',
    'sec-ch-ua': '"Not/A)Brand";v="99", "Brave";v="115", "Chromium";v="115"',
    'sec-ch-ua-mobile': '?0',
    'sec-ch-ua-platform': '"macOS"',
    'sec-fetch-dest': 'document',
    'sec-fetch-mode': 'navigate',
    'sec-fetch-site': 'none',
    'sec-fetch-user': '?1',
    'sec-gpc': '1',
    'upgrade-insecure-requests': '1',
    'user-agent':
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_2_3) AppleWebKit/537.36 (KHTML, like Gecko) Brave Chrome/89.0.4389.114 Safari/537.36',
  };

  static List<Map<String, dynamic>> parseCsvToMaps(String csv) {
    List<List<dynamic>> csvData =
        const CsvToListConverter(eol: '\n').convert(csv);
    //Remove the first 3 lines of the csvData
    csvData.removeRange(0, 3);
    // Get the headers
    List<String> headers = csvData[0].map((e) => e.toString()).toList();
    //Remove headers row
    csvData.removeAt(0);
    // check for duplicated headers
    List<String> duplicatedHeaders = [];
    for (String header in headers) {
      if (headers.where((element) => element == header).length > 1) {
        duplicatedHeaders.add(header);
      }
    }
    // create a list of the headers without duplicates
    List<String> deDuplicatedHeaders = [];
    for (String header in headers) {
      if (!deDuplicatedHeaders.contains(header)) {
        deDuplicatedHeaders.add(header);
      }
    }
    //write deduplicated headers to a txt file for reference
    File('lib/api/ref/headers.txt')
        .writeAsStringSync(deDuplicatedHeaders.toString());
    log('Deduplicated Headers: ${deDuplicatedHeaders.toString()}');
    // convert the csvData to a list of maps, converting the duplicated headers to a list of values under one key of the same name
    List<Map<String, dynamic>> csvDataAsMaps = [];
    for (List<dynamic> row in csvData) {
      Map<String, dynamic> rowAsMap = {};
      for (int i = 0; i < row.length; i++) {
        if (duplicatedHeaders.contains(headers[i])) {
          rowAsMap[headers[i]] = row[i].toString().split(', ');
        } else {
          rowAsMap[headers[i]] = row[i];
        }
      }
      csvDataAsMaps.add(rowAsMap);
    }
    return csvDataAsMaps;
  }

  //Convert the list of maps to a list of Bill objects
  // static List<CongressGovBill> convertCsvDataToBills(String csv) {
  //   List<Map<String, dynamic>> csvDataAsMaps = parseCsvToMaps(csv);
  //   List<CongressGovBill> bills = [];
  //   return bills;
  // }
}
