import 'package:democratus/models/package.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class PackageDetails extends StatelessWidget {
  const PackageDetails({
    super.key,
    required this.package,
    this.style,
  });

  final Package package;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Author: ${package.governmentAuthor1 ?? "Unknown"}",
          textAlign: TextAlign.start,
          style: style,
        ),
        Text(
          "Category: ${package.category ?? "Unknown"}",
          textAlign: TextAlign.start,
          style: style,
        ),
        Text(
          "Type: ${package.billType ?? "Unknown"}",
          textAlign: TextAlign.start,
          style: style,
        ),
        Text(
          "Branch: ${package.branch ?? "Unknown"}",
          textAlign: TextAlign.start,
          style: style,
        ),
        Text(
          "Origin Chamber: ${package.originChamber ?? "Unknown"}",
          textAlign: TextAlign.start,
          style: style,
        ),
        Text(
          "Current Chamber: ${package.currentChamber ?? "Unknown"}",
          textAlign: TextAlign.start,
          style: style,
        ),
        Text(
          "Pages: ${package.pages?.toString() ?? "Unknown"}",
          textAlign: TextAlign.start,
          style: style,
        ),
        Text(
          "Publisher: ${package.publisher ?? "Unknown"}",
          textAlign: TextAlign.start,
          style: style,
        ),
        Text(
          "Congress: ${package.congress ?? "Unknown"}",
          textAlign: TextAlign.start,
          style: style,
        ),
        Text(
          "Bill Number: ${package.billNumber?.toString() ?? "Unknown"}",
          textAlign: TextAlign.start,
          style: style,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            "Last Action: ${DateFormat.yMMMd().format(package.lastModified)}",
            textAlign: TextAlign.start,
            style: style,
          ),
        ),
      ],
    );
  }
}
