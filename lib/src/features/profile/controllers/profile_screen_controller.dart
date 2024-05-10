import 'package:get/get.dart';
import '../../authentication/models/users_model.dart';
import '../repository/user_repo.dart';

class ProfileController extends GetxController {
  final _userRepo = Get.find<UserRepo>();

  final Rx<UserModel?> userData = Rx<UserModel?>(null);

  @override
  void onInit() {
    // Start listening to user data stream
    _userRepo.userDataStream.listen((user) {
      userData.value = user;
    });
    super.onInit();
  }
}
