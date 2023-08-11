import 'package:democratus/blocs/filtered_packages/filtered_packages_bloc.dart';
import 'package:democratus/blocs/saved_package_bloc.dart';
import 'package:democratus/observers/bloc_observer.dart';
import 'package:democratus/pages/home_page.dart';
import 'package:democratus/theming/theme_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SavedPackagesBloc(),
        ),
        BlocProvider(
          create: (context) => FilteredPackagesBloc(blocId: 'saved'),
        ),
      ],
      child: BlocListener<SavedPackagesBloc, SavedPackagesState>(
        listener: (context, state) {
          context
              .read<FilteredPackagesBloc>()
              .add(InitPackages(state.packages));
        },
        child: MaterialApp(
          title: 'DEMOCRATUS',
          theme: DemocTheme.mainTheme,
          home: const MyHomePage(
            title: 'MY BILLS',
          ),
        ),
      ),
    );
  }
}
