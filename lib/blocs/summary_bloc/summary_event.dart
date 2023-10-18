part of 'summary_bloc.dart';

@immutable
sealed class SummaryEvent {}

class GetSummary extends SummaryEvent {
  final String billId;

  GetSummary(this.billId);
}
