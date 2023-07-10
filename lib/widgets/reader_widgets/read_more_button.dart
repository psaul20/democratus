import 'package:democratus/blocs/package_bloc.dart';
import 'package:democratus/models/package.dart';
import 'package:democratus/pages/package_reader.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReadMoreButton extends ConsumerWidget {
  const ReadMoreButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocBuilder<PackageBloc, PackageState>(builder: (context, state) {
      readMore() {
        Package package = state.package;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return PackageReader(
            package: package,
          );
        }));
      }

      if (state.package.hasHtml == true) {
        return Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: readMore(),
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
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
