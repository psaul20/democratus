// ignore_for_file: public_member_api_docs, sort_constructors_first
// data class for BillAction based on actions_example.json

import 'dart:convert';

import 'package:democratus/globals/converters/string_converters.dart';
import 'package:equatable/equatable.dart';

class BillAction extends Equatable {
  final String? actionCode;
  final DateTime actionDate;
  final String description;
  final String type;

  String get displayActionType {
    List<String> strings =
        StringConverters.splitStringIntoChunksAtCapitalLetters(type);
    if (strings.length > 1) {
      return strings.join(' ');
    } else {
      return strings.first;
    }
  }

  const BillAction({
    this.actionCode,
    required this.actionDate,
    required this.description,
    required this.type,
  });

  @override
  List<Object?> get props {
    return [
      actionCode,
      actionDate,
      description,
      type,
    ];
  }

  BillAction copyWith({
    String? actionCode,
    DateTime? actionDate,
    String? description,
    String? type,
  }) {
    return BillAction(
      actionCode: actionCode ?? this.actionCode,
      actionDate: actionDate ?? this.actionDate,
      description: description ?? this.description,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'actionCode': actionCode,
      'actionDate': actionDate.toIso8601String(),
      'description': description,
      'type': type,
    };
  }

  factory BillAction.fromMap(Map<String, dynamic> map) {
    return BillAction(
      actionCode: map['actionCode'] as String?,
      actionDate: DateTime.parse(map['actionDate']),
      description: map['description'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BillAction.fromJson(String source) =>
      BillAction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
