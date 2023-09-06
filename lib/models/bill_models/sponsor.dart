// ignore_for_file: public_member_api_docs, sort_constructors_first
// Data class for sponsor from this
// "sponsor_title": "Rep.",
// "sponsor": "Juan Vargas",
// "sponsor_id": "V000130",
// "sponsor_uri": "https://api.propublica.org/congress/v1/members/V000130.json",
// "sponsor_party": "D",
// "sponsor_state": "CA",

import 'dart:convert';

import 'package:equatable/equatable.dart';

class BillSponsor extends Equatable {
  final String? sponsorFullName;
  final String? sponsorTitle;
  final String? sponsorName;
  final String? sponsorId;
  final Uri? sponsorUri;
  final String? sponsorParty;
  final String? sponsorState;
  const BillSponsor({
    this.sponsorFullName,
    this.sponsorTitle,
    this.sponsorName,
    this.sponsorId,
    this.sponsorUri,
    this.sponsorParty,
    this.sponsorState,
  }) : assert(sponsorFullName != null ||
            (sponsorName != null &&
                sponsorTitle != null &&
                sponsorParty != null &&
                sponsorState != null));

  BillSponsor copyWith({
    String? sponsorFullName,
    String? sponsorTitle,
    String? sponsorName,
    String? sponsorId,
    Uri? sponsorUri,
    String? sponsorParty,
    String? sponsorState,
  }) {
    return BillSponsor(
      sponsorFullName: sponsorFullName ?? this.sponsorFullName,
      sponsorTitle: sponsorTitle ?? this.sponsorTitle,
      sponsorName: sponsorName ?? this.sponsorName,
      sponsorId: sponsorId ?? this.sponsorId,
      sponsorUri: sponsorUri ?? this.sponsorUri,
      sponsorParty: sponsorParty ?? this.sponsorParty,
      sponsorState: sponsorState ?? this.sponsorState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sponsorFullName': sponsorFullName,
      'sponsorTitle': sponsorTitle,
      'sponsorName': sponsorName,
      'sponsorId': sponsorId,
      'sponsorUri': sponsorUri.toString(),
      'sponsorParty': sponsorParty,
      'sponsorState': sponsorState,
    };
  }

  factory BillSponsor.fromMap(Map<String, dynamic> map) {
    return BillSponsor(
      sponsorFullName: map['sponsorFullName'] as String?,
      sponsorTitle: map['sponsorTitle'] as String?,
      sponsorName: map['sponsorName'] as String?,
      sponsorId: map['sponsorId'] as String?,
      sponsorUri: Uri.parse(map['sponsorUri'] as String),
      sponsorParty: map['sponsorParty'] as String?,
      sponsorState: map['sponsorState'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory BillSponsor.fromJson(String source) =>
      BillSponsor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      sponsorTitle,
      sponsorName,
      sponsorId,
      sponsorUri,
      sponsorParty,
      sponsorState,
    ];
  }
}
