import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import '../actions/index.dart';
import '../data/api_call.dart';
import '../models/index.dart';

class AppEpics implements EpicClass<AppState> {
  AppEpics(this._apiCall);
  final ApiCall _apiCall;

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) {
    return combineEpics(<Epic<AppState>>[TypedEpic<AppState, GetImagesStart>(_getImagesStart).call])(actions, store);
  }

  Stream<dynamic> _getImagesStart(Stream<GetImagesStart> actions, EpicStore<AppState> store) {
    return actions
        .asyncMap((GetImagesStart action) => _apiCall.apiCall(search: action.search, page: action.page))
        .map((List<Photo> images) => GetImages.successful(images))
        .onErrorReturnWith((Object error, StackTrace stacktrace) => GetImages.error(error, stacktrace));
  }
}
