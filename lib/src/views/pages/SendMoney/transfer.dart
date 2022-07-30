import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplebankingapp/src/controllers/transacion.controller.dart';
import 'package:simplebankingapp/src/utils/custom_snackbar.dart';
import 'package:simplebankingapp/src/views/widgets/button.dart';
import 'package:simplebankingapp/src/views/widgets/input.dart';
import 'package:simplebankingapp/src/views/widgets/text.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  TransactionController transactionController =
      Get.put(TransactionController());
  final TextEditingController? _phoneController = TextEditingController();
  final TextEditingController? _amountController = TextEditingController();

  @override
  void initState() {
    // ApiService().getData();
    super.initState();
  }

  transfer() async {
    if (_phoneController!.text.isEmpty || _amountController!.text.isEmpty) {
      customSnackBar("Please enter all the fields");
    } else {
      await transactionController.transferMoney(
          _amountController!.text, _phoneController!.text);
      _amountController!.clear();
      _phoneController!.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF2c2c54)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Obx(
          () => ListView(
            children: [
              const SizedBox(height: 70),
              const CustomText(
                text: "Transfer",
                fontSize: 35,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: CustomText(
                  text: "Send money to a friend or deposit in your account",
                  fontSize: 16,
                  color: Colors.grey,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              CustomInput(
                label: "Phone Number",
                hint: "Enter your phone number",
                controller: _phoneController,
              ),
              const SizedBox(height: 20),
              CustomInput(
                label: "Amount",
                hint: "Amount to send",
                obscureText: true,
                controller: _amountController,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: transactionController.isTransferLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF2c2c54)),
                      ))
                    : CustomButton(
                        text: "Send",
                        onPressed: () {
                          transfer();
                        },
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        elevation: 3,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
