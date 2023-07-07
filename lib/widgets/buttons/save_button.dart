import 'package:democratus/models/package.dart';
import 'package:democratus/providers/package_providers.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveButton extends ConsumerWidget {
  const SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Package thisPackage = context.watch(packageProvider);
    // Check if package is already saved
    List<Package> savedPackages = ref.watch(savedPackagesProvider);
    List<String> savedIds = [
      for (final package in savedPackages) package.packageId
    ];
    savedIds.contains(thisPackage.packageId)
        ? thisPackage.isSaved = true
        : thisPackage.isSaved = false;

    saveTap() {
      if (thisPackage.isSaved) {
        ref.read(savedPackagesProvider.notifier).removePackage(thisPackage);
      } else {
        ref
            .read(savedPackagesProvider.notifier)
            .addPackage(thisPackage.copyWith(isSaved: true));
      }
      ref.read(thisPackageProvider.notifier).toggleSave();
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
                Icon(thisPackage.isSaved
                    ? Icons.favorite
                    : Icons.favorite_border),
                Text(
                  thisPackage.isSaved ? "Saved" : "Save",
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
