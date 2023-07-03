import 'package:democratus/models/package.dart';
import 'package:democratus/pages/package_reader.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReadMoreButton extends ConsumerWidget {
  const ReadMoreButton({super.key, required this.packageProvider});
  final StateNotifierProvider<PackageProvider, Package> packageProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    readMore() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return PackageReader(packageProvider: packageProvider);
      }));
    }

    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: readMore,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.chrome_reader_mode_outlined),
                Text(
                  "Read More",
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
