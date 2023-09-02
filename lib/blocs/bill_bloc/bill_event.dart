part of 'bill_bloc.dart';

class BillEvent {}

final class UpdateBill extends BillEvent {
  final Bill bill;
  UpdateBill(this.bill);
}

final class ToggleSave extends BillEvent {}

final class GetBillDetails extends BillEvent {}
