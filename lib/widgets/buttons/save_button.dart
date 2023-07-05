import 'package:democratus/models/package.dart';
import 'package:democratus/providers/package_providers.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveButton extends ConsumerWidget {
  const SaveButton({
    super.key,
    required this.packagesProvider,
    required this.packageId,
  });
  final StateNotifierProvider<PackagesProvider, List<Package>> packagesProvider;
  final String packageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Package package = ref.watch(packagesProvider.select((packages) =>
        packages.firstWhere((package) => package.packageId == packageId)));
    saveTap() {
      if (package.isSaved) {
        ref.read(savedPackagesProvider.notifier).removePackage(package);
      } else {
        ref.read(savedPackagesProvider.notifier).addPackage(package);
      }
      package.isSaved = !package.isSaved;
      ref
          .read(packagesProvider.notifier)
          .updatePackageWith(packageId: packageId, updatePackage: package);
    }

    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: saveTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(package.isSaved ? Icons.favorite : Icons.favorite_border),
                Text(
                  package.isSaved ? "Saved" : "Save",
                  textAlign: TextAlign.center,
                  style: TextStyles.iconText,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
