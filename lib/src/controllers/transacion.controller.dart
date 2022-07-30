import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplebankingapp/src/controllers/auth.controller.dart';
import 'package:simplebankingapp/src/models/transaction.model.dart';
import 'package:simplebankingapp/src/services/api/api_service.dart';
import 'package:simplebankingapp/src/utils/constant.dart';
import 'package:simplebankingapp/src/utils/custom_snackbar.dart';

class TransactionController extends GetxController {
  ApiService apiService = Get.put(ApiService());
  AuthController authController = Get.put(AuthController());
  SharedPreferences? prefs;

  RxList<TransactionModel> transactionModel =
      List.filled(1, TransactionModel(), growable: true).obs;
  var isGetTransactionLoading = false.obs;
  var isTransferLoading = false.obs;
  var isWithdrawLoading = false.obs;

  void getTransactions() async {
    isGetTransactionLoading(true);
    prefs = await SharedPreferences.getInstance();
    List<TransactionModel> trs = [];
    String? phoneNumber = prefs!.getString(USER_NUMBER);
    http.Response transactionsResponse =
        await apiService.getData(TRANSACTION_URL);
    Map responseBody = json.decode(transactionsResponse.body);
    if (transactionsResponse.statusCode == 200) {
      responseBody["data"].forEach((transaction) {
        if (transaction["phoneNumber"] == phoneNumber) {
          trs.add(TransactionModel.fromJson(transaction));
        }
      });
      transactionModel.assignAll(trs);
    }
    isGetTransactionLoading(false);
  }

  Future transferMoney(String amount, String phoneNumber) async {
    isTransferLoading(true);
    prefs = await SharedPreferences.getInstance();
    http.Response transferResponse =
        await apiService.postData(SEND_TRANSACTION_URL, {
      "amount": amount,
      "phoneNumber": phoneNumber,
    });
    Map responseBody = json.decode(transferResponse.body);
    if (transferResponse.statusCode == 200) {
      await authController.getUserInfo(prefs!.getString(USER_NUMBER)!);
      getTransactions();
      Get.back();
      customSnackBar("Transfer Successful", isError: false);
    } else {
      customSnackBar(responseBody['message']);
    }
    isTransferLoading(false);
  }

  Future withdrawMoney(String amount, String phoneNumber) async {
    isWithdrawLoading(true);
    prefs = await SharedPreferences.getInstance();
    String myNumber = prefs!.getString(USER_NUMBER)!;
    int? myBalance = authController.userModel.value.balance;
    if (myNumber != phoneNumber) {
      customSnackBar("You can't withdraw from this account");
      isWithdrawLoading(false);
      return;
    }

    if (myBalance! < int.parse(amount)) {
      customSnackBar("Insufficient Balance");
      isWithdrawLoading(false);
      return;
    }
    http.Response widthdrawResponse = await apiService.postData(WITHDRAW_URL, {
      "amount": amount,
      "phoneNumber": phoneNumber,
    });
    Map responseBody = json.decode(widthdrawResponse.body);
    if (widthdrawResponse.statusCode == 200) {
      await authController.getUserInfo(myNumber);
      getTransactions();
      Get.back();
      customSnackBar("Withdraw Successful", isError: false);
    } else {
      customSnackBar(responseBody['message']);
    }
    isWithdrawLoading(false);
  }
}
