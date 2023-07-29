import 'package:democratus/theming/theme_data.dart';
import 'package:democratus/widgets/search_widgets/search_collection_dropdown.dart';
import 'package:democratus/widgets/search_widgets/search_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//TODO: Implement congressional hearings

class SearchDialog extends StatelessWidget {
  const SearchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Filter By",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 2,
                color: DemocScheme.scheme.onBackground,
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Date published',
                  style: Theme.of(context).textTheme.bodyLarge),
              Row(
                children: [
                  const SearchDatePicker(isStartDate: true),
                  Text(
                    'to',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SearchDatePicker(isEndDate: true),
                ],
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('DONE')),
              )
            ],
          ),
        ));
  }
}

//NOTE: Previous version as draggablescrollable

// class SearchSheet extends StatelessWidget {
//   const SearchSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       borderRadius: BorderRadius.circular(30),
//       color: Theme.of(context).colorScheme.secondaryContainer,
//       elevation: 6,
//       child: DraggableScrollableSheet(
//           initialChildSize:
//               context.read<PackageSearchBloc>().state.searchPackages.isEmpty
//                   ? .6
//                   : .2,
//           maxChildSize: .8,
//           minChildSize: .2,
//           expand: false,
//           builder: (context, controller) {
//             //TODO: Figure out why controller isn't animating on search
//             onSearch() {
//               controller.animateTo(.2,
//                   duration: const Duration(seconds: 1),
//                   curve: Curves.decelerate);
//             }

//             _onClear() {}
//             return SingleChildScrollView(
//               controller: controller,
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   children: [
//                     const Icon(Icons.keyboard_double_arrow_up),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       "Search Criteria",
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       height: 2,
//                       color: DemocScheme.scheme.onBackground,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Wrap(
//                       children: [
//                         const SearchCollectionDropdownBuilder(),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 10.0),
//                           child: Column(
//                             children: [
//                               Text(
//                                 'Published After',
//                                 style: TextStyles.fieldTitle,
//                               ),
//                               const SearchDatePicker(isStartDate: true),
//                             ],
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               'Published Before',
//                               style: TextStyles.fieldTitle,
//                             ),
//                             const SearchDatePicker(isEndDate: true)
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
