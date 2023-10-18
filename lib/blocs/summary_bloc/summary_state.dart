// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'summary_bloc.dart';

enum SummaryStatus { initial, loading, success, failure }

class SummaryState extends Equatable {
  const SummaryState({
    this.status = SummaryStatus.initial,
    this.summary,
    this.isStored = false,
    this.except,
  });

  final SummaryStatus status;
  final GenAiSummary? summary;
  final bool isStored;
  final Exception? except;

  SummaryState copyWith({
    SummaryStatus? status,
    GenAiSummary? summary,
    bool? isStored,
    Exception? except,
  }) {
    return SummaryState(
      status: status ?? this.status,
      summary: summary ?? this.summary,
      isStored: isStored ?? this.isStored,
      except: except ?? this.except,
    );
  }

  @override
  List<Object?> get props => [status, summary, isStored, except];
}
