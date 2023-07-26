import 'package:democratus/widgets/generic/search_text_field.dart';
import 'package:flutter/material.dart';

class HomePageBar extends StatelessWidget {
  const HomePageBar({super.key});
  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(12),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Wrap(
              children: [
                SearchTextField(),
              ],
            )),
      ),
    );
  }
}
