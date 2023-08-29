// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';
import 'package:democratus/blocs/bill_search_bloc/bill_search_bloc.dart';
import 'package:democratus/globals/enums/bloc_states/bill_search_status.dart';
import 'package:democratus/globals/enums/errors.dart';
import 'package:democratus/widgets/bill_sliver_list.dart';
import 'package:democratus/widgets/generic/errors.dart';
import 'package:democratus/widgets/search_widgets/bill_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class BillSearchPage extends StatelessWidget {
  const BillSearchPage({super.key, this.billSearchBloc});
  final BillSearchBloc? billSearchBloc;

  @override
  Widget build(BuildContext context) {
    BillSearchBloc billSearchBloc =
        this.billSearchBloc ?? context.read<BillSearchBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BILL SEARCH",
          style: const TextStyle()
              .copyWith(color: Theme.of(context).colorScheme.onSecondary),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: BlocBuilder<BillSearchBloc, BillSearchState>(
          bloc: billSearchBloc,
          builder: (context, state) {
            Widget bodyWidget;
            switch (state.status) {
              case BillSearchStatus.initial:
                {
                  bodyWidget = SliverFillRemaining(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          BillSearchStatus.initial.statusFeedback,
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
              case BillSearchStatus.searching:
                {
                  bodyWidget = const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()));
                }
              case BillSearchStatus.failure:
                {
                  bodyWidget = const SliverFillRemaining(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ErrorText(
                        error: Errors.dataFetchError,
                      ),
                    ],
                  ));
                }
              case BillSearchStatus.success:
                {
                  bodyWidget = BillSliverList(
                    billList: state.searchBills,
                  );
                }
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: CustomScrollView(
                slivers: [
                  const BillSearchBar(),
                  bodyWidget,
                ],
              ),
            );
          }),
    );
  }
}
