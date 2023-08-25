import 'package:democratus/blocs/filtered_packages/filtered_packages_bloc.dart';
import 'package:democratus/blocs/saved_package_bloc.dart';
import 'package:democratus/blocs/package_search_bloc.dart';
import 'package:democratus/pages/search_packages_page.dart';
import 'package:democratus/widgets/home_page_widgets/home_page_bar.dart';
import 'package:democratus/widgets/package_widgets/package_sliver_list.dart';
import 'package:democratus/widgets/search_widgets/search_filter_widgets/search_filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO: Fix no added packages view + searching view

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    context
        .read<FilteredPackagesBloc>()
        .add(InitPackages(context.read<SavedPackagesBloc>().state.packages));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    useRootNavigator: false,
                    builder: (ctx) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: BlocProvider.of<FilteredPackagesBloc>(
                                  context),
                            ),
                          ],
                          child: const SearchFilterDialog(),
                        ));
              },
              icon: Icon(
                Icons.filter_list,
                color: Theme.of(context).colorScheme.onBackground,
              )),
        ],
      ),
      body: const CustomScrollView(
        slivers: [
          HomePageBar(),
          FilterPackageSliverList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                      create: (_) => PackageSearchBloc()
                        ..add(SubmitSearch())
                        ..add(GetCollections())),
                  BlocProvider(
                      create: (_) => FilteredPackagesBloc(blocId: 'search'))
                ], child: const SearchPackagesPage()),
              ));
        },
        tooltip: 'Add Package',
        child: const Icon(Icons.add),
      ),
    );
  }
}
