enum BillSearchStatus { initial, searching, success, failure }

extension BillSearchStatusExtension on BillSearchStatus {
  String get statusDescription {
    switch (this) {
      case BillSearchStatus.initial:
        return 'initial';
      case BillSearchStatus.searching:
        return 'searching';
      case BillSearchStatus.success:
        return 'success';
      case BillSearchStatus.failure:
        return 'failure';
    }
  }

  String get statusFeedback {
    switch (this) {
      case BillSearchStatus.initial:
        return 'Enter keywords above to search Bills';
      case BillSearchStatus.searching:
        return 'Searching Bills';
      case BillSearchStatus.success:
        return 'Search Successful';
      case BillSearchStatus.failure:
        return 'Search Failed';
    }
  }
}
