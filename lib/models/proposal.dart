import 'package:json_annotation/json_annotation.dart';

part 'proposal.g.dart';

// Using Json serializable generator from https://docs.flutter.dev/data-and-backend/json
@JsonSerializable()
class Proposal {
  Proposal(
      this.originChamber,
      this.session,
      this.detailsLink,
      this.shortTitle,
      this.title,
      this.branch,
      this.download,
      this.pages,
      this.dateIssued,
      this.currentChamber,
      this.billVersion,
      this.billType,
      this.packageId,
      this.collectionCode,
      this.governmentAuthor1,
      this.publisher,
      this.docClass,
      this.lastModified,
      this.category,
      this.billNumber);
  @JsonKey(defaultValue: 'Unknown')
  String originChamber;
  @JsonKey(defaultValue: 'Unknown')
  String session;
  @JsonKey(defaultValue: 'Unknown')
  String detailsLink;
  @JsonKey(defaultValue: ['Unknown'])
  List shortTitle;
  @JsonKey(defaultValue: 'Unknown')
  String title;
  @JsonKey(defaultValue: 'Unknown')
  String branch;
  @JsonKey(required: true)
  Map download;
  @JsonKey(defaultValue: 000, fromJson: _stringToInt)
  int pages;
  @JsonKey(required: true)
  DateTime dateIssued;
  @JsonKey(defaultValue: 'Unknown')
  String currentChamber;
  @JsonKey(defaultValue: 'Unknown')
  String billVersion;
  @JsonKey(defaultValue: 'Unknown')
  String billType;
  @JsonKey(defaultValue: 'Unknown')
  String packageId;
  @JsonKey(defaultValue: 'Unknown')
  String collectionCode;
  @JsonKey(defaultValue: 'Unknown')
  String governmentAuthor1;
  @JsonKey(defaultValue: 'Unknown')
  String publisher;
  @JsonKey(defaultValue: 'Unknown')
  String docClass;
  DateTime lastModified;
  @JsonKey(defaultValue: 'Unknown')
  String category;
  @JsonKey(defaultValue: 000, fromJson: _stringToInt)
  int billNumber;

  factory Proposal.fromJson(Map<String, dynamic> json) =>
      _$ProposalFromJson(json);
  Map<String, dynamic> toJson() => _$ProposalToJson(this);

  // Taken from https://github.com/google/json_serializable.dart/issues/503
  static int _stringToInt(String? number) =>
      number == null ? 000 : int.parse(number);
  // static String _stringFromInt(int number) => number?.toString();
}
