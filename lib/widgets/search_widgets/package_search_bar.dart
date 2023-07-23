import 'package:democratus/theming/text_styles.dart';
import 'package:democratus/widgets/search_widgets/search_button_builder.dart';
import 'package:democratus/widgets/search_widgets/search_date_picker.dart';
import 'package:democratus/widgets/search_widgets/search_collection_dropdown.dart';
import 'package:flutter/material.dart';
class PackageSearchBar extends StatelessWidget {
  const PackageSearchBar({super.key});
  //TODO: Create persistent state (look into hydratedbloc?)

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            const Center(child: SearchButtonBuilder()),
          ],
        ));
  }
}
