// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bill_search_bloc.dart';

enum BillSearchStatus { initial, searching, success, failure }

class BillSearchState extends Equatable {
  final BillSearchStatus status;
  final List<Bill> searchBills;
  final String keyword;

  const BillSearchState({
    this.status = BillSearchStatus.initial,
    this.searchBills = const <Bill>[],
    this.keyword = '',
  });

  @override
  List<Object?> get props => [
        status,
        searchBills,
        keyword,
      ];

  BillSearchState copyWith({
    BillSearchStatus? status,
    List<Bill>? searchBills,
    String? keyword,
  }) {
    return BillSearchState(
      status: status ?? this.status,
      searchBills: searchBills ?? this.searchBills,
      keyword: keyword ?? this.keyword,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['keyword'] = keyword;
    map['status'] = status.toString();
    return map;
  }

  factory BillSearchState.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return const BillSearchState();
    } else {
      return BillSearchState(
        keyword: map['keyword'],
        status: BillSearchStatus.values.firstWhere(
            (e) => e.toString() == 'BillSearchStatus.${map['status']}'),
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory BillSearchState.fromJson(String source) =>
      BillSearchState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  String toString() {
    StringBuffer string = StringBuffer();
    string.write('$status, ');
    string.write("Keyword: $keyword, ");
    string.write("SearchBills Length: ${searchBills.length}, ");
    return string.toString();
  }
}
