import 'package:bloc/bloc.dart';
import 'package:democratus/db/firebase_realtime_database.dart';
import 'package:democratus/models/bill_models/gen_ai_summary.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'summary_event.dart';
part 'summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  FirebaseRealtimeDatabase db;
  SummaryBloc({required this.db}) : super(const SummaryState()) {
    on<GetSummary>(_onGetSummary);
  }

  Future<void> _onGetSummary(
      GetSummary event, Emitter<SummaryState> emit) async {
    try {
      emit(state.copyWith(status: SummaryStatus.loading));
      final GenAiSummary? summary = await _fetchStorageSummary(event.billId);
      if (summary == null) {
        //TODO: Add logic to fetch summary from API
      await db.setSummaryAt(summary!.billId, summary.toJson());
      emit(state.copyWith(
        isStored: true,
      ));
      }
      emit(state.copyWith(
        summary: summary,
        status: SummaryStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: SummaryStatus.failure, except: e as Exception));
    }
  }

  Future<GenAiSummary?> _fetchStorageSummary(String billId) async {
    try {
          final String summaryJson =
        await db.getSummaryAt(billId);
    return summaryJson.isNotEmpty ? GenAiSummary.fromJson(summaryJson) : null;
    } catch (e) {
      throw Exception('Failed to retrieve summary from db');
    }
  }
}
