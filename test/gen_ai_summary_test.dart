// Test gen ai summary
import 'package:flutter_test/flutter_test.dart';
import 'package:democratus/models/bill_models/gen_ai_summary.dart';

void main() {
  group('Gen AI Summary tests from example', () {
    test('Example Summary has expected structure', () {
      GenAiSummary summary = GenAiSummary.getExampleSummary();
      expect(summary.summaryPoints.length, 4);
      expect(summary.summaryOutcomes.length, 2);
      expect(summary.summaryDeviants.length, 1);
      expect(summary.title.contains('ACA'), true);
    });
  });
}
