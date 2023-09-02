import 'package:democratus/blocs/bill_bloc/bill_bloc.dart';
import 'package:democratus/blocs/saved_bills_bloc/saved_bills_bloc.dart';
import 'package:democratus/globals/enums/bloc_states/bill_status.dart';
import 'package:democratus/globals/enums/errors.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/pages/bill_reader_page.dart';
import 'package:democratus/theming/text_styles.dart';
import 'package:democratus/widgets/generic/errors.dart';
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
          if (state.status == BillStatus.failure) {
            return const Card(
                child: ErrorText(
              error: Errors.dataFetchError,
            ));
          } else if (!state.bill.isSaved) {
            checkSaved(state.bill);
          }
          return InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return BlocProvider.value(
                  value: billBloc,
                  child: const BillReaderPage(),
                );
              },
            )),
            child: Card(
              child: ListTile(
                //TODO: Redundant, figure out why it's not inheriting from themedata
                shape: Border.all(style: BorderStyle.none, width: 0),
                title: Text(
                  state.bill.displayTitle,
                  maxLines: 6,
                  style: TextStyles(context).bodyStyle,
                ),
              ),
            ),
          );
        });
  }
}
