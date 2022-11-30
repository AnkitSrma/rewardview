import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tagmev2/app/config/app_colors.dart';
import 'package:tagmev2/app/modules/rewards/controllers/rewards_controller.dart';
import 'package:tagmev2/app/routes/app_pages.dart';
import 'package:tagmev2/app/widgets/buttons.dart';

class OrderComplete extends GetView<RewardsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 0.35 * Get.height,
                width: Get.width,
                child: Lottie.asset(
                  'assets/animations/shopping.json',
                ),
              ),
              Text(
                'We are on our way!',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 0.058 * Get.height,
                    fontFamily: 'WWF'),
              ),
              Text(
                "Your order has been placed.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    fontFamily: 'Graphik'),
              ),
              SizedBox(height: Get.height * 0.08),
              Text(
                "Our team will reach out to you for further processing.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    fontFamily: 'Graphik'),
              ),
              SizedBox(height: Get.height * 0.01),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.back();
                },
                child: ButtonsWidget(name:'CONTINUE SHOPPING'),
              ),
              SizedBox(height: Get.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(Routes.DASHBOARD, arguments: 1);
                    },
                    child: Text(
                      'Start earning coins!',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 0.018 * Get.height,
                          fontFamily: 'Graphik'),
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 17)
                ],
              ),
              SizedBox(height: Get.height * 0.15),
              Text(
                'Sync forms to our server to get exciting Rewards!',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.w400,
                    fontSize: 0.016 * Get.height,
                    fontFamily: 'Graphik'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
