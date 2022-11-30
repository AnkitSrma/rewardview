import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:tagmev2/app/data/models/category_model.dart' as cm;
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:tagmev2/app/config/app_colors.dart';
import 'package:tagmev2/app/data/models/cluster_response.dart';
import 'package:tagmev2/app/data/repositories/redeem_repository.dart';
import 'package:tagmev2/app/modules/rewards/controllers/rewards_controller.dart';
import 'package:tagmev2/app/routes/app_pages.dart';

class RedeemCoinsView extends GetView<RewardsController> {
  RedeemCoinsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return AppColors.greyColor;
      }
      return AppColors.greyColor;
    }

    return Padding(
      padding:
          EdgeInsets.only(left: 0.02 * Get.height, right: 0.02 * Get.height),
      child: Column(
        children: [
          SizedBox(
            height: 0.02 * Get.height,
          ),
          Obx(() => controller.progressBarStatus.value
              ? Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                    color: AppColors.button1Color,
                  )),
                )
              : controller.redeemItems.isEmpty
                  ? Center(
                      child: Image.asset(
                        "assets/images/coming_soon.png",
                        width: 0.9 * Get.width,
                        height: 0.5 * Get.height,
                      ),
                    )
                  :
          Obx(() => Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 0.06 * Get.height,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColors.textFieldColor,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: AppColors.textFieldColor,
                                ),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  value: controller.dropdownValue.value,
                                  icon: Visibility(
                                      visible: true,
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 40,
                                      )),
                                  items: controller.redeemItems
                                      .map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.01 * Get.height),
                                        child: Text(
                                          items,
                                          style: TextStyle(
                                              color: AppColors.color
                                                  .withOpacity(0.67),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Graphik',
                                              letterSpacing: 0.5),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) async {
                                    controller.changeSelectedValue(value);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: GetBuilder<RewardsController>(
                                    builder: (value) => value
                                            .chosenRedeemItem.isNotEmpty
                                        ? GridView.builder(
                                            physics:
                                                AlwaysScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: 1.7 / 2,
                                                    crossAxisSpacing: 20,
                                                    mainAxisSpacing: 20,
                                                    crossAxisCount: 2),
                                            itemCount:
                                                value.chosenRedeemItem.length,
                                            itemBuilder:
                                                (BuildContext ctx, index) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  value.order.value = [
                                                    value
                                                        .chosenRedeemItem[index]
                                                  ];
                                                  Get.toNamed(Routes.ORDERS);
                                                },
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      height: Get.height * 0.4,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          // color: Colors.white,
                                                          imageUrl:
                                                              'https://tagme.yilab.org.np/api/v1/imageresizer?src=${value.chosenRedeemItem[index].image}&height=300&width=500',

                                                          fit: BoxFit.cover,
                                                          memCacheHeight: 600,
                                                          memCacheWidth: 600,
                                                          placeholder:
                                                              (context, url) =>
                                                                  Container(
                                                            height: Get.height,
                                                            width: Get.width,
                                                            child: Center(
                                                                child:
                                                                    const CircularProgressIndicator(
                                                              color: AppColors
                                                                  .button1Color,
                                                            )),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 0,
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16),
                                                          width:
                                                              0.45 * Get.width,
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .boxColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                          child: Center(
                                                            child: Text(
                                                              value
                                                                  .chosenRedeemItem[
                                                                      index]
                                                                  .name,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.67),
                                                                  fontFamily:
                                                                      'Graphik',
                                                                  fontSize:
                                                                      Get.height *
                                                                          0.02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          )),
                                                    ),
                                                    Positioned(
                                                      top: Get.height * 0.01,
                                                      left: Get.height * 0.01,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .box1Color,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: Text(
                                                          value
                                                                  .chosenRedeemItem[
                                                                      index]
                                                                  .coinsRequired
                                                                  .toString() +
                                                              ' Coins',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Get.height *
                                                                      0.013,
                                                              fontFamily:
                                                                  'Graphik',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .button2Color),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            })
                                        : Center(
                                            child: Image.asset(
                                              "assets/images/coming_soon.png",
                                              width: 0.9 * Get.width,
                                              height: 0.4 * Get.height,
                                            ),
                                          )),
                              ),
                            ),
                          ],
                        ),
                      ))

          ),
        ],
      ),
    );
  }
}
