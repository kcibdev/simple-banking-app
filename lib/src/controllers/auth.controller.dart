import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplebankingapp/src/models/user.model.dart';
import "package:get/get.dart";
import "package:http/http.dart" as http;
import 'package:simplebankingapp/src/services/api/api_service.dart';
import 'package:simplebankingapp/src/utils/constant.dart';
import 'package:simplebankingapp/src/utils/custom_snackbar.dart';
import 'package:simplebankingapp/src/views/pages/Auth/auth_screen.dart';
import 'package:simplebankingapp/src/views/pages/Dashboard/dashboard.dart';

class AuthController extends GetxController {
  ApiService apiService = Get.put(ApiService());
  SharedPreferences? prefs;
  var userModel = UserModel().obs;
  var isLoading = false.obs;

  void login(String phoneNumber, String password) async {
    isLoading(true);
    http.Response loginResponse = await apiService.postData(
        LOGIN_URL, {"phoneNumber": phoneNumber, "password": password});
    Map responseBody = json.decode(loginResponse.body);
    if (loginResponse.statusCode == 200) {
      await getUserInfo(phoneNumber);
      Get.offAll(() => const DashboardScreen());
    } else {
      customSnackBar(responseBody["message"]);
    }
    isLoading(false);
  }

  void signup(String phoneNumber, String password) async {
    isLoading(true);

    http.Response loginResponse = await apiService.postData(
        SIGNUP_URL, {"phoneNumber": phoneNumber, "password": password});

    Map responseBody = json.decode(loginResponse.body);

    if (loginResponse.statusCode == 200) {
      await getUserInfo(phoneNumber);
      Get.offAll(() => const DashboardScreen());
    } else {
      customSnackBar(responseBody["message"]);
    }
    isLoading(false);
  }

  Future getUserInfo(String phoneNumber) async {
    prefs = await SharedPreferences.getInstance();

    http.Response userResponse = await apiService.getData(GET_USERS_URL);

    Map responseBody = json.decode(userResponse.body);

    if (userResponse.statusCode == 200) {
      var balance = 0;
      for (var user in responseBody["data"]) {
        if (user["phoneNumber"] == phoneNumber) {
          balance = user["balance"] ?? 0;
        }
      }

      prefs?.setString(USER_NUMBER, phoneNumber);
      userModel.value = UserModel.fromJson({
        "phoneNumber": phoneNumber,
        "balance": balance,
      });
    } else {
      prefs!.remove(USER_NUMBER);
      Get.offAll(() => const AuthScreen());
      customSnackBar(responseBody["message"]);
    }
  }

  void logout() async {
    prefs = await SharedPreferences.getInstance();
    prefs?.remove(USER_NUMBER);
    Get.offAll(() => const AuthScreen());
  }
}
