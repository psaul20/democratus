import 'package:democratus/widgets/generic/search_text_field.dart';
import 'package:flutter/material.dart';

class HomePageBar extends StatelessWidget {
  const HomePageBar({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(12),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: [
                SearchTextField(
                  onChanged: (text) {},
                ),
              ],
            )),
      ),
    );
  }
}
