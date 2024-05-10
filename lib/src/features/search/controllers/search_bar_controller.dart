import 'package:get/get.dart';
import '../../authentication/models/users_model.dart';
import '../../profile/repository/user_repo.dart';

class SearchBarController extends GetxController {
  static SearchBarController get to => Get.find();

  final _userRepo = UserRepo.instance;

  RxList<UserModel> searchResults = <UserModel>[].obs;

  void searchUsers(String query, String currentUserEmail) async {
    try {
      if (query.isEmpty) {
        searchResults.clear();
      } else {
        final results = await _userRepo.searchUsers(query, currentUserEmail);
        searchResults.assignAll(results);

        // Printing retrieved user data in a detailed manner
        for (var user in searchResults) {
          print(user.toString()); // Utilize the UserModel's toString method
        }
      }
    } catch (error) {
      print("Error searching users: $error");
    }
  }

  void clearSearchResults() {
    searchResults.clear();
  }
}
