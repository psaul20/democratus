import 'package:democratus/globals/enums/bill_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing BillTypeExtension Methods', () {
    test('Testing Formatted to Enum', () {
      expect('H.R.'.billTypeFromCodeFormatted, BillType.hr);
      expect('H.Res.'.billTypeFromCodeFormatted, BillType.hres);
      expect('H.J.Res.'.billTypeFromCodeFormatted, BillType.hjres);
      expect('H.Con.Res.'.billTypeFromCodeFormatted, BillType.hconres);
      expect('S.'.billTypeFromCodeFormatted, BillType.s);
      expect('S.Res.'.billTypeFromCodeFormatted, BillType.sres);
      expect('S.J.Res.'.billTypeFromCodeFormatted, BillType.sjres);
      expect('S.Con.Res.'.billTypeFromCodeFormatted, BillType.sconres);
    });
    test('Testing typecode to enum', () {
      expect('hr'.billTypeFromCode, BillType.hr);
      expect('hres'.billTypeFromCode, BillType.hres);
      expect('hjres'.billTypeFromCode, BillType.hjres);
      expect('hconres'.billTypeFromCode, BillType.hconres);
      expect('s'.billTypeFromCode, BillType.s);
      expect('sres'.billTypeFromCode, BillType.sres);
      expect('sjres'.billTypeFromCode, BillType.sjres);
      expect('sconres'.billTypeFromCode, BillType.sconres);
    });
  });
}
