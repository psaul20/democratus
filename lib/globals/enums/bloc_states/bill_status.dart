enum BillStatus { success, loading, failure }

extension BillStatusX on BillStatus {
  String get statusFeedback {
    switch (this) {
      case BillStatus.success:
        return "Success";
      case BillStatus.loading:
        return "Loading";
      case BillStatus.failure:
        return "Something went wrong. Please try again later.";
    }
  }
}
