import 'package:democratus/main.dart';
import 'package:democratus/pages/package_reader.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:democratus/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:democratus/models/package.dart';

class PackageListView extends StatelessWidget {
  const PackageListView({
    super.key,
    required this.packages,
  });
  final List<Package> packages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: packages.length,
        itemBuilder: ((context, index) {
          Package package = packages.elementAt(index);
          return PackageTile(package: package);
        }));
  }
}

class PackageTile extends ConsumerWidget {
  const PackageTile({super.key, required this.package});
  final Package package;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(savedPackagesProvider);
    saveTap() {
      if (package.isSaved) {
        ref.read(savedPackagesProvider.notifier).removePackage(package);
        package.isSaved = false;
      } else {
        ref.read(savedPackagesProvider.notifier).savePackage(package);
        package.isSaved = true;
      }
    }

    readMore() {
      Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const PackageReader();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ));
    }

    return Hero(
      tag: 'cardToFullScreen${package.packageId}',
      child: Card(
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
                  Text(
                    "Author: ${package.governmentAuthor1 ?? "Unknown"}",
                    textAlign: TextAlign.start,
                    style: TextStyles.expandedListTile,
                  ),
                  Text(
                    "Category: ${package.category ?? "Unknown"}",
                    textAlign: TextAlign.start,
                    style: TextStyles.expandedListTile,
                  ),
                  Text(
                    "Type: ${package.billType ?? "Unknown"}",
                    textAlign: TextAlign.start,
                    style: TextStyles.expandedListTile,
                  ),
                  Text(
                    "Branch: ${package.branch ?? "Unknown"}",
                    textAlign: TextAlign.start,
                    style: TextStyles.expandedListTile,
                  ),
                  Text(
                    "Origin Chamber: ${package.originChamber ?? "Unknown"}",
                    textAlign: TextAlign.start,
                    style: TextStyles.expandedListTile,
                  ),
                  Text(
                    "Current Chamber: ${package.currentChamber ?? "Unknown"}",
                    textAlign: TextAlign.start,
                    style: TextStyles.expandedListTile,
                  ),
                  Text(
                    "Pages: ${package.pages?.toString() ?? "Unknown"}",
                    textAlign: TextAlign.start,
                    style: TextStyles.expandedListTile,
                  ),
                  Text(
                    "Publisher: ${package.publisher ?? "Unknown"}",
                    textAlign: TextAlign.start,
                    style: TextStyles.expandedListTile,
                  ),
                  Text(
                    "Congress: ${package.congress ?? "Unknown"}",
                    textAlign: TextAlign.start,
                    style: TextStyles.expandedListTile,
                  ),
                  Text(
                    "Bill Number: ${package.billNumber?.toString() ?? "Unknown"}",
                    textAlign: TextAlign.start,
                    style: TextStyles.expandedListTile,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      "Last Action: ${DateFormat.yMMMd().format(package.lastModified)}",
                      textAlign: TextAlign.start,
                      style: TextStyles.expandedListTile,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SaveButton(
                        isSaved: package.isSaved,
                        onTap: saveTap,
                      ),
                      ReadMoreButton(onTap: readMore)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
