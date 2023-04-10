import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/data_controller.dart';
import '../../../network/get_connect.dart';
import '../../../routes/app_pages.dart';
import '../../dashboard/model/get_all_user_model.dart';

class SplashController extends GetxController {
  GetStorage storage = GetStorage();
  late DataController dataController;
  late PostsProvider _postsProvider;
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    dataController = Get.find<DataController>();
    _postsProvider = PostsProvider();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    validateToken();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<String> getToken() async {
    return await storage.read("token") ?? "NOT_FOUND";
  }

  validateToken() async {
    String token = await getToken();

    if (token == "NOT_FOUND") {
      Get.offAndToNamed(Routes.LOGIN);
    } else {
      Response res = await _postsProvider.getCall('/user');

      if (res.statusCode != 200) {
        Get.offAllNamed(Routes.LOGIN);
      } else {
        if (res.body.toString() == "you do not have the permission") {
          Get.offAndToNamed(Routes.USER_PASSWORDS ,arguments: storage.read('user'));
        } else {
          List<GetAllUserModel> userModels = [];
          if (res.body.length > 0) {
            res.body.forEach((e) {
              userModels.add(GetAllUserModel.fromJson(e));
            });
            dataController.setAllUserModel(user: userModels);
            await dataController.getUser();
            if (dataController.user.value.admin) {
              Get.offAndToNamed(Routes.DASHBOARD);
            } else {
              Get.offAndToNamed(Routes.USER_PASSWORDS);
            }
          } else {
            dataController.setAllUserModel(user: userModels);
            if (dataController.user.value.admin) {
              Get.offAndToNamed(Routes.DASHBOARD);
            } else {
              Get.offAndToNamed(Routes.USER_PASSWORDS);
            }
          }
        }
      }
    }
  }
}
