enum SearchSort { date, relevance }

extension SearchSortX on SearchSort {
  String get sortCode {
    switch (this) {
      case SearchSort.date:
        return 'date';
      case SearchSort.relevance:
        return '_score';
    }
  }
}