part of 'bill_search_bloc.dart';

class BillSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

//TODO: Add events for keyword search & subject search

class KeywordSearch extends BillSearchEvent {
  final String keyword;

  KeywordSearch({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class ScrollSearchOffset extends BillSearchEvent {}