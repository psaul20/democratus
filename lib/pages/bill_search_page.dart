// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import
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

class BillSearchPage extends StatefulWidget {
  const BillSearchPage({super.key});

  @override
  State<BillSearchPage> createState() => _BillSearchPageState();
}

class _BillSearchPageState extends State<BillSearchPage> {
  final ScrollController _scrollController = ScrollController();
  double scrollOffset = 0;

  void _onScrollEvent() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<BillSearchBloc>().add(ScrollSearchOffset());
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_onScrollEvent);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BillSearchBloc billSearchBloc = context.read<BillSearchBloc>();
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
            // _scrollController.jumpTo(scrollOffset);
            Widget feedBackWidget;
            switch (state.status) {
              case BillSearchStatus.initial:
                {
                  feedBackWidget = SliverFillRemaining(
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
                  feedBackWidget = const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()));
                }
              case BillSearchStatus.failure:
                {
                  feedBackWidget = const SliverFillRemaining(
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
                  feedBackWidget =
                      SliverList.list(children: const [SizedBox.shrink()]);
                }
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  const BillSearchBar(),
                  SliverSafeArea(
                    sliver: BillSliverList(
                      billList: state.searchBills,
                    ),
                  ),
                  feedBackWidget,
                ],
              ),
            );
          }),
    );
  }
}
