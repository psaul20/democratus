import 'package:democratus/blocs/saved_package_bloc.dart';
import 'package:democratus/blocs/package_search_bloc.dart';
import 'package:democratus/models/package.dart';
import 'package:democratus/pages/search_packages_page.dart';
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
      body: CustomScrollView(slivers: [
        BlocBuilder<SavedPackagesBloc, SavedPackagesState>(
            builder: (context, state) =>
                PackageSliverList(packages: state.packages)),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider<PackageSearchBloc>(
                    create: (_) => PackageSearchBloc()..add(GetCollections()),
                    child: const SearchPackagesPage()),
              ));
        },
        tooltip: 'Add Package',
        child: const Icon(Icons.add),
      ),
    );
  }
}
