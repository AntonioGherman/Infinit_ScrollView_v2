import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

import '../actions/index.dart';
import '../models/index.dart';

AppState reducer(AppState state, dynamic action) {
  if (kDebugMode) {
    print(action);
  }
  return _reducer(state, action);
}

Reducer<AppState> _reducer = combineReducers(<Reducer<AppState>>[
  TypedReducer<AppState, GetImagesStart>(_getImagesStart).call,
  TypedReducer<AppState, GetImagesSuccessful>(_getImagesSuccessful).call,
  TypedReducer<AppState, GetImagesError>(_getImagesError).call
]);

AppState _getImagesSuccessful(AppState state, GetImagesSuccessful actions) {
  return state.copyWith(
      images: <Photo>[if (state.page != 1) ...state.images, ...actions.images],
      isLoading: false,
      hasMore: actions.images.isNotEmpty,
      page: state.page + 1);
}

AppState _getImagesStart(AppState state, GetImagesStart action) {
  return state.copyWith(isLoading: true, categorie: action.search, page: action.page);
}

AppState _getImagesError(AppState state, GetImagesError action) {
  return state.copyWith(isLoading: false);
}
