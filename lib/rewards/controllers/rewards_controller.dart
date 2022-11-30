import 'package:get/get.dart';
import 'package:tagmev2/app/config/constants.dart';
import 'package:tagmev2/app/data/models/redeem_items_model.dart'
    as RedeemItemModel;
import 'package:tagmev2/app/data/repositories/redeem_repository.dart';
import 'package:tagmev2/main.dart';

import '../../../data/models/category_model.dart';

class RewardsController extends GetxController {
  final RxList<Incentive> order = [
    Incentive(
        id: 1,
        name: "name",
        coinsRequired: 0,
        image: "image",
        isAlreadyBought: false,
        isDelivered: false,
        categoryName: '',
        description: '',
        quantity: 0)
  ].obs;

  final dropdownValue = 'CATEGORIES:'.obs;
  final boolReward = false.obs;
  final index = 0.obs;
  final orderIndex = 0.obs;
  final isChecked = false.obs;
  RedeemItemModel.RedeemItems? incentive;
  final progressBarStatus = false.obs;
  final authError = ''.obs;
  final coins = ''.obs;

  final redeemStore = [].obs;

  final mainRedeemStore = [].obs;

  final emptyIncentives = [].obs;
  final notEmptyIncentives = [].obs;

  final chosenRedeemItem = [].obs;

  final redeemPageIndex = 1.obs;

  showProgressBar() => progressBarStatus.value = true;

  hideProgressBar() => progressBarStatus.value = false;

  // List of items in our dropdown menu
  var counter = 1.obs;

  void incrementCounter() {
    counter++;
  }

  void decrementCounter() {
    if (counter > 1) {
      counter--;
    }
  }

  final redeemItems = ['Categories:'].obs;

  final redeemItemsEmpty = ['Categories:'].obs;

  final redeemNotEmpty = ['Categories:'].obs;

  @override
  void onInit() async {
    getIncentives();
    super.onInit();
  }

  final redeemButton = false.obs;

  final redeemProgress = false.obs;

  Future<bool> verifyRedeemItems(int id, int quantity) async {
    try {
      showProgressBar();
      final status =
          await RedeemRepository.verifyRedeem(id, quantity).catchError((error) {
        authError.value = error;
        return false;
      });

      hideProgressBar();
      if (status == null) {
        return false;
      } else if (!status) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      hideProgressBar();
      return false;
    }
  }

  final errorMessage = ''.obs;

  Future<bool> getIncentives({bool isRefresh = false}) async {
    showProgressBar();
    var response =
        await RedeemRepository.getIncentivesCategory().catchError((error) {
      this.errorMessage.value = error;
      return false;
    });

    if (response == null) {
      hideProgressBar();
      return false;
    }

    // if (response.isEmpty) {
    //   hideProgressBar();
    //   return false;
    // }

    if (response is bool || response.isEmpty) {
      redeemItemsEmpty.clear();
      redeemNotEmpty.clear();
      redeemItems.clear();
      emptyIncentives.clear();
      notEmptyIncentives.clear();
    } else if (redeemPageIndex.value == 1) {
      redeemItemsEmpty.clear();
      redeemNotEmpty.clear();
      redeemItems.clear();
      emptyIncentives.clear();
      notEmptyIncentives.clear();
      mainRedeemStore.value = (response);

      for (int i = 0; i < mainRedeemStore.length; i++) {
        if (mainRedeemStore[i].incentives.isEmpty) {
          redeemItemsEmpty.add(mainRedeemStore[i].name);
          emptyIncentives.add(mainRedeemStore[i].incentives);
        } else {
          redeemNotEmpty.add(mainRedeemStore[i].name);
          notEmptyIncentives.add(mainRedeemStore[i].incentives);
        }
      }

      for (int i = 0; i < redeemNotEmpty.length; i++) {
        redeemItems.add(redeemNotEmpty[i]);
        redeemStore.add(notEmptyIncentives[i]);
      }

      for (int i = 0; i < redeemItemsEmpty.length; i++) {
        redeemItems.add(redeemItemsEmpty[i]);
        redeemStore.add(emptyIncentives[i]);
      }

      dropdownValue.value = redeemItems[0];
      chosenRedeemItem.value = redeemStore[0];
      redeemPageIndex.value = 2;
    } else {
      redeemPageIndex.value++;
      redeemStore.addAll(response);
    }

    hideProgressBar();

    return true;
  }

  changeSelectedValue(dynamic value) {
    dropdownValue.value = value!;
    index.value = redeemItems.indexOf(dropdownValue.value);
    // chosenRedeemItem.clear();
    chosenRedeemItem.value = redeemStore[index.value];
    chosenRedeemItem.refresh();
    update();
  }
}
