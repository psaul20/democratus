import 'package:democratus/blocs/bill_bloc/bill_bloc.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/widgets/bill_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class BillSliverList extends StatelessWidget {
  final List<Bill> billList;
  final Client client;
  const BillSliverList({
    super.key,
    required this.billList,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      itemBuilder: (context, index, animation) => BlocProvider<BillBloc>(
          key: ValueKey(billList[index].billId),
          create: (_) {
            return BillBloc(bill: billList[index], client: client);
          },
          child: const BillTile()),
      initialItemCount: billList.length,
    );
  }
}
