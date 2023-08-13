import 'package:democratus/api/congress_gov_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Testing URL launch', () async {
    Uri uri = CongressGovApi.getSearchUri();
    expect(await canLaunchUrl(uri), true);
  });
}
