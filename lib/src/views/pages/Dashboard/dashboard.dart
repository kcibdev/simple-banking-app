import 'package:floating_navigation_bar/floating_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:simplebankingapp/src/controllers/auth.controller.dart';
import 'package:simplebankingapp/src/controllers/transacion.controller.dart';
import 'package:simplebankingapp/src/models/transaction.model.dart';
import 'package:simplebankingapp/src/utils/formatter.dart';
import 'package:simplebankingapp/src/views/pages/Dashboard/line_chart.dart';
import 'package:simplebankingapp/src/views/pages/SendMoney/transfer.dart';
import 'package:simplebankingapp/src/views/pages/SendMoney/withdraw.dart';
import 'package:simplebankingapp/src/views/widgets/text.dart';

class DashboardScreen extends StatefulWidget {
  final String? number;
  const DashboardScreen({Key? key, this.number}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TransactionController transactionController =
      Get.put(TransactionController());
  AuthController authController = Get.put(AuthController());
  final screens = [
    const TransferScreen(),
    const WithdrawScreen(),
  ];

  @override
  void initState() {
    if (widget.number != null) {
      authController.getUserInfo(widget.number!);
      transactionController.getTransactions();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const CustomText(
              text: "Dashboard",
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
            backgroundColor: const Color(0xFF2c2c54),
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () => authController.logout(),
                  icon: const Icon(Icons.logout))
            ],
          ),
          body: Obx(
            () => transactionController.isGetTransactionLoading.value
                ? Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.only(bottom: 30),
                    child: SpinKitFadingCube(
                      color: const Color(0xFF2c2c54).withOpacity(0.7),
                      size: 60.0,
                    ),
                  )
                : ListView(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 170,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2c2c54),
                        ),
                        child: Column(children: [
                          const SizedBox(height: 20),
                          const CustomText(
                            text: "Account Balance",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          CustomText(
                            text:
                                "N${numformater(authController.userModel.value.balance ?? 0)}",
                            fontSize: 42,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                          ),
                        ]),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        color: const Color(0xFF2c2c54),
                        constraints: const BoxConstraints(
                          maxHeight: 300.0,
                          maxWidth: double.infinity,
                        ),
                        child: LineChart(mainData(transactionController
                            .transactionModel.reversed
                            .toList())),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         const CustomText(
                        //           text: "Total Deposit",
                        //           fontSize: 13,
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //         CustomText(
                        //           text:
                        //               "N${numformater(transactionController.totalDeposit.value)}",
                        //           fontSize: 22,
                        //           color: Colors.black,
                        //         ),
                        //       ],
                        //     ),
                        //     const SizedBox(height: 10),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         const CustomText(
                        //           text: "Withdrawn",
                        //           fontSize: 13,
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //         CustomText(
                        //           text:
                        //               "-N${numformater(transactionController.totalWithdrawn.value)}",
                        //           fontSize: 22,
                        //           color: const Color.fromARGB(255, 154, 12, 12),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // )
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "Transactions",
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                            transactionController.isGetTransactionLoading.value
                                ? Container(
                                    margin: const EdgeInsets.only(top: 40),
                                    child: const Center(
                                        child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xFF2c2c54)),
                                    )),
                                  )
                                : transactionController
                                        .transactionModel.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        reverse: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: transactionController
                                            .transactionModel.length,
                                        itemBuilder: (ctx, idx) {
                                          TransactionModel model =
                                              transactionController
                                                  .transactionModel[idx];
                                          if (model.created == null) {
                                            return Container();
                                          }
                                          return Container(
                                            margin:
                                                const EdgeInsets.only(top: 20),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 50,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: model.type ==
                                                                  "debit"
                                                              ? Colors.red
                                                              : Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: model.type ==
                                                                "debit"
                                                            ? const Icon(
                                                                Icons
                                                                    .arrow_downward,
                                                                color: Colors
                                                                    .white,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .arrow_upward,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomText(
                                                              text: model
                                                                  .phoneNumber,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          CustomText(
                                                              text: dateFormat(
                                                                  model
                                                                      .created),
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .grey[600]!,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  CustomText(
                                                      text:
                                                          "N${numformater(model.amount)}",
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500)
                                                ]),
                                          );
                                        },
                                      )
                                    : const SizedBox(
                                        height: 200,
                                        child: Center(
                                            child: CustomText(
                                                text:
                                                    "No transaction has been made...",
                                                color: Colors.grey)),
                                      )
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
          bottomNavigationBar: FloatingNavigationBar(
            backgroundColor: const Color(0xFF2c2c54),
            iconColor: Colors.white,
            indicatorColor: const Color(0xFF2c2c54),
            barHeight: 70,
            textStyle: GoogleFonts.nunito(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
            iconSize: 20.0,
            items: [
              NavBarItems(icon: Icons.send, title: "Send"),
              NavBarItems(icon: Icons.file_download, title: "Withdraw"),
            ],
            onChanged: (value) {
              //change screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => screens[value],
                ),
              );
            },
          )),
    );
  }
}
