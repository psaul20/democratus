// import 'package:democratus/blocs/package_search_bloc.dart';
// import 'package:democratus/widgets/generic/icon_text_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

//NOTE: Unused currently

// class SearchButtonBuilder extends StatelessWidget {
//   const SearchButtonBuilder({super.key, this.onSearch, this.onClear});
//   final void Function()? onSearch;
//   final void Function()? onClear;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PackageSearchBloc, PackageSearchState>(
//         builder: (context, state) {
//       switch (state.status) {
//         case PackageSearchStatus.initial:
//           {
//             return state.isReady
//                 ? IconTextButton(
//                     onPressed: () {
//                       //TODO: Figure out why this isn't working
//                       onSearch?.call();
//                       context.read<PackageSearchBloc>().add(SubmitSearch());
//                     },
//                     text: "Search",
//                     icon: Icons.search_outlined)
//                 : const IconTextButton(
//                     onPressed: null,
//                     text: "Complete Fields",
//                     icon: Icons.search_outlined);
//           }
//         default:
//           {
//             return IconTextButton(
//                 onPressed: () {
//                   onClear?.call();
//                   context.read<PackageSearchBloc>().add(ClearSearch());
//                 },
//                 text: "Clear Search",
//                 icon: Icons.remove_circle_outline_rounded);
//           }
//       }
//     });
//   }
// }