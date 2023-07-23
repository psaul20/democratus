import 'package:democratus/blocs/saved_package_bloc.dart';
import 'package:democratus/blocs/package_search_bloc.dart';
import 'package:democratus/observers/bloc_observer.dart';
import 'package:democratus/pages/home_page.dart';
import 'package:democratus/theming/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<PackageSearchBloc>(create: (context) => PackageSearchBloc()),
      BlocProvider<SavedPackagesBloc>(create: (context) => SavedPackagesBloc())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DEMOCRATUS',
      theme: DemocTheme.mainTheme,
      home: const MyHomePage(
        title: 'DEMOCRATUS',
      ),
    );
  }
}
