import 'dart:collection';

import 'package:democratus/models/proposal.dart';
import 'package:flutter/material.dart';

// Defined based on https://docs.flutter.dev/data-and-backend/state-mgmt/simple
class ProposalsModel extends ChangeNotifier {
  final List<Proposal> _proposals = [];
  UnmodifiableListView<Proposal> get proposals =>
      UnmodifiableListView(_proposals);

  int get numProposals => _proposals.length;
  Proposal getProposalByIndex(int index) => _proposals[index];

  void add(Proposal proposal) {
    _proposals.add(proposal);
    notifyListeners();
  }

  void removeAll() {
    _proposals.clear();
    notifyListeners();
  }

  void remove(Proposal proposal) {
    _proposals.remove(proposal);
    notifyListeners();
  }
}
