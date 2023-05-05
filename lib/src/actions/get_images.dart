part of 'index.dart';

@freezed
class GetImages with _$GetImages {
  const factory GetImages.start({required String search, required int page}) = GetImagesStart;

  const factory GetImages.successful(List<Photo> images) = GetImagesSuccessful;

  const factory GetImages.error(Object error, StackTrace stackTrace) = GetImagesError;
}
