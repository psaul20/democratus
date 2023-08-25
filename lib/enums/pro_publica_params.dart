enum ProPublicaSort { date, relevance }

extension ProPublicaSortExtension on ProPublicaSort {
  String get sortCode {
    switch (this) {
      case ProPublicaSort.date:
        return 'date';
      case ProPublicaSort.relevance:
        return '_score';
    }
  }
}