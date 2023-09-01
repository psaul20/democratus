// ignore_for_file: unused_import

import 'package:democratus/blocs/bill_bloc/bill_bloc.dart';
import 'package:democratus/blocs/client_cubit/client_cubit.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/widgets/bill_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class BillSliverList extends StatelessWidget {
  final List<Bill> billList;
  // Injection for testing
  const BillSliverList({super.key, required this.billList});

  @override
  Widget build(BuildContext context) {
    Client client = BlocProvider.of<ClientCubit>(context).state.client;
    return SliverList.builder(
      itemBuilder: (context, index) => BlocProvider<BillBloc>(
          key: ValueKey(billList[index].billId),
          create: (_) {
            return BillBloc(bill: billList[index], client: client);
          },
          child: const BillTile()),
      itemCount: billList.length,
    );
  }
}
