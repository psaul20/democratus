import 'dart:developer';

import 'package:http/http.dart';

class ApiUsage {
  static logUsage(Response response) {
    String? remaining = response.headers['x-ratelimit-remaining'];
    String? limit = response.headers['x-ratelimit-limit'];
    log("Responses Remaining: $remaining/$limit remaining");
  }
}
