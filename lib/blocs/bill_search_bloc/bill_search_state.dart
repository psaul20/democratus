part of 'bill_search_bloc.dart';

enum BillSearchStatus { initial, searching, success, failure }

class BillSearchState extends Equatable {
  final DateTime startDate;
  final DateTime endDate;
  final List<Collection> collections;
  final Collection? selectedCollection;
  final BillSearchStatus status;
  final List<Bill> searchBills;
  final List<String> docClasses;

  BillSearchState({
    startDate,
    endDate,
    this.collections = const <Collection>[],
    this.selectedCollection,
    this.status = BillSearchStatus.initial,
    this.searchBills = const <Bill>[],
    this.docClasses = const <String>[],
  })  : startDate = startDate ?? DateTime(1776, 7, 4),
        endDate = endDate ?? DateTime.now();

  @override
  List<Object?> get props => [
        collections,
        selectedCollection,
        startDate,
        endDate,
        status,
        searchBills,
        docClasses
      ];

  // List<Object?> get reqFields => [
  //       collections,
  //       selectedCollection,
  //     ];

  BillSearchState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    List<Collection>? collections,
    Collection? selectedCollection,
    BillSearchStatus? status,
    List<Bill>? searchBills,
    List<String>? docClasses,
  }) {
    return BillSearchState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      collections: collections ?? this.collections,
      selectedCollection: selectedCollection ?? this.selectedCollection,
      status: status ?? this.status,
      searchBills: searchBills ?? this.searchBills,
      docClasses: docClasses ?? this.docClasses,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['startDate'] = startDate.millisecondsSinceEpoch;
    map['endDate'] = endDate.millisecondsSinceEpoch;
    map['collections'] = collections.map((x) => x.toMap()).toList();
    map['selectedCollection'] = selectedCollection?.toMap();
    map['docClasses'] = docClasses;
    return map;
  }

  factory BillSearchState.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return BillSearchState();
    } else {
      return BillSearchState(
        startDate: map['startDate'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['startDate'])
            : null,
        endDate: map['endDate'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['endDate'])
            : null,
        collections: List<Collection>.from(
          (map['collections'] as List<dynamic>).map<Collection>(
            (x) => Collection.fromMap(x as Map<String, dynamic>),
          ),
        ),
        selectedCollection: map['selectedCollection'] != null
            ? Collection.fromMap(
                map['selectedCollection'] as Map<String, dynamic>)
            : null,
        status: BillSearchStatus.initial,
        docClasses: map['docClasses'] as List<String>,
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
    string.write('Collections Length: ${collections.length}, ');
    string.write('$selectedCollection, ');
    string.write('$startDate, ');
    string.write('$endDate, ');
    string.write('$status, ');
    string.write('$collections, ');
    string.write("SearchBills Length: ${searchBills.length}, ");
    string.write('$docClasses');
    return string.toString();
  }
}

const int numSearchBills = 1000;

