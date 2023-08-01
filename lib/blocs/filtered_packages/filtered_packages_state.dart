// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'filtered_packages_bloc.dart';

@immutable
class FilteredPackagesState extends Equatable {
  const FilteredPackagesState({
    this.appliedCriteria = const <FilterType, dynamic>{
      FilterType.packageType: <String>[],
      FilterType.text: '',
    },
    this.filteredList = const <Package>[],
    this.initList = const <Package>[],
  });

  final Map<FilterType, dynamic> appliedCriteria;
  final List<Package> filteredList;
  final List<Package> initList;

  FilteredPackagesState copyWith({
    Map<FilterType, dynamic>? appliedCriteria,
    List<Package>? filteredList,
    List<Package>? initList,
  }) {
    return FilteredPackagesState(
      appliedCriteria: appliedCriteria ?? this.appliedCriteria,
      filteredList: filteredList ?? this.filteredList,
      initList: initList ?? this.initList,
    );
  }

  @override
  List<Object?> get props => [appliedCriteria, filteredList, initList];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appliedCriteria': appliedCriteria.map(
          (key, value) => MapEntry(EnumToString.convertToString(key), value)),
      // 'filteredList': filteredList.map((x) => x.toMap()).toList(),
      // 'initList': initList.map((x) => x.toMap()).toList(),
    };
  }

//TODO: Not working...
  factory FilteredPackagesState.fromMap(Map<String, dynamic> map) {
    return FilteredPackagesState(
        appliedCriteria: Map<FilterType, dynamic>.from(
            (map['appliedCriteria'] as Map<String, dynamic>).map((key, value) =>
                MapEntry(
                    EnumToString.fromString(FilterType.values, key), value))));

    //   filteredList: List<Package>.from(
    //     (map['filteredList'] as List<dynamic>).map<Package>(
    //       (x) => Package.fromMap(x as Map<String, dynamic>),
    //     ),
    //   ),
    //   initList: List<Package>.from(
    //     (map['initList'] as List<dynamic>).map<Package>(
    //       (x) => Package.fromMap(x as Map<String, dynamic>),
    //     ),
    //   ),
    // );
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
    string.write(appliedCriteria.toString());
    string.write(', InitList Length: ${initList.length}');
    string.write(', FilteredList Length: ${filteredList.length}');
    return string.toString();
  }
}

class FilteredPackagesInitial extends FilteredPackagesState {
  const FilteredPackagesInitial({
    super.appliedCriteria = const <FilterType, dynamic>{
      FilterType.packageType: <String>[],
      FilterType.text: '',
    },
    super.filteredList = const <Package>[],
    super.initList = const <Package>[],
  });

  @override
  List<Object?> get props => [appliedCriteria, initList, filteredList];
}

class FilteredPackagesFailure extends FilteredPackagesState {
  const FilteredPackagesFailure(
      {required super.appliedCriteria,
      required super.filteredList,
      required super.initList,
      required this.except});

  final Exception except;

  @override
  List<Object?> get props => [appliedCriteria, filteredList, initList, except];
}
