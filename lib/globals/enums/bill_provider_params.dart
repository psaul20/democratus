import 'package:democratus/globals/enums/bill_source.dart';

enum SearchSort { date, relevance }

extension SearchSortX on SearchSort {
  String sortCode(BillSource source) {
    switch (this) {
      case SearchSort.date:
        return 'date';
      case SearchSort.relevance:
        return source == BillSource.proPublica ? '_score' : 'score';
    }
  }
}
