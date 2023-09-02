part of 'saved_bills_bloc.dart';


class SavedBillsEvent {}

final class ReplaceBills extends SavedBillsEvent {
  final List<Bill> bills;
  ReplaceBills({
    required this.bills,
  });
}

final class ToggleSave extends SavedBillsEvent {
  final Bill bill;
  ToggleSave({
    required this.bill,
  });
}
