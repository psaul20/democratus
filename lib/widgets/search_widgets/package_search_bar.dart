import 'package:democratus/theming/text_styles.dart';
import 'package:democratus/widgets/generic/search_text_field.dart';
import 'package:democratus/widgets/search_widgets/search_button_builder.dart';
import 'package:democratus/widgets/search_widgets/search_date_picker.dart';
import 'package:democratus/widgets/search_widgets/search_collection_dropdown.dart';
import 'package:flutter/material.dart';

class PackageSearchBar extends StatelessWidget {
  const PackageSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      title: const Text("Search Documents"),
      //TODO: Figure out how to make this flexible size - or make it a drawer?
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(260),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: [
                Text(
                  "Choose a Collection",
                  textAlign: TextAlign.left,
                  style: TextStyles.fieldTitle,
                ),
                const SearchCollectionDropdownBuilder(),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    children: [
                      Text(
                        'Published After',
                        style: TextStyles.fieldTitle,
                      ),
                      const SearchDatePicker(isStartDate: true),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Published Before',
                      style: TextStyles.fieldTitle,
                    ),
                    const SearchDatePicker(isEndDate: true)
                  ],
                ),
                const SearchTextField(),
                const Center(child: SearchButtonBuilder()),
              ],
            )),
      ),
    );
  }
}
