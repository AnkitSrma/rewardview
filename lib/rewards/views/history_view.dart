import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:tagmev2/app/config/app_colors.dart';
import 'package:tagmev2/app/data/models/incentive_history_model.dart';
import 'package:tagmev2/app/data/repositories/redeem_repository.dart';
import 'package:tagmev2/app/modules/rewards/controllers/rewards_controller.dart';

class HistoryView extends GetView<RewardsController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Result>>(
        future: RedeemRepository.getIncentives(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && !snapshot.data!.isEmpty) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        RedeemRepository.getIncentives();
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 0.02 * Get.height,
                            bottom: 0.02 * Get.height),
                        color: AppColors.textFieldColor,
                        child: Row(
                          children: [
                            snapshot.data![index].incentive.image != null
                                ? Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.02 * Get.height),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: CachedNetworkImage(
                                            height: Get.height * 0.1,
                                            width: Get.width * 0.2,
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                'https://tagme.yilab.org.np/api/v1/imageresizer?src=${snapshot.data![index].incentive.image.toString()}&height=300&width=500',
                                            placeholder: (context, url) =>
                                                Center(
                                              child:
                                                  CircularProgressIndicator(
                                                color: AppColors
                                                    .button1Color,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          )),
                                    ),
                                  )
                                : Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.02 * Get.height),
                                      child: Image.asset(
                                        "assets/images/profile.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              width: 0.02 * Get.height,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${snapshot.data![index].incentive.categoryName}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Graphik',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 0.01 * Get.height,
                                  ),
                                  Text(
                                    snapshot.data![index].incentive.name
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Graphik',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 0.01 * Get.height,
                                  ),
                                  Text(
                                    "${controller.counter.toString()}x${snapshot.data![index].incentive.coinsRequired.toString()} Coins",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Graphik',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 0.08 * Get.height),
                            snapshot.data![index].isIncentiveSent == true
                                ? Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.done,
                                          color:
                                              AppColors.lightGreenColor,
                                          size: 0.015 * Get.height,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Delivered",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Graphik',
                                                fontWeight:
                                                    FontWeight.w300,
                                                color: AppColors
                                                    .lightGreenColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          color: AppColors.button2Color,
                                          size: 0.015 * Get.height,
                                        ),

                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          "Pending",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Graphik',
                                              fontWeight:
                                                  FontWeight.w300,
                                              color: AppColors
                                                  .button2Color),
                                        ),
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text(
                  "You don’t seem to have redeemed coins. Redeem coins to see History.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Graphik',
                      color: Colors.white.withOpacity(0.67),
                      letterSpacing: 1.25,
                      fontWeight: FontWeight.w300),
                ),
              );
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Sorry,not found!"),
            );
          }

          return Center(
              child: CircularProgressIndicator(
                color: AppColors.button1Color,
              ));
        });
  }
}
