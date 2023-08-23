import 'package:json_annotation/json_annotation.dart';
part 'gallery_app_model.g.dart';

@JsonSerializable()
class GalleryAppModel{
  String id;
  String? createdAt;
  Urls? urls;
  int likes;

  GalleryAppModel(this.id, this.createdAt, this.urls,this.likes);

  factory GalleryAppModel.fromJson(Map<String, dynamic> json) =>
      _$GalleryAppModelFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryAppModelToJson(this);

  static List<GalleryAppModel> listFromJson(list) =>
      List<GalleryAppModel>.from(list.map((x) => GalleryAppModel.fromJson(x)))
          .toList();
}
@JsonSerializable()
class Urls{
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  Urls(this.raw, this.full, this.regular, this.small, this.thumb, this.smallS3);

  factory Urls.fromJson(Map<String, dynamic> json) =>
      _$UrlsFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsToJson(this);
}
