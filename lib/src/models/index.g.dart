// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Photo$ _$$Photo$FromJson(Map<String, dynamic> json) => _$Photo$(
      urls: Urls.fromJson(json['urls'] as Map<String, dynamic>),
      likedByUser: json['liked_by_user'] as bool,
    );

Map<String, dynamic> _$$Photo$ToJson(_$Photo$ instance) => <String, dynamic>{
      'urls': instance.urls,
      'liked_by_user': instance.likedByUser,
    };

_$Urls$ _$$Urls$FromJson(Map<String, dynamic> json) => _$Urls$(
      raw: json['raw'] as String,
      full: json['full'] as String,
      regular: json['regular'] as String,
      small: json['small'] as String,
      thumb: json['thumb'] as String,
      smallS3: json['small_s3'] as String,
    );

Map<String, dynamic> _$$Urls$ToJson(_$Urls$ instance) => <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
      'thumb': instance.thumb,
      'small_s3': instance.smallS3,
    };

_$AppState$ _$$AppState$FromJson(Map<String, dynamic> json) => _$AppState$(
      images:
          (json['images'] as List<dynamic>?)?.map((dynamic e) => Photo.fromJson(e as Map<String, dynamic>)).toList() ??
              const <Photo>[],
      page: json['page'] as int? ?? 1,
      isLoading: json['isLoading'] as bool? ?? false,
      hasMore: json['hasMore'] as bool? ?? true,
      categorie: json['categorie'] as String? ?? 'dogs',
    );

Map<String, dynamic> _$$AppState$ToJson(_$AppState$ instance) => <String, dynamic>{
      'images': instance.images,
      'page': instance.page,
      'isLoading': instance.isLoading,
      'hasMore': instance.hasMore,
      'categorie': instance.categorie,
    };
