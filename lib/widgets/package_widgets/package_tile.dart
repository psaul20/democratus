import 'package:democratus/models/package.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:democratus/widgets/buttons/read_more_button.dart';
import 'package:democratus/widgets/buttons/save_button.dart';
import 'package:democratus/widgets/package_widgets/package_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PackageTile extends ConsumerWidget {
  const PackageTile({super.key, required this.packageProvider});
  final StateNotifierProvider<PackageProvider, Package> packageProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Package package = ref.watch(packageProvider);
    // Navigator.push(
    //     context,
    //     PageRouteBuilder(
    //       pageBuilder: (context, animation, secondaryAnimation) {
    //         return PackageReader(
    //           heroTag: heroTag,
    //         );
    //       },
    //       transitionsBuilder:
    //           (context, animation, secondaryAnimation, child) {
    //         return SlideTransition(
    //           position: Tween<Offset>(
    //             begin: const Offset(1.0, 0.0),
    //             end: Offset.zero,
    //           ).animate(animation),
    //           child: child,
    //         );
    //       },
    //     ));

    return Card(
      child: ExpansionTile(
        title: Text(package.title),
        tilePadding: const EdgeInsets.only(left: 10, bottom: 0, right: 10),
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(
              left: 10,
            ),
            dense: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PackageDetails(
                    package: package, style: TextStyles.expandedListTile),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SaveButton(
                    packageProvider: packageProvider,
                  ),
                  ReadMoreButton(
                    packageProvider: packageProvider,
                  )
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
