import 'package:democratus/blocs/bill_bloc/bill_bloc.dart';
import 'package:democratus/globals/enums/bloc_states/bill_status.dart';
import 'package:democratus/widgets/generic/feedback_widgets.dart';
import 'package:democratus/widgets/home_page_widgets/save_button.dart';
import 'package:democratus/widgets/reader_widgets/bill_display_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillReaderPage extends StatefulWidget {
  const BillReaderPage({super.key});

  @override
  State<BillReaderPage> createState() => _BillReaderPageState();
}

class _BillReaderPageState extends State<BillReaderPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true; // To track FAB visibility

  void _toggleVisibility() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        _isVisible = false;
      });
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _isVisible = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_toggleVisibility);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_toggleVisibility);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BillBloc billBloc = context.read<BillBloc>();
    billBloc.add(GetBillDetails());
    return Scaffold(
      body: BlocBuilder<BillBloc, BillState>(
        buildWhen: (previous, current) => previous.status != current.status,
        bloc: billBloc,
        builder: (context, state) {
          switch (state.status) {
            case BillStatus.loading:
              return Center(
                child: LoadingFeedback(
                    loadingTxt: BillStatus.loading.statusFeedback),
              );
            case BillStatus.success:
              BillDisplay billDisplay = BillDisplay(state.bill, context);
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      title: billDisplay.displayNumber()),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverSafeArea(
                      top: false,
                      sliver: SliverList.list(children: [
                        billDisplay.displayTitle(),
                        billDisplay.displayBackgroundInfo(),
                        billDisplay.displaySummaries(),
                        billDisplay.displayActions(),
                        billDisplay.displaySponsors(),
                      ]),
                    ),
                  )
                ],
              );
            case BillStatus.failure:
              return Center(
                  child: ErrorFeedback(
                      errorMessage: BillStatus.failure.statusFeedback,
                      onRetry: () {
                        billBloc.add(GetBillDetails());
                      }));
          }
        },
      ),
      floatingActionButton: _isVisible
          ? BlocBuilder<BillBloc, BillState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                switch (state.status) {
                  case BillStatus.success:
                    return const SaveButton();

                  default:
                    return const SizedBox.shrink();
                }
              },
            )
          : null,
    );
  }
}
