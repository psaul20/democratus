import 'package:democratus/blocs/package_search_bloc.dart';
import 'package:democratus/models/collection.dart';
import 'package:democratus/theming/text_styles.dart';
import 'package:democratus/theming/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCollectionDropdownBuilder extends StatelessWidget {
  const SearchCollectionDropdownBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageSearchBloc, PackageSearchState>(
        builder: ((context, state) {
      int elevation = 16;
      double containerHeight = 1;
      double padding = 1;
      double iconSize = 30;
      Color loadedColor = DemocScheme.scheme.onBackground;
      Icon loadedIcon = Icon(
        Icons.arrow_drop_down_sharp,
        size: iconSize,
      );
      Color fetchColor = loadedColor;
      Icon? fetchIcon;
      List<Collection> collections = state.collections;

      onChanged(value) {
        Collection selectedCollection = collections.firstWhere(
          (element) => element.collectionName == value,
        );
        //TODO: Create repository to tie these events together

        context
            .read<PackageSearchBloc>()
            .add(SelectCollection(collection: selectedCollection));
      }

      mapFunction(element) {
        return DropdownMenuItem<String>(
            value: element.collectionName,
            child: Text(
              element.collectionName,
              style: TextStyles.inputStyle,
            ));
      }

      if (state.collections.isEmpty) {
        return DropdownButton<String>(
          isExpanded: true,
          icon: fetchIcon,
          elevation: elevation,
          style: TextStyles.inputStyle,
          underline: Container(
            height: containerHeight,
            color: fetchColor,
          ),
          onChanged: null,
          items: const [DropdownMenuItem(child: Text("Fetching Data"))],
        );
      } else {
        Collection? selectedCollection =
            context.read<PackageSearchBloc>().state.selectedCollection;

        return DropdownButton<String>(
          isExpanded: true,
          value: selectedCollection!.collectionName,
          icon: loadedIcon,
          elevation: elevation,
          style: TextStyles.inputStyle,
          underline: Container(
            height: containerHeight,
            color: loadedColor,
            padding: EdgeInsets.only(bottom: padding),
          ),
          onChanged: onChanged,
          items:
              collections.map<DropdownMenuItem<String>>(mapFunction).toList(),
        );
      }
    }));
  }
}
