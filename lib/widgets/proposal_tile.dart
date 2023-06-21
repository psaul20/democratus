import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../models/package.dart';

class ProposalTile extends StatelessWidget {
  const ProposalTile({super.key, required this.proposal});
  final Package proposal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              flex: 2, child: Text(proposal.shortTitle[0]["title"].toString())),
          Expanded(
            flex: 1,
            child: Text(
              "Last Action\n${DateFormat.yMMMd().format(proposal.lastModified)}",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
