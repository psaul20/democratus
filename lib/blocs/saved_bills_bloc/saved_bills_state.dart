part of 'saved_bills_bloc.dart';


class SavedBillsState extends Equatable {
  const SavedBillsState({
    this.status = SavedBillsStatus.initial,
    this.bills = const <Bill>[],
  });

  final SavedBillsStatus status;
  final List<Bill> bills;

  SavedBillsState copyWith({
    SavedBillsStatus? status,
    List<Bill>? bills,
  }) {
    return SavedBillsState(
      status: status ?? this.status,
      bills: bills ?? this.bills,
    );
  }

  @override
  List<Object?> get props => [status, bills];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'searchBills': bills.map((x) => x.toMap()).toList(),
    };
  }

  factory SavedBillsState.fromMap(Map<String, dynamic> map) {
    List<Bill> bills = List<Bill>.from(
        (map['searchBills'] as List<dynamic>).map<Bill>(
      (x) => Bill.fromMap(x as Map<String, dynamic>),
    ));

    if (bills.isNotEmpty) {
      return SavedBillsState(
        status: SavedBillsStatus.success,
        bills: bills,
      );
    } else {
      return const SavedBillsState();
    }
  }

  String toJson() => json.encode(toMap());

  factory SavedBillsState.fromJson(String source) =>
      SavedBillsState.fromMap(json.decode(source) as Map<String, dynamic>);
}

