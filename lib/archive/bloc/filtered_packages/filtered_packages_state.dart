// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'filtered_packages_bloc.dart';

@immutable
class FilteredPackagesState extends Equatable {
  FilteredPackagesState({
    this.docClassFilter = const <String>[],
    this.textFilter = '',
    startDateFilter,
    endDateFilter,
    //TODO: Needs to be updated if other collections are supported
    this.collectionFilter = const ['BILLS'],
    this.filteredList = const <Package>[],
    this.initList = const <Package>[],
  })  : startDateFilter = startDateFilter ?? DateTime(1776, 7, 4),
        endDateFilter = endDateFilter ?? DateTime.now();

  final List<String> docClassFilter;
  final String textFilter;
  final DateTime startDateFilter;
  final DateTime endDateFilter;
  final List<String> collectionFilter;

  final List<Package> filteredList;
  final List<Package> initList;

  FilteredPackagesState copyWith({
    List<String>? docClassFilter,
    String? textFilter,
    DateTime? startDateFilter,
    DateTime? endDateFilter,
    List<Package>? filteredList,
    List<Package>? initList,
  }) {
    return FilteredPackagesState(
      docClassFilter: docClassFilter ?? this.docClassFilter,
      textFilter: textFilter ?? this.textFilter,
      startDateFilter: startDateFilter ?? this.startDateFilter,
      endDateFilter: endDateFilter ?? this.endDateFilter,
      filteredList: filteredList ?? this.filteredList,
      initList: initList ?? this.initList,
    );
  }

  @override
  List<Object?> get props => [
        docClassFilter,
        textFilter,
        startDateFilter,
        endDateFilter,
        filteredList,
        initList
      ];

  factory FilteredPackagesState.fromMap(Map<String, dynamic> map) {
    return FilteredPackagesState(
      docClassFilter:
          List<String>.from((map['docClassFilter'] as List<String>)),
      textFilter: map['textFilter'] as String,
      startDateFilter:
          DateTime.fromMillisecondsSinceEpoch(map['startDateFilter'] as int),
      endDateFilter:
          DateTime.fromMillisecondsSinceEpoch(map['endDateFilter'] as int),
      // filteredList: List<Package>.from(
      //   (map['filteredList'] as List<int>).map<Package>(
      //     (x) => Package.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
      // initList: List<Package>.from(
      //   (map['initList'] as List<int>).map<Package>(
      //     (x) => Package.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FilteredPackagesState.fromJson(String source) =>
      FilteredPackagesState.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  String toString() {
    StringBuffer string = StringBuffer();
    string.write('${docClassFilter.toString()}, ');
    string.write('${textFilter.toString()}, ');
    string.write('${startDateFilter.toString()}, ');
    string.write('${endDateFilter.toString()}, ');
    string.write(', InitList Length: ${initList.length}');
    string.write(', FilteredList Length: ${filteredList.length}');
    return string.toString();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docClassFilter': docClassFilter,
      'textFilter': textFilter,
      'startDateFilter': startDateFilter.millisecondsSinceEpoch,
      'endDateFilter': endDateFilter.millisecondsSinceEpoch,
      // 'filteredList': filteredList.map((x) => x.toMap()).toList(),
      // 'initList': initList.map((x) => x.toMap()).toList(),
    };
  }
}

class FilteredPackagesInitial extends FilteredPackagesState {}

class FilteredPackagesFailure extends FilteredPackagesState {
  FilteredPackagesFailure({required this.except});

  final Exception except;

  @override
  List<Object?> get props => [...super.props, except];
}
