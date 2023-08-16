import 'package:csv/csv.dart';

class CongressGovApi {
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

  static List<Map<String, dynamic>> parseCsv(String csv) {
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


}
