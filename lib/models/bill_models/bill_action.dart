// ignore_for_file: public_member_api_docs, sort_constructors_first
// data class for BillAction based on actions_example.json

import 'dart:convert';

import 'package:equatable/equatable.dart';

class BillAction extends Equatable {
  final int actionId;
  final DateTime actionDate;
  final String description;
  final String type;
  final String chamber;

  const BillAction({
    required this.actionId,
    required this.actionDate,
    required this.description,
    required this.type,
    required this.chamber,
  });

  @override
  // TODO: implement props
  List<Object> get props {
    return [
      actionId,
      actionDate,
      description,
      type,
      chamber,
    ];
  }

  BillAction copyWith({
    int? actionId,
    DateTime? actionDate,
    String? description,
    String? type,
    String? chamber,
  }) {
    return BillAction(
      actionId: actionId ?? this.actionId,
      actionDate: actionDate ?? this.actionDate,
      description: description ?? this.description,
      type: type ?? this.type,
      chamber: chamber ?? this.chamber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'actionId': actionId,
      'actionDate': actionDate.toIso8601String(),
      'description': description,
      'type': type,
      'chamber': chamber,
    };
  }

  factory BillAction.fromMap(Map<String, dynamic> map) {
    return BillAction(
      actionId: map['actionId'] as int,
      actionDate: DateTime.parse(map['actionDate']),
      description: map['description'] as String,
      type: map['type'] as String,
      chamber: map['chamber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BillAction.fromJson(String source) =>
      BillAction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
