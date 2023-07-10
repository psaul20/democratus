import 'package:democratus/blocs/package_bloc.dart';
import 'package:democratus/blocs/saved_package_bloc.dart';
import 'package:democratus/models/package.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:democratus/widgets/generic/fetch_circle.dart';
import 'package:democratus/widgets/package_widgets/package_details.dart';
import 'package:democratus/widgets/reader_widgets/read_more_button.dart';
import 'package:democratus/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO: Animate data retrieval

class PackageTile extends StatefulWidget {
  const PackageTile({super.key, required this.packageBloc});
  final PackageBloc packageBloc;

  @override
  State<PackageTile> createState() => _PackageTileState();
}

class _PackageTileState extends State<PackageTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    checkSaved(Package package) {
      List<Package> savedPackages =
          context.read<SavedPackagesBloc>().state.packages;
      List<String> savedIds = [
        for (final package in savedPackages) package.packageId
      ];
      if (savedIds.contains(package.packageId)) {
        context
            .read<PackageBloc>()
            .add(UpdatePackage(package.copyWith(isSaved: true)));
      }
    }

    return BlocBuilder<PackageBloc, PackageState>(
        // Specifying to avoid state weirdness
        bloc: widget.packageBloc,
        builder: (context, state) {
          if (!state.package.isSaved) {
            checkSaved(state.package);
          }
          return Card(
            child: ExpansionTile(
              onExpansionChanged: (value) {
                if (value) {
                  if (!state.package.hasDetails) {
                    context
                        .read<PackageBloc>()
                        .add(GetPackage(state.package.packageId));
                  }
                }
                setState(() {
                  isExpanded = value;
                });
              },
              //TODO: Redundant, figure out why it's not inheriting from themedata
              shape: Border.all(style: BorderStyle.none, width: 0),
              title: Text(
                state.package.displayTitle,
                maxLines: isExpanded ? 6 : 2,
                style: TextStyles.listTileTitle,
              ),
              tilePadding:
                  const EdgeInsets.only(left: 10, bottom: 0, right: 10),
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.only(
                    left: 10,
                  ),
                  dense: true,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.package.hasDetails
                          ? PackageDetails(package: state.package)
                          : const Center(child: FetchCircle()),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SaveButton(),
                            //TODO: Figure out read more screen
                            Builder(builder: (context) {
                              if (state.package.hasHtml ?? false) {
                                return const ReadMoreButton();
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
        });
  }
}
