import 'package:democratus/blocs/filtered_packages/filtered_packages_bloc.dart';
import 'package:democratus/blocs/saved_package_bloc.dart';
import 'package:democratus/blocs/package_search_bloc.dart';
import 'package:democratus/pages/search_packages_page.dart';
import 'package:democratus/widgets/home_page_widgets/home_page_bar.dart';
import 'package:democratus/widgets/package_widgets/package_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocBuilder<SavedPackagesBloc, SavedPackagesState>(
        builder: (context, state) {
          return BlocProvider(
              create: (context) =>
                  FilteredPackagesBloc()..add(InitPackages(state.packages)),
              // Added to ensure that base packages are updated every time saved packages are updated
              child: BlocListener<SavedPackagesBloc, SavedPackagesState>(
                listener: (context, state) {
                  context
                      .read<FilteredPackagesBloc>()
                      .add(InitPackages(state.packages));
                },
                child: const CustomScrollView(
                  slivers: [
                    HomePageBar(),
                    FilterPackageSliverList(),
                  ],
                ),
              ));
        },
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
                  BlocProvider(create: (_) => FilteredPackagesBloc())
                ], child: const SearchPackagesPage()),
              ));
        },
        tooltip: 'Add Package',
        child: const Icon(Icons.add),
      ),
    );
  }
}
