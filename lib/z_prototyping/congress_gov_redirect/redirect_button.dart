import 'dart:developer';

import 'package:democratus/api/congress_gov_api.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RedirectButton extends StatelessWidget {
  const RedirectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Press'),
      onPressed: () {
        Uri uri = CongressGovApi.getSearchUri();
        log(uri.toString());
        launchUrl(uri);
      },
    );
  }
}
