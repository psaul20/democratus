import 'package:democratus/models/package.dart';
import 'package:democratus/pages/search_packages_page.dart';
import 'package:democratus/providers/package_providers.dart';
import 'package:democratus/widgets/package_widgets/package_list_view.dart';
import 'package:democratus/widgets/package_widgets/package_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<Package> savedPackages = ref.watch(savedPackagesProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // TODO: Fix saved button showing correctly on homepage
      body: CustomScrollView(slivers: [
        PackageSliverList(
          packages: savedPackages,
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              //TODO: Convert to singleton for persistence
              MaterialPageRoute(
                builder: (context) => const SearchPackagesPage(),
              ));
        },
        tooltip: 'Add Package',
        child: const Icon(Icons.add),
      ),
    );
  }
}
