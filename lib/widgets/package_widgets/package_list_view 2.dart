//TODO: Remove if no longer needed
// import 'package:democratus/models/package.dart';
// import 'package:democratus/providers/package_providers.dart';
// import 'package:democratus/widgets/package_widgets/package_tile.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class PackageListView extends ConsumerWidget {
//   const PackageListView({
//     super.key,
//     required this.packages,
//   });
//   final List<Package> packages;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     if (packages.isEmpty) {
//       return const SizedBox.shrink();
//     } else {
//       return SliverList(delegate: SliverChildListDelegate())
//       // return ListView.builder(
//       //     itemCount: packages.length,
//       //     itemBuilder: ((context, index) {
//       //       return ProviderScope(overrides: [
//       //         thisPackageProvider.overrideWith((ref) => PackageProvider(packages[index]))
//       //       ], child: const PackageTile());
//       //     }));
//     }
//   }
// }
