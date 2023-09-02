// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:core';
// import 'package:democratus/archive/bloc/filtered_packages/filtered_packages_bloc.dart';
// import 'package:democratus/archive/bloc/package_search_bloc.dart';
// import 'package:democratus/archive/widgets/search_filter_widgets/package_search_bar.dart';
// import 'package:democratus/globals/enums/errors.dart';
// import 'package:democratus/widgets/generic/errors.dart';
// import 'package:democratus/widgets/generic/fetch_circle.dart';
// import 'package:democratus/archive/widgets/package_widgets/package_sliver_list.dart';
// import 'package:democratus/archive/widgets/search_filter_widgets/search_filter_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SearchPackagesPage extends StatelessWidget {
//   const SearchPackagesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //TODO: Optimize with Buildwhens
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "BILL SEARCH",
//           style: const TextStyle()
//               .copyWith(color: Theme.of(context).colorScheme.onSecondary),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 showDialog(
//                     context: context,
//                     useRootNavigator: false,
//                     builder: (ctx) => MultiBlocProvider(
//                           providers: [
//                             BlocProvider.value(
//                               value:
//                                   BlocProvider.of<PackageSearchBloc>(context),
//                             ),
//                             BlocProvider.value(
//                               value: BlocProvider.of<FilteredPackagesBloc>(
//                                   context),
//                             ),
//                           ],
//                           child: const SearchFilterDialog(),
//                         ));
//               },
//               icon: Icon(
//                 Icons.filter_list,
//                 color: Theme.of(context).colorScheme.onSecondary,
//               )),
//         ],
//         backgroundColor: Theme.of(context).colorScheme.secondary,
//       ),
//       body: BlocConsumer<PackageSearchBloc, PackageSearchState>(
//           buildWhen: (previous, current) => previous.status != current.status,
//           listener: (context, state) {
//             context.read<FilteredPackagesBloc>().add(InitPackages(
//                 context.read<PackageSearchBloc>().state.searchPackages));
//           },
//           builder: (context, state) {
//             switch (state.status) {
//               case PackageSearchStatus.searching:
//                 {
//                   return const Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       FetchCircle(),
//                     ],
//                   );
//                 }
//               case PackageSearchStatus.failure:
//                 {
//                   return const Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       ErrorText(error: Errors.dataFetchError),
//                     ],
//                   );
//                 }
//               default:
//                 {
//                   return const CustomScrollView(
//                     slivers: [
//                       PackageSearchBar(),
//                       FilterPackageSliverList(),
//                     ],
//                   );
//                 }
//             }
//           }),
//     );
//   }
// }
