// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Proposal _$ProposalFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['download', 'dateIssued'],
  );
  return Proposal(
    json['originChamber'] as String? ?? 'Unknown',
    json['session'] as String? ?? 'Unknown',
    json['detailsLink'] as String? ?? 'Unknown',
    json['shortTitle'] as List<dynamic>? ?? ['Unknown'],
    json['title'] as String? ?? 'Unknown',
    json['branch'] as String? ?? 'Unknown',
    json['download'] as Map<String, dynamic>,
    json['pages'] == null ? 0 : Proposal._stringToInt(json['pages'] as String?),
    DateTime.parse(json['dateIssued'] as String),
    json['currentChamber'] as String? ?? 'Unknown',
    json['billVersion'] as String? ?? 'Unknown',
    json['billType'] as String? ?? 'Unknown',
    json['packageId'] as String? ?? 'Unknown',
    json['collectionCode'] as String? ?? 'Unknown',
    json['governmentAuthor1'] as String? ?? 'Unknown',
    json['publisher'] as String? ?? 'Unknown',
    json['docClass'] as String? ?? 'Unknown',
    DateTime.parse(json['lastModified'] as String),
    json['category'] as String? ?? 'Unknown',
    json['billNumber'] == null
        ? 0
        : Proposal._stringToInt(json['billNumber'] as String?),
  );
}

Map<String, dynamic> _$ProposalToJson(Proposal instance) => <String, dynamic>{
      'originChamber': instance.originChamber,
      'session': instance.session,
      'detailsLink': instance.detailsLink,
      'shortTitle': instance.shortTitle,
      'title': instance.title,
      'branch': instance.branch,
      'download': instance.download,
      'pages': instance.pages,
      'dateIssued': instance.dateIssued.toIso8601String(),
      'currentChamber': instance.currentChamber,
      'billVersion': instance.billVersion,
      'billType': instance.billType,
      'packageId': instance.packageId,
      'collectionCode': instance.collectionCode,
      'governmentAuthor1': instance.governmentAuthor1,
      'publisher': instance.publisher,
      'docClass': instance.docClass,
      'lastModified': instance.lastModified.toIso8601String(),
      'category': instance.category,
      'billNumber': instance.billNumber,
    };
