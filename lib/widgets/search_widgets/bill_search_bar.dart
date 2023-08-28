import 'package:democratus/widgets/search_widgets/bill_search_text_field.dart';
import 'package:flutter/material.dart';

//NOTE: Unused currently

class BillSearchBar extends StatelessWidget {
  const BillSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
        floating: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(8),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: BillSearchTextField(),
          ),
        ));
  }
}
