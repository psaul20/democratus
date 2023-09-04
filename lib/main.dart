import 'package:democratus/api/bills_api_provider.dart';
import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/blocs/saved_bills_bloc/saved_bills_bloc.dart';
import 'package:democratus/observers/bloc_observer.dart';
import 'package:democratus/pages/home_page.dart';
import 'package:democratus/theming/theme_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

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
    return Provider<BillApiProvider>(
      create: (_) => GovinfoApi(client: Client()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SavedBillsBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'DEMOCRATUS',
          theme: DemocTheme.mainTheme,
          home: const HomePage(
            title: 'MY BILLS',
          ),
        ),
      ),
    );
  }
}
