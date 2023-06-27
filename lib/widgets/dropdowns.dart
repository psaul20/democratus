import 'package:democratus/styles/text_styles.dart';
import 'package:democratus/styles/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncDropDownBuilder extends ConsumerWidget {
  const AsyncDropDownBuilder(
      {required this.provider,
      required this.dropDownValue,
      required this.onChanged,
      required this.mapFunction,
      super.key});
  final FutureProvider<List<dynamic>> provider;
  final String? dropDownValue;
  final void Function(String?) onChanged;
  final DropdownMenuItem<String> Function(dynamic) mapFunction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int elevation = 16;
    double containerHeight = 2;
    Color loadedColor = DemocTheme.mainTheme.colorScheme.onBackground;
    Icon loadedIcon = const Icon(Icons.arrow_drop_down_circle_outlined);
    Color fetchColor = loadedColor;
    Icon fetchIcon = const Icon(Icons.download);
    Color errorColor = DemocTheme.mainTheme.colorScheme.error;
    Icon errorIcon = const Icon(Icons.cancel_outlined);
    AsyncValue<List<dynamic>> listItems = ref.watch(provider);

    return listItems.when(
      data: ((listItems) {
        return DropdownButton<String>(
          isExpanded: true,
          value: dropDownValue,
          icon: loadedIcon,
          elevation: elevation,
          style: TextStyles.dropDownStyle,
          underline: Container(
            height: containerHeight,
            color: loadedColor,
          ),
          onChanged: onChanged,
          items: listItems.map<DropdownMenuItem<String>>(mapFunction).toList(),
        );
      }),
      error: (Object error, StackTrace stackTrace) {
        return DropdownButton<String>(
          isExpanded: true,
          value: dropDownValue,
          icon: errorIcon,
          elevation: elevation,
          style: TextStyles.dropDownStyle,
          underline: Container(
            height: containerHeight,
            color: errorColor,
          ),
          onChanged: null,
          items: const [DropdownMenuItem(child: Text("Error Fetching Data"))],
        );
      },
      loading: () {
        return DropdownButton<String>(
          isExpanded: true,
          value: dropDownValue,
          icon: fetchIcon,
          elevation: elevation,
          style: TextStyles.dropDownStyle,
          underline: Container(
            height: containerHeight,
            color: fetchColor,
          ),
          onChanged: null,
          items: const [DropdownMenuItem(child: Text("Fetching Data"))],
        );
      },
    );
  }
}
