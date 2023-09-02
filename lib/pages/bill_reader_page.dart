import 'package:democratus/blocs/bill_bloc/bill_bloc.dart';
import 'package:democratus/globals/enums/bloc_states/bill_status.dart';
import 'package:democratus/theming/theme_data.dart';
import 'package:democratus/widgets/home_page_widgets/save_button.dart';
import 'package:democratus/widgets/reader_widgets/bill_display_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillReaderPage extends StatelessWidget {
  const BillReaderPage({super.key});

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
                child: Column(
                  children: [
                    const CircularProgressIndicator(),
                    Text(
                      BillStatus.loading.statusFeedback,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            case BillStatus.success:
              BillDisplay billDisplay = BillDisplay(state.bill, context);
              return CustomScrollView(
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
                  child: Text(
                BillStatus.failure.statusFeedback,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: DemocScheme.scheme.error,
                    ),
                textAlign: TextAlign.center,
              ));
          }
        },
      ),
      floatingActionButton: const SaveButton(),
    );
  }
}
