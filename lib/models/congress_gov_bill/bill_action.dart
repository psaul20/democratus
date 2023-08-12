// // data class for BillAction based on actions_example.json

// import 'package:equatable/equatable.dart';

// class BillAction extends Equatable {
//   final int actionCode;
//   final DateTime actionDate;
//   final Map<int, String> sourceSystem;
//   final String text;
//   final String type;

//   const BillAction({
//     required this.actionCode,
//     required this.actionDate,
//     required this.sourceSystem,
//     required this.text,
//     required this.type,
//   });

//   factory BillAction.fromJson(Map<String, dynamic> json) {
//     return BillAction(
//       actionCode: json['actionCode'],
//       actionDate: DateTime.parse(json['actionDate']),
//       sourceSystem: json['sourceSystem'],
//       text: json['text'],
//       type: json['type'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'actionCode': actionCode,
//       'actionDate': actionDate.toIso8601String(),
//       'sourceSystem': sourceSystem,
//       'text': text,
//       'type': type,
//     };
//   }

//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();
// }
