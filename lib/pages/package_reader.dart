import 'package:democratus/models/package.dart';
import 'package:democratus/widgets/buttons/save_button.dart';
import 'package:democratus/widgets/package_widgets/package_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PackageReader extends ConsumerWidget {
  const PackageReader({super.key, required this.packageProvider});
  final StateNotifierProvider<PackageProvider, Package> packageProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Package package = ref.watch(packageProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reader"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [PackageDetails(package: package)],
        ),
      ),
      floatingActionButton: SaveButton(
        packageProvider: packageProvider,
      ),
    );
  }
}
