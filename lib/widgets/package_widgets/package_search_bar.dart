import 'package:democratus/models/collection.dart';
import 'package:democratus/providers/search_providers.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:democratus/widgets/buttons/search_button_builder.dart';
import 'package:democratus/widgets/date_input/date_picker.dart';
import 'package:democratus/widgets/dropdowns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PackageSearchBar extends ConsumerWidget {
  const PackageSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Collection>? collections = ref.read(collectionsProvider).asData?.value;
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          children: [
            Text(
              "Choose a Collection",
              textAlign: TextAlign.left,
              style: TextStyles.fieldTitle,
            ),
            AsyncDropDownBuilder(
              provider: collectionsProvider,
              dropDownValue:
                  ref.watch(selectedCollectionProvider)?.collectionName,
              onChanged: (String? value) {
                if (collections != null) {
                  int? idx = collections
                      .indexWhere((element) => element.collectionName == value);
                  ref.read(selectedCollectionProvider.notifier).state =
                      collections.elementAt(idx);
                }
              },
              mapFunction: (element) {
                return DropdownMenuItem<String>(
                  value: element.collectionName,
                  child: Text(
                    element.collectionName,
                    style: TextStyles.inputStyle,
                  ),
                );
              },
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    children: [
                      Text(
                        'Published After',
                        style: TextStyles.fieldTitle,
                      ),
                      MyDatePicker(dateProvider: startDateInputProvider),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Published Before',
                      style: TextStyles.fieldTitle,
                    ),
                    MyDatePicker(
                      dateProvider: endDateInputProvider,
                      afterDateProvider: startDateInputProvider,
                    ),
                  ],
                ),
              ],
            ),
            const Center(child: SearchButtonBuilder()),
          ],
        ));
  }
}
