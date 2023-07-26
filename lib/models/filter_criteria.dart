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
    String data = '',
  }) : super(
          type: FilterType.text,
          data: data,
        );

  @override
  String? get data => super.data as String;
}
