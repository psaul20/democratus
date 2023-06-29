import 'package:democratus/main.dart';
import 'package:democratus/pages/search_packages_page.dart';
import 'package:democratus/widgets/package_widgets.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: PackageListView(packages: ref.watch(savedPackagesProvider)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const ProviderScope(child: SearchPackagesPage()),
              ));
        },
        tooltip: 'Add Proposal',
        child: const Icon(Icons.add),
      ),
    );
  }
}
