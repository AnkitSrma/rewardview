import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tagmev2/app/config/app_colors.dart';
import 'package:tagmev2/app/modules/form/views/form_view.dart';
import 'package:tagmev2/app/modules/profile/controllers/profile_controller.dart';
import 'package:tagmev2/app/modules/rewards/views/history_view.dart';
import 'package:tagmev2/app/modules/rewards/views/redeem_coins.dart';
import 'package:tagmev2/app/widgets/forms_widget.dart';

class RewardsView extends StatefulWidget {
  @override
  State<RewardsView> createState() => _RedeemTabBarState();
}

class _RedeemTabBarState extends State<RewardsView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this, initialIndex: 1);
    _controller?.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProfileController pController = Get.find();

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: 0.04 * Get.height,
            ),
            child: RefreshIndicator(
              color: AppColors.button1Color,
              onRefresh: () {
                return Future.delayed(
                  Duration(seconds: 1),
                  () async {
                    pController.getUserDetail();
                  },
                );
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 0.02 * Get.height, right: 0.02 * Get.height),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 0.18 * Get.height,
                    width: 1 * Get.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                           AppColors.linear4Color,
                            AppColors.linear5Color
                          ]),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 0.15 * Get.height, top: 0.02 * Get.height),
                          child: Row(
                            children: [
                              Image.asset('assets/images/wallet.png'),
                              SizedBox(width: 0.02 * Get.width),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Text(
                                      pController.user.value.coins.toString(),
                                      style: TextStyle(
                                          color: AppColors.color,
                                          fontFamily: 'Graphik',
                                          letterSpacing: 1.25,
                                          fontWeight: FontWeight.w600,
                                          fontSize: Get.height * 0.028),
                                    ),
                                  ),
                                  Text(
                                    "Coin balance",
                                    style: TextStyle(
                                        color: AppColors.color,
                                        fontFamily: 'Graphik',
                                        letterSpacing: 1.25,
                                        fontWeight: FontWeight.w300,
                                        fontSize: Get.height * 0.02),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 0.02 * Get.height,
                        ),
                        Text(
                          "Use TagMe Coins to Redeem\nExciting Rewards.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.color.withOpacity(0.87),
                              fontFamily: 'Graphik',
                              letterSpacing: 1.25,
                              fontWeight: FontWeight.w400,
                              fontSize: Get.height * 0.015),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            AppColors.linear4Color,
                            AppColors.linear5Color
                            ,
                          ]),
                    ),
                    child: Center(
                      child: TabBar(
                          indicatorColor: AppColors.button1Color,
                          controller: _controller,
                          unselectedLabelColor: Colors.white,
                          isScrollable: true,
                          labelStyle: TextStyle(
                              color: AppColors.color,
                              fontFamily: 'Graphik',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.25,
                              fontSize: Get.height * 0.017),
                          tabs: [
                            Tab(
                              text: "Earn Coins",
                            ),
                            Tab(
                              text: "Redeem Coins",
                            ),
                            Tab(
                              text: "History",
                            ),
                          ]),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(controller: _controller, children: [
                      Padding(
                        padding:  EdgeInsets.only(left:0.02*Get.height,right: 0.02*Get.height),
                        child: SingleChildScrollView(child: Forms()),
                      ),
                      RedeemCoinsView(),
                      HistoryView(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
