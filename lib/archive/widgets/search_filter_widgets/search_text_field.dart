
import 'package:democratus/archive/bloc/filtered_packages/filtered_packages_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  TextEditingController controller = TextEditingController();

  void _onChanged(BuildContext context) {
    context
        .read<FilteredPackagesBloc>()
        .add(UpdateTextFilter(text: controller.text));
  }

  @override
  Widget build(BuildContext context) {
    controller.text = context.read<FilteredPackagesBloc>().state.textFilter;
    return BlocBuilder<FilteredPackagesBloc, FilteredPackagesState>(
      buildWhen: (previous, current) =>
          previous.textFilter != current.textFilter,
      builder: (context, state) {
        return Row(
          children: [
            const Icon(Icons.search),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration()
                    .copyWith(hintText: 'Keyword Filter'),
                onChanged: (_) => _onChanged(context),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}