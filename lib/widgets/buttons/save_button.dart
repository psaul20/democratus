import 'package:democratus/main.dart';
import 'package:democratus/models/package.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveButton extends ConsumerWidget {
  const SaveButton({
    super.key,
    required this.packageProvider,
  });
  final StateNotifierProvider<PackageProvider, Package> packageProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Package package = ref.watch(packageProvider);
    bool isSaved = package.isSaved;
    saveTap() {
      ref.read(packageProvider.notifier).toggleSave();
      package = ref.read(packageProvider);
      if (isSaved) {
        ref.read(savedPackagesProvider.notifier).removePackage(package);
      } else {
        ref.read(savedPackagesProvider.notifier).addPackage(package);
      }
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
                Icon(isSaved ? Icons.favorite : Icons.favorite_border),
                Text(
                  isSaved ? "Saved" : "Save",
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
