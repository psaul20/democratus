import 'package:democratus/models/package.dart';
import 'package:flutter/cupertino.dart';

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
        children: package.getTextWidgets(style: style));
  }
}
