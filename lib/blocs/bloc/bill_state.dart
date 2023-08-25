part of 'bill_bloc.dart';

class BillState extends Equatable {
  const BillState({
    this.status = BillStatus.success,
    required this.bill,
    this.except,
  });
  final BillStatus status;
  final Bill bill;
  final Exception? except;

  BillState copyWith({
    BillStatus? status,
    Bill? bill,
    Exception? except,
  }) {
    return BillState(
        status: status ?? this.status,
        bill: bill ?? this.bill,
        except: except ?? this.except);
  }

  @override
  List<Object?> get props =>
      [status, bill, bill.hasDetails, bill.isSaved, except];
}
