enum SavedBillsStatus { initial, success, failure }

// extensions to get strings from enums
extension SavedBillsStatusFeedback on SavedBillsStatus {
  String get statusFeedback {
    switch (this) {
      case SavedBillsStatus.initial:
        return 'No Bills added. Add Bills by clicking the + button!';
      case SavedBillsStatus.success:
        return 'Saved Bills.';
      case SavedBillsStatus.failure:
        return 'Something went wrong...';
      default:
        return '';
    }
  }
}
