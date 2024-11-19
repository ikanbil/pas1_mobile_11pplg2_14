  import 'package:get/get.dart';
import 'login_model.dart';
import 'login_service.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var loginStatus = "".obs;
  var token = "".obs;

  final LoginService _loginService = LoginService();

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    try {
      final LoginModel response = await _loginService.login(username, password);
      if (response.status) {
        loginStatus.value = response.message;
        token.value = response.token;
      } else {
        loginStatus.value = response.message;
      }
    } catch (e) {
      loginStatus.value = "Error: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }
}
