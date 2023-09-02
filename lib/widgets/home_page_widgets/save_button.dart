import 'package:democratus/blocs/bill_bloc/bill_bloc.dart';
import 'package:democratus/blocs/saved_bills_bloc/saved_bills_bloc.dart';
import 'package:democratus/models/bill_models/bill.dart';

import 'package:democratus/theming/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    Bill bill = BlocProvider.of<BillBloc>(context).state.bill;
    saveTap(Bill bill) {
      //TODO: Add repository to tie these events together
      BlocProvider.of<SavedBillsBloc>(context).add(ToggleSave(bill: bill));
    }

    bool checkSaved(bill) {
      List<String> billIds = [
        for (final bill in BlocProvider.of<SavedBillsBloc>(context).state.bills)
          bill.billId,
      ];
      return billIds.contains(bill.billId);
    }

    return BlocBuilder<SavedBillsBloc, SavedBillsState>(
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: () => saveTap(bill),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(checkSaved(bill) ? Icons.favorite : Icons.favorite_border),
              Text(
                checkSaved(bill) ? "Saved" : "Save",
                textAlign: TextAlign.center,
                style: TextStyles(context).bodyStyle,
              )
            ],
          ),
        );
      },
    );
  }
}
