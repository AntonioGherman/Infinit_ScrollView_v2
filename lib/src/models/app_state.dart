part of 'index.dart';

@freezed
class AppState with _$AppState {
  const factory AppState(
      {@Default(<Photo>[]) List<Photo> images,
      @Default(1) int page,
      @Default(false) bool isLoading,
      @Default(true) bool hasMore,
      @Default('dogs') String categorie}) = AppState$;

  factory AppState.fromJson(Map<dynamic, dynamic> json) => _$AppStateFromJson(Map<String, dynamic>.from(json));
}
