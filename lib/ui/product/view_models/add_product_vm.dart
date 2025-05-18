import 'package:image_picker/image_picker.dart';
import 'package:tour_app/data/AuthRepository.dart';
import 'package:get/get.dart';
import 'package:tour_app/data/media_repo.dart';
import 'package:tour_app/data/product_repository.dart';
import 'package:tour_app/model/Product.dart';

class AddProductViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  ProductsRepository productsRepository = Get.find();
  MediaRepository mediaRepository = Get.find();
  var isSaving = false.obs;
  Rxn<XFile> image = Rxn<XFile>();

  Future<void> addProduct(String name, String price, Product? product) async {
    if (name.isEmpty) {
      Get.snackbar("Error", "Enter proper Name");
      return;
    }
    if (price.isEmpty) {
      Get.snackbar("Error", "Enter proper Price");
      return;
    }
    isSaving.value = true;
    if (product == null) {
      Product product = Product(
        "",
        authRepository.getLoggedInUser()?.uid ?? "",
        name,
        int.parse(price),
      );
     await uploadImage(product);

      try {
        await productsRepository.addProduct(product);
        Get.back(result: true);
      } catch (e) {
        Get.snackbar("Error", "An error occurred ${e.toString()}");
      }
    } else {
      product.name = name;
      product.price = int.parse(price);
      try {
        await uploadImage(product);
        await productsRepository.updateProduct(product);
        Get.back(result: true);
      } catch (e) {
        Get.snackbar("Error", "An error occurred ${e.toString()}");
      }
    }
    isSaving.value = false;
  }
  Future<void> uploadImage(Product product) async {
    if (image.value != null) {
      var imageResult = await mediaRepository.uploadImage(image.value!.path);
      if (imageResult.isSuccessful) {
        product.image = imageResult.url;
      } else {
        Get.snackbar(
          "Error uploading image",
          imageResult.error ?? "Could not upload image due to error",
        );
      }
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    image.value = await picker.pickImage(source: ImageSource.gallery);
  }
}
