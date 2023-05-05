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
  return state.copyWith(images: <Photo>[...state.images, ...actions.images], isLoading: false);
}

AppState _getImagesStart(AppState state, GetImagesStart action) {
  return state.copyWith(isLoading: true);
}

AppState _getImagesError(AppState state, GetImagesError action) {
  return state.copyWith(isLoading: false);
}
