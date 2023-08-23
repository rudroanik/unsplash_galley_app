// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_app_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GalleryAppModel _$GalleryAppModelFromJson(Map<String, dynamic> json) =>
    GalleryAppModel(
      json['id'] as String,
      json['createdAt'] as String?,
      json['urls'] == null
          ? null
          : Urls.fromJson(json['urls'] as Map<String, dynamic>),
      json['likes'] as int,
    );

Map<String, dynamic> _$GalleryAppModelToJson(GalleryAppModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'urls': instance.urls,
      'likes': instance.likes,
    };

Urls _$UrlsFromJson(Map<String, dynamic> json) => Urls(
      json['raw'] as String?,
      json['full'] as String?,
      json['regular'] as String?,
      json['small'] as String?,
      json['thumb'] as String?,
      json['smallS3'] as String?,
    );

Map<String, dynamic> _$UrlsToJson(Urls instance) => <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
      'thumb': instance.thumb,
      'smallS3': instance.smallS3,
    };
