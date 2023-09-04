import 'dart:io';

import 'package:democratus/api/pro_publica_api.dart';
import 'package:democratus/globals/enums/bill_source.dart';
import 'package:democratus/globals/strings.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  Client client = Client();
  group('Testing Pro Publica Bill', () {
    setUpAll(() => dotenv.testLoad(fileInput: File('.env').readAsStringSync()));
    test('Testing Pro Publica Bill creation from JSON', () {
      String billString =
          File('${Strings.billFilePath}/bill_example.json').readAsStringSync();
      ProPublicaBill bill = ProPublicaBill.fromResponseBody(billString);
      expect(bill.billId, '116-hr-502');
      expect(bill.congress, 116);
    });

    test('Testing Pro Publica Bill creation from bill by subject result', () {
      String billString =
          File('${Strings.billFilePath}/bills_by_subject_example.json')
              .readAsStringSync();
      List<ProPublicaBill> bills =
          ProPublicaBill.fromResponseBodyList(billString);
      expect(bills.length, 20);
      expect(bills[0].billId, '115-s-1706');
    });

    test('Testing Pro Publica Bill creation from bill search result', () {
      String billString =
          File('${Strings.billFilePath}/bill_search_example.json')
              .readAsStringSync();
      List<ProPublicaBill> bills =
          ProPublicaBill.fromResponseBodyList(billString);
      expect(bills.length, 10);
      expect(bills[0].billId, '113-hr-2739');
    });

    test('Testing Pro Publica Bill Creation from API response', () async {
      // https://www.govtrack.us/congress/bills/118/hr5204
      ProPublicaApi proPublicaApi = ProPublicaApi(client: client);
      Bill bill = ProPublicaBill.fromExample();
      Response response =
          await proPublicaApi.getBillDetails(bill);
      Bill billDetails = Bill.fromResponseBody(response.body, BillSource.proPublica);
      expect(billDetails.billId, '118-hr-5204');
    });
  });
}
