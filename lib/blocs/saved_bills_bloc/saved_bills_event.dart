part of 'saved_bills_bloc.dart';

@immutable
sealed class SavedBillsEvent {}

final class ReplaceBills extends SavedBillsEvent {
  final List<Bill> bills;
  ReplaceBills({
    required this.bills,
  });
}

final class SaveBill extends SavedBillsEvent {
  final Bill bill;
  SaveBill({
    required this.bill,
  });
}

final class RemoveBill extends SavedBillsEvent {
  final Bill bill;
  RemoveBill({
    required this.bill,
  });
}
