import 'package:democratus/widgets/search_widgets/search_filter_widgets/search_text_field.dart';
import 'package:flutter/material.dart';

//NOTE: Unused currently

class PackageSearchBar extends StatelessWidget {
  const PackageSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
        floating: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(8),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SearchTextField(),
          ),
        ));
  }
}
