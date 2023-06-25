import 'dart:async';
import 'dart:convert';
import 'package:democratus/models/search_state.dart';
import 'package:democratus/redux/actions.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:democratus/models/collection.dart';

// From shared preferences youtube video from Tensor https://www.youtube.com/watch?v=LCLfQUUwBKs&list=RDCMUCYqCZOwHbnPwyjawKfE21wg&index=1 - to be implemented for shared preferences (persistent state)
// void saveToPrefs(SearchState state) async {

// }

// Future<SearchState> loadFromPrefs() async {}

Future<

void searchStateMiddleware(Store<SearchState> store, action, NextDispatcher next) async {
  if (action is GetCollectionsAction) {
    
  }
}