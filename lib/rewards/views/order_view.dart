import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:tagmev2/app/config/app_colors.dart';
import 'package:tagmev2/app/data/repositories/redeem_repository.dart';
import 'package:tagmev2/app/modules/rewards/controllers/rewards_controller.dart';
import 'package:tagmev2/app/routes/app_pages.dart';
import 'package:tagmev2/app/widgets/buttons.dart';

import '../../../widgets/awesome_snackbar/awesome_snackbar_content.dart';
import '../../../widgets/awesome_snackbar/content_type.dart';
import '../../../widgets/custom_progress_bar.dart';
import '../../profile/controllers/profile_controller.dart';

class OrderView extends GetView<RewardsController> {
  final ProfileController pController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: AppColors.blackColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.height * 0.04),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom: Get.height * 0.03,
                                  top: Get.height * 0.02),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://tagme.yilab.org.np/api/v1/imageresizer?src=${controller.order[0].image}&height=300&width=500',
                            height: Get.height * 0.4,
                            width: Get.width,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Container(
                              height: Get.height * 0.35,
                              width: Get.width,
                              child: Center(
                                  child: const CircularProgressIndicator(
                                color: AppColors.button1Color,
                              )),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.03 * Get.height,
                      ),
                      Text(
                        controller.order[0].categoryName,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: AppColors.nColor.withOpacity(0.67),
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.5,
                            fontFamily: 'Graphik',
                            fontSize: 0.018 * Get.height),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        controller.order[0].name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: AppColors.nColor.withOpacity(0.67),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            fontFamily: 'Graphik',
                            fontSize: 0.03 * Get.height),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        controller.order[0].description,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: AppColors.nColor.withOpacity(0.67),
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.5,
                            fontFamily: 'Graphik',
                            fontSize: 0.018 * Get.height),
                      ),
                      SizedBox(
                        height: 0.03 * Get.height,
                      ),
                      Container(
                        // height: 0.06 * Get.height,
                        width: 1 * Get.width,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.nColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 0.01 * Get.height),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${controller.counter.toString()} x ${controller.order[0].coinsRequired.toString()}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.5,
                                            fontFamily: 'Graphik',
                                            fontSize: 0.025 * Get.height),
                                      ),
                                      Text(
                                        (controller.order[0].coinsRequired *
                                                    controller.counter.value) >
                                                pController.user.value.coins
                                            ? "You don't have enough coins."
                                            : "You will have ${pController.user.value.coins - (controller.order[0].coinsRequired * controller.counter.value)} Coins left.",
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.67),
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 0.5,
                                            fontFamily: 'Graphik',
                                            fontSize: 0.014 * Get.height),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Obx(() => Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.decrementCounter();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5.0),
                                              bottomLeft: Radius.circular(5.0)),
                                          gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                AppColors.button1Color,
                                                AppColors.button2Color,
                                              ]),
                                          color: AppColors.button1Color,
                                        ),
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 0.03 * Get.width,
                                    ),
                                    Text(
                                      controller.counter.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.5,
                                          fontFamily: 'Graphik',
                                          fontSize: 0.025 * Get.height),
                                    ),
                                    SizedBox(
                                      width: 0.03 * Get.width,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.incrementCounter();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5.0),
                                              bottomRight:
                                                  Radius.circular(5.0)),
                                          gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                AppColors.button1Color,
                                                AppColors.button2Color,
                                              ]),
                                          color: AppColors.button1Color,
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.025),
                      Obx(() => GestureDetector(
                            onTap: () async {
                              controller.redeemProgress.value = true;
                              final status = await controller.verifyRedeemItems(
                                  controller.order[0].id,
                                  controller.counter.value);
                              if (!status) {
                                pController.getUserDetail();
                                var snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  duration: Duration(milliseconds: 2000),
                                  content: AwesomeSnackbarContent(
                                    title: 'Sorry!',
                                    message: controller.authError.value,
                                    contentType: ContentType.failure,
                                  ),
                                  // margin: EdgeInsets.only(
                                  //     bottom: Get.height - 200),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                controller.redeemProgress.value = false;
                              } else {
                                pController.getUserDetail();
                                Get.offNamed(Routes.ORDERCOMPLETE);
                                controller.redeemProgress.value = false;
                              }
                            },
                            child: ButtonsWidget(
                                name:
                                    'REDEEM FOR ${(controller.order[0].coinsRequired * controller.counter.value).toString()} COINS'),
                          )),
                      SizedBox(height: Get.height * 0.025),
                    ],
                  ),
                ),
              ),
            )),
        Obx(() =>
            controller.redeemProgress.value ? CustomProgressBar() : Container())
      ],
    );
  }
}
