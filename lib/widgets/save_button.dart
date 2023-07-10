import 'package:democratus/blocs/package_bloc.dart';
import 'package:democratus/blocs/saved_package_bloc.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageBloc, PackageState>(builder: (context, state) {
      saveTap() {
        //TODO: Add repository to tie these events together
        context.read<PackageBloc>().add(ToggleSave());

        if (state.package.isSaved) {
          context
              .read<SavedPackagesBloc>()
              .add(RemovePackage(package: state.package));
        } else {
          context
              .read<SavedPackagesBloc>()
              .add(SavePackage(package: state.package.copyWith(isSaved: true)));
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
                  Icon(state.package.isSaved
                      ? Icons.favorite
                      : Icons.favorite_border),
                  Text(
                    state.package.isSaved ? "Saved" : "Save",
                    textAlign: TextAlign.center,
                    style: TextStyles.iconText,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
