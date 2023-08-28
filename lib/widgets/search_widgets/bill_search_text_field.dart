import 'package:democratus/blocs/bill_search_bloc/bill_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillSearchTextField extends StatefulWidget {
  const BillSearchTextField({super.key});

  @override
  State<BillSearchTextField> createState() => _BillSearchTextFieldState();
}

class _BillSearchTextFieldState extends State<BillSearchTextField> {
  TextEditingController controller = TextEditingController();

  void _onPress(BuildContext context) {
    context.read<BillSearchBloc>().add(KeywordSearch(keyword: controller.text));
  }

  @override
  Widget build(BuildContext context) {
    controller.text = context.read<BillSearchBloc>().state.keyword;

    return Row(
      children: [
        const Icon(Icons.search),
        const SizedBox(
          width: 10,
        ),
        BlocBuilder<BillSearchBloc, BillSearchState>(
          buildWhen: (previous, current) => previous.keyword != current.keyword,
          builder: (context, state) {
            return Expanded(
              flex: 2,
              child: TextField(
                controller: controller,
                decoration: const InputDecoration()
                    .copyWith(hintText: 'Keyword Search'),
              ),
            );
          },
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
              onPressed: () {
                _onPress(context);
              },
              child: const Text('Search')),
        )
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
