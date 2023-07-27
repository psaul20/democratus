import 'package:democratus/widgets/generic/search_text_field.dart';
import 'package:flutter/material.dart';

class PackageSearchBar extends StatelessWidget {
  const PackageSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
        floating: true,
        //TODO: Figure out how to make this flexible size - or make it a drawer?
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(8),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SearchTextField(),
          ),
        ));
  }
}
