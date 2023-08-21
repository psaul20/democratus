enum BillType {
  hr,
  hres,
  hjres,
  hconres,
  s,
  sres,
  sjres,
  sconres,
}

extension BillTypeExtension on BillType {
  String get typeCode {
    switch (this) {
      case BillType.hr:
        return 'hr';
      case BillType.hres:
        return 'hres';
      case BillType.hjres:
        return 'hjres';
      case BillType.hconres:
        return 'hconres';
      case BillType.s:
        return 's';
      case BillType.sres:
        return 'sres';
      case BillType.sjres:
        return 'sjres';
      case BillType.sconres:
        return 'sconres';
    }
  }

  String get typeCodeFormatted {
    switch (this) {
      case BillType.hr:
        return 'H.R.';
      case BillType.hres:
        return 'H.Res.';
      case BillType.hjres:
        return 'H.J.Res.';
      case BillType.hconres:
        return 'H.Con.Res.';
      case BillType.s:
        return 'S.';
      case BillType.sres:
        return 'S.Res.';
      case BillType.sjres:
        return 'S.J.Res.';
      case BillType.sconres:
        return 'S.Con.Res.';
    }
  }

  String get typeDescription {
    switch (this) {
      case BillType.hr:
        return 'House Bill';
      case BillType.hres:
        return 'House Resolution';
      case BillType.hjres:
        return 'House Joint Resolution';
      case BillType.hconres:
        return 'House Concurrent Resolution';
      case BillType.s:
        return 'Senate Bill';
      case BillType.sres:
        return 'Senate Resolution';
      case BillType.sjres:
        return 'Senate Joint Resolution';
      case BillType.sconres:
        return 'Senate Concurrent Resolution';
    }
  }
}

extension BillTypeStringExtension on String {
  BillType get billTypeFromCode {
    switch (this) {
      case 'hr':
        return BillType.hr;
      case 'hres':
        return BillType.hres;
      case 'hjres':
        return BillType.hjres;
      case 'hconres':
        return BillType.hconres;
      case 's':
        return BillType.s;
      case 'sres':
        return BillType.sres;
      case 'sjres':
        return BillType.sjres;
      case 'sconres':
        return BillType.sconres;
      default:
        throw Exception('Invalid bill type');
    }
  }

  BillType get billTypeFromCodeFormatted {
    switch (this) {
      case 'H.R.':
        return BillType.hr;
      case 'H.Res.':
        return BillType.hres;
      case 'H.J.Res.':
        return BillType.hjres;
      case 'H.Con.Res.':
        return BillType.hconres;
      case 'S.':
        return BillType.s;
      case 'S.Res.':
        return BillType.sres;
      case 'S.J.Res.':
        return BillType.sjres;
      case 'S.Con.Res.':
        return BillType.sconres;
      default:
        throw Exception('Invalid bill type');
    }
  }
}
