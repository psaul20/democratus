import 'package:democratus/blocs/bill_bloc/bill_bloc.dart';
import 'package:democratus/blocs/saved_bills_bloc/saved_bills_bloc.dart';
import 'package:democratus/globals/enums/bloc_states/bill_status.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/pages/bill_reader_page.dart';
import 'package:democratus/theming/text_styles.dart';
import 'package:democratus/widgets/generic/feedback_widgets.dart';
import 'package:democratus/widgets/reader_widgets/bill_display_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillTile extends StatelessWidget {
  const BillTile({super.key});

  @override
  Widget build(BuildContext context) {
    BillBloc billBloc = context.read<BillBloc>();
    SavedBillsBloc savedBillsBloc = context.read<SavedBillsBloc>();

    List<String> savedIds = [
      for (final bill in savedBillsBloc.state.bills) bill.billId
    ];
    checkSaved(Bill bill) {
      if (savedIds.contains(bill.billId)) {
        billBloc.add(UpdateBill(bill.copyWith(isSaved: true)));
      }
    }

    return BlocBuilder<BillBloc, BillState>(
        bloc: billBloc,
        builder: (context, state) {
          BillDisplay billDisplay = BillDisplay(state.bill, context);
          if (state.status == BillStatus.failure) {
            return Card(
                child: ErrorFeedback(
              errorMessage: BillStatus.failure.statusFeedback,
            ));
          } else if (!state.bill.isSaved) {
            checkSaved(state.bill);
          }
          return Card(
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return BlocProvider.value(
                    value: billBloc,
                    child: const BillReaderPage(),
                  );
                },
              )),
              child: ListTile(
                //TODO: Redundant, figure out why it's not inheriting from themedata
                shape: Border.all(style: BorderStyle.none, width: 0),
                title: Text(
                  state.bill.displayTitle,
                  maxLines: 6,
                  style: TextStyles(context).bodyStyle.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: billDisplay.displayBackgroundInfo(withDivider: false),
                ),
              ),
            ),
          );
        });
  }
}
