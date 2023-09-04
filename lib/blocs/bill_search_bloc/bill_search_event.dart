part of 'bill_search_bloc.dart';

class BillSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class KeywordSearch extends BillSearchEvent {
  final String keyword;

  KeywordSearch({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class ScrollSearchOffset extends BillSearchEvent {}