import 'package:democratus/blocs/bill_search_bloc/bill_search_bloc.dart';
import 'package:democratus/pages/bill_search_page.dart';
import 'package:democratus/widgets/home_page_widgets/home_page_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO: Fix no added packages view + searching view

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const CustomScrollView(
        slivers: [
          HomePageBar(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => BillSearchBloc(),
                child: const BillSearchPage(),
              ),
            ),
          );
        },
        tooltip: 'Add Bill',
        child: const Icon(Icons.add),
      ),
    );
  }
}
