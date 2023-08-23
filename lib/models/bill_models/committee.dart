// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Committee {
  final String code;
  final String description;
  Committee({
    required this.code,
    required this.description,
  });

  Committee copyWith({
    String? code,
    String? description,
  }) {
    return Committee(
      code: code ?? this.code,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'description': description,
    };
  }

  factory Committee.fromMap(Map<String, dynamic> map) {
    return Committee(
      code: map['code'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Committee.fromJson(String source) => Committee.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Committee(code: $code, description: $description)';

  @override
  bool operator ==(covariant Committee other) {
    if (identical(this, other)) return true;
  
    return 
      other.code == code &&
      other.description == description;
  }

  @override
  int get hashCode => code.hashCode ^ description.hashCode;
}
