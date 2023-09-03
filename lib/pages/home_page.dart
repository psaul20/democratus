import 'package:democratus/blocs/bill_search_bloc/bill_search_bloc.dart';
import 'package:democratus/blocs/client_cubit/client_cubit.dart';
import 'package:democratus/blocs/saved_bills_bloc/saved_bills_bloc.dart';
import 'package:democratus/globals/enums/bloc_states/saved_bills_status.dart';
import 'package:democratus/pages/bill_search_page.dart';
import 'package:democratus/widgets/bill_sliver_list.dart';
import 'package:democratus/widgets/home_page_widgets/home_page_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

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
    SavedBillsBloc savedBillsBloc = BlocProvider.of<SavedBillsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocBuilder<SavedBillsBloc, SavedBillsState>(
        bloc: savedBillsBloc,
        builder: (context, state) {
          List<Widget> sliverList = [];
          switch (state.status) {
            case SavedBillsStatus.initial:
              sliverList = [
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      SavedBillsStatus.initial.statusFeedback,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ];
              break;
            case SavedBillsStatus.success:
              sliverList = [
                // const HomePageBar(),
                BillSliverList(billList: state.bills),
              ];
              break;
            case SavedBillsStatus.failure:
              sliverList = [
                const HomePageBar(),
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      SavedBillsStatus.failure.statusFeedback,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ];
              break;
          }
          return CustomScrollView(
            slivers: sliverList,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Client client = BlocProvider.of<ClientCubit>(context).state.client;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => BillSearchBloc(client: client),
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
