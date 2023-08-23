// // data class for bill amendment based on amendments_example.json

// import 'package:equatable/equatable.dart';

// class BillAmendment extends Equatable {
//   final int congress;
//   final String number;
//   final String type;
//   final String chamber;
//   final String description;
//   final Map<String, dynamic> latestAction;
//   final DateTime updatedDate;
//   final String url;

//   const BillAmendment({
//     required this.congress,
//     required this.number,
//     required this.type,
//     required this.chamber,
//     required this.description,
//     required this.latestAction,
//     required this.updatedDate,
//     required this.url,
//     });

//   factory BillAmendment.fromJson(Map<String, dynamic> json) {
//     return BillAmendment(
//       congress: json['congress'],
//       number: json['number'],
//       type: json['type'],
//       chamber: json['chamber'],
//       description: json['description'],
//       latestAction: json['latestAction'],
//       updatedDate: DateTime.parse(json['updatedDate']),
//       url: json['url'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'congress': congress,
//       'number': number,
//       'type': type,
//       'chamber': chamber,
//       'description': description,
//       'latestAction': latestAction,
//       'updatedDate': updatedDate.toIso8601String(),
//       'url': url,
//     };
//   }

//   @override
//   List<Object?> get props => [congress, number, type, chamber, description, latestAction, updatedDate, url];
// }
