// This is probably not the right implementation of reducers, need better parameter enforcement at the action level
import 'package:democratus/models/collection.dart';
import 'package:democratus/models/search_state.dart';
import 'package:democratus/redux/actions.dart';

SearchState searchStateReducer(SearchState state, action) {
  return SearchState(
      collections: collectionsReducer(state.collections, action),
      queryParams: queryParamsReducer(state.queryParams, action));
}

List<Collection> collectionsReducer(List<Collection> state, action) {
  if (action is GetCollectionsAction) {
    return action.collections;
  }
  return state;
}

Map<String, String> queryParamsReducer(Map<String, String> state, action) {
  if (action is CollectionSelectionAction) {
    return <String, String>{}
      ..addAll(state)
      ..[action.paramsKey] = action.collection.collectionCode;
  }
  return state;
}
