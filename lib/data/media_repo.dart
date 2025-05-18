import 'package:cloudinary_sdk/cloudinary_sdk.dart';

class MediaRepository {
  late Cloudinary cloudinary;
  MediaRepository() {
     cloudinary = Cloudinary.full(
      apiKey: "322937111183293",
      apiSecret: "fsxlzesF4I2UyVSmbk1XI52AQpA",
      cloudName: "dxbnoeznk",
    );
  }
  Future<CloudinaryResponse> uploadImage(String path) {
    return cloudinary.uploadResource(CloudinaryUploadResource(
      filePath: path,
      resourceType: CloudinaryResourceType.image
    ),

    );

  }
}
