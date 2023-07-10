import 'package:democratus/blocs/package_search_bloc.dart';
import 'package:democratus/widgets/generic/errors.dart';
import 'package:democratus/widgets/generic/icon_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchButtonBuilder extends StatelessWidget {
  const SearchButtonBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageSearchBloc, PackageSearchState>(
        builder: (context, state) {
      switch (state.status) {
        case PackageSearchStatus.initial:
          {
            return state.isReady
                ? IconTextButton(
                    onPressed: () =>
                        context.read<PackageSearchBloc>().add(SubmitSearch()),
                    text: "Search",
                    icon: const Icon(Icons.search_outlined))
                : const IconTextButton(
                    onPressed: null,
                    text: "Complete Fields",
                    icon: Icon(Icons.search_outlined));
          }
        case PackageSearchStatus.success:
          {
            return IconTextButton(
                onPressed: () =>
                    context.read<PackageSearchBloc>().add(ClearSearch()),
                text: "Clear Search",
                icon: const Icon(Icons.remove_circle_outline_rounded));
          }
        case PackageSearchStatus.failure:
          {
            return const ErrorText();
          }
      }
    });
  }
}
