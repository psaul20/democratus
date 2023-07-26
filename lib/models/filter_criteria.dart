// ignore_for_file: public_member_api_docs, sort_constructors_first
enum FilterType { text }

abstract class FilterCriterion {
  FilterType type;
  Object? data;
  FilterCriterion({
    required this.type,
    this.data,
  });
}

class TextFilter extends FilterCriterion {
  TextFilter({
    required FilterType criteria,
    String data = '',
  }) : super(
          type: criteria,
          data: data,
        );

  @override
  String? get data => super.data as String;
}
