import 'package:democratus/models/package.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:democratus/widgets/buttons/read_more_button.dart';
import 'package:democratus/widgets/buttons/save_button.dart';
import 'package:democratus/widgets/package_widgets/package_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PackageTile extends ConsumerStatefulWidget {
  const PackageTile({super.key, required this.packageProvider});
  final StateNotifierProvider<PackageProvider, Package> packageProvider;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PackageTileState();
}

class _PackageTileState extends ConsumerState<PackageTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    Package package = ref.watch(widget.packageProvider);
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
        onExpansionChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
        //TODO: Redundant, figure out why it's not inheriting from themedata
        shape: Border.all(style: BorderStyle.none, width: 0),
        title: Text(
          package.title,
          maxLines: !isExpanded ? 2 : 6,
          style: TextStyles.listTileTitle,
        ),
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
                    packageProvider: widget.packageProvider,
                  ),
                  Builder(builder: (context) {
                    if (package.hasHtml ?? false) {
                      return ReadMoreButton(
                        packageProvider: widget.packageProvider,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  })
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class PackageTile extends ConsumerWidget {
//   const PackageTile({super.key, required this.packageProvider});
//   final StateNotifierProvider<PackageProvider, Package> packageProvider;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     Package package = ref.watch(packageProvider);
//     // Navigator.push(
//     //     context,
//     //     PageRouteBuilder(
//     //       pageBuilder: (context, animation, secondaryAnimation) {
//     //         return PackageReader(
//     //           heroTag: heroTag,
//     //         );
//     //       },
//     //       transitionsBuilder:
//     //           (context, animation, secondaryAnimation, child) {
//     //         return SlideTransition(
//     //           position: Tween<Offset>(
//     //             begin: const Offset(1.0, 0.0),
//     //             end: Offset.zero,
//     //           ).animate(animation),
//     //           child: child,
//     //         );
//     //       },
//     //     ));

//     return Card(
//       child: ExpansionTile(
//         //TODO: Redundant, figure out why it's not inheriting from themedata
//         shape: Border.all(style: BorderStyle.none, width: 0),
//         title: Text(
//           package.title,
//           maxLines: 2,
//           style: TextStyles.listTileTitle,
//         ),
//         tilePadding: const EdgeInsets.only(left: 10, bottom: 0, right: 10),
//         children: [
//           ListTile(
//             contentPadding: const EdgeInsets.only(
//               left: 10,
//             ),
//             dense: true,
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 PackageDetails(
//                     package: package, style: TextStyles.expandedListTile),
//                 Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                   SaveButton(
//                     packageProvider: packageProvider,
//                   ),
//                   Builder(builder: (context) {
//                     if (package.hasHtml ?? false) {
//                       return ReadMoreButton(
//                         packageProvider: packageProvider,
//                       );
//                     } else {
//                       return const SizedBox.shrink();
//                     }
//                   })
//                 ]),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
