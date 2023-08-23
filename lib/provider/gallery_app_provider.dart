import 'package:gallery_app/base/base_connect.dart';
import 'package:gallery_app/base/resource.dart';
import 'package:gallery_app/model/gallery_app_model.dart';

class GalleryAppProvider extends BaseConnect {
  Future<Resource<List<GalleryAppModel>>> getPhotoList(
      Map<String, String> queryParams) async {
    final response = await get("photos", query: queryParams);
    if (response.statusCode == 200) {
      return Resource(
          model: GalleryAppModel.listFromJson(response.body),
          message: "Success",
          status: ResourceStatus.SUCCESS,
          code: 200);
    } else {
      return Resource(
          model: null,
          message: "Faild",
          status: ResourceStatus.FAILED,
          code: 400);
    }
  }
}
