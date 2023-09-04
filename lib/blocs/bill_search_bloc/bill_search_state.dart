// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bill_search_bloc.dart';

class BillSearchState extends Equatable {
  final BillSearchStatus status;
  final List<Bill> searchBills;
  final String keyword;
  final bool hasReachedMax;

  const BillSearchState({
    this.status = BillSearchStatus.initial,
    this.searchBills = const <Bill>[],
    this.keyword = '',
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [
        status,
        searchBills,
        keyword,
        hasReachedMax,
      ];

  BillSearchState copyWith({
    BillSearchStatus? status,
    List<Bill>? searchBills,
    String? keyword,
    int? offset,
    bool? hasReachedMax,
  }) {
    return BillSearchState(
      status: status ?? this.status,
      searchBills: searchBills ?? this.searchBills,
      keyword: keyword ?? this.keyword,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['keyword'] = keyword;
    map['status'] = status.toString();
    map['hasReachedMax'] = hasReachedMax.toString();
    return map;
  }

  factory BillSearchState.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return const BillSearchState();
    } else {
      return BillSearchState(
        keyword: map['keyword'],
        status: BillSearchStatus.values
            .firstWhere((element) => element.toString() == map['status']),
        hasReachedMax: map['hasReachedMax'] == 'true',
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
    string.write('hasReachedMax: $hasReachedMax');
    return string.toString();
  }
}
