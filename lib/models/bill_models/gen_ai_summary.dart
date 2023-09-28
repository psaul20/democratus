// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:democratus/globals/strings.dart';

class GenAiSummary {
  // model class for a gen ai summary based on the summary_example.json file format
  String billId;
  String title;
  String who;
  String context;
  String prompt;
  String billText;
  List<SummaryPoint> summaryPoints;
  List<SummaryOutcome> summaryOutcomes;
  List<SummaryDeviant> summaryDeviants;
  GenAiSummary({
    required this.billId,
    required this.title,
    required this.who,
    required this.context,
    prompt,
    required this.billText,
    required this.summaryPoints,
    required this.summaryOutcomes,
    required this.summaryDeviants,
  }) : prompt = prompt ?? Strings.genAiSummaryPrompt + billText;

  GenAiSummary copyWith({
    String? billId,
    String? title,
    String? who,
    String? context,
    String? prompt,
    String? billText,
    List<SummaryPoint>? summaryPoints,
    List<SummaryOutcome>? summaryOutcomes,
    List<SummaryDeviant>? summaryDeviants,
  }) {
    return GenAiSummary(
      billId: billId ?? this.billId,
      title: title ?? this.title,
      who: who ?? this.who,
      context: context ?? this.context,
      prompt: prompt ?? this.prompt,
      billText: billText ?? this.billText,
      summaryPoints: summaryPoints ?? this.summaryPoints,
      summaryOutcomes: summaryOutcomes ?? this.summaryOutcomes,
      summaryDeviants: summaryDeviants ?? this.summaryDeviants,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Bill ID': billId,
      'Title': title,
      'Who': who,
      'Context': context,
      'Prompt': prompt,
      'Bill Text': billText,
      'Main Points': summaryPoints.map((x) => x.toMap()).toList(),
      'Outcomes': summaryOutcomes.map((x) => x.toMap()).toList(),
      'Deviants': summaryDeviants.map((x) => x.toMap()).toList(),
    };
  }

  factory GenAiSummary.fromMap(Map<String, dynamic> map) {
    return GenAiSummary(
      billId: map['Bill ID'] as String,
      title: map['Title'] as String,
      who: map['Who'] as String,
      context: map['Context'] as String,
      prompt: map['Prompt'] != null ? map['Prompt'] as String : null,
      billText: map['Bill Text'] as String,
      summaryPoints: List<SummaryPoint>.from(
        (map['Main Points'] as List<dynamic>).map<SummaryPoint>(
          (x) => SummaryPoint.fromMap(x as Map<String, dynamic>),
        ),
      ),
      summaryOutcomes: List<SummaryOutcome>.from(
        (map['Outcomes'] as List<dynamic>).map<SummaryOutcome>(
          (x) => SummaryOutcome.fromMap(x as Map<String, dynamic>),
        ),
      ),
      summaryDeviants: List<SummaryDeviant>.from(
        (map['Deviants'] as List<dynamic>).map<SummaryDeviant>(
          (x) => SummaryDeviant.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GenAiSummary.fromJson(String source) =>
      GenAiSummary.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GenAiSummary(billId: $billId, title: $title, who: $who, context: $context, prompt: $prompt, billText: $billText, summaryPoints: $summaryPoints, summaryOutcomes: $summaryOutcomes, summaryDeviants: $summaryDeviants)';
  }

  @override
  bool operator ==(covariant GenAiSummary other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.billId == billId &&
        other.title == title &&
        other.who == who &&
        other.context == context &&
        other.prompt == prompt &&
        other.billText == billText &&
        listEquals(other.summaryPoints, summaryPoints) &&
        listEquals(other.summaryOutcomes, summaryOutcomes) &&
        listEquals(other.summaryDeviants, summaryDeviants);
  }

  @override
  int get hashCode {
    return billId.hashCode ^
        title.hashCode ^
        who.hashCode ^
        context.hashCode ^
        prompt.hashCode ^
        billText.hashCode ^
        summaryPoints.hashCode ^
        summaryOutcomes.hashCode ^
        summaryDeviants.hashCode;
  }

  static getExampleSummary() =>
      GenAiSummary.fromJson(File(Strings.billSummaryPath).readAsStringSync());
}

class SummaryPoint {
  String title;
  String description;
  List<String> references;
  SummaryPoint({
    required this.title,
    required this.description,
    required this.references,
  });

  SummaryPoint copyWith({
    String? title,
    String? description,
    List<String>? references,
  }) {
    return SummaryPoint(
      title: title ?? this.title,
      description: description ?? this.description,
      references: references ?? this.references,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Title': title,
      'Description': description,
      'References': references,
    };
  }

  factory SummaryPoint.fromMap(Map<String, dynamic> map) {
    return SummaryPoint(
        title: map['Title'] as String,
        description: map['Description'] as String,
        references: List<String>.from(
          (map['References'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory SummaryPoint.fromJson(String source) =>
      SummaryPoint.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SummaryPoint(title: $title, description: $description, references: $references)';

  @override
  bool operator ==(covariant SummaryPoint other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.title == title &&
        other.description == description &&
        listEquals(other.references, references);
  }

  @override
  int get hashCode =>
      title.hashCode ^ description.hashCode ^ references.hashCode;
}

class SummaryOutcome {
  String title;
  String description;
  SummaryOutcome({
    required this.title,
    required this.description,
  });

  SummaryOutcome copyWith({
    String? title,
    String? description,
  }) {
    return SummaryOutcome(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Title': title,
      'Description': description,
    };
  }

  factory SummaryOutcome.fromMap(Map<String, dynamic> map) {
    return SummaryOutcome(
      title: map['Title'] as String,
      description: map['Description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SummaryOutcome.fromJson(String source) =>
      SummaryOutcome.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SummaryOutcome(title: $title, description: $description)';

  @override
  bool operator ==(covariant SummaryOutcome other) {
    if (identical(this, other)) return true;

    return other.title == title && other.description == description;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode;
}

class SummaryDeviant {
  String title;
  String description;
  List<String> references;
  SummaryDeviant({
    required this.title,
    required this.description,
    required this.references,
  });

  SummaryDeviant copyWith({
    String? title,
    String? description,
    List<String>? references,
  }) {
    return SummaryDeviant(
      title: title ?? this.title,
      description: description ?? this.description,
      references: references ?? this.references,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Title': title,
      'Description': description,
      'References': references,
    };
  }

  factory SummaryDeviant.fromMap(Map<String, dynamic> map) {
    return SummaryDeviant(
        title: map['Title'] as String,
        description: map['Description'] as String,
        references: List<String>.from(
          (map['References'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory SummaryDeviant.fromJson(String source) =>
      SummaryDeviant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SummaryDeviant(title: $title, description: $description, references: $references)';

  @override
  bool operator ==(covariant SummaryDeviant other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.title == title &&
        other.description == description &&
        listEquals(other.references, references);
  }

  @override
  int get hashCode =>
      title.hashCode ^ description.hashCode ^ references.hashCode;
}
