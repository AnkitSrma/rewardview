import 'dart:convert';
import 'dart:io';

import 'package:tagmev2/app/config/constants.dart';
import 'package:tagmev2/app/data/models/incentive_history_model.dart'
    as history;
import 'package:tagmev2/app/data/models/category_model.dart' as category;
import 'package:tagmev2/app/data/models/redeem_model.dart' as redeemModel;
import 'package:tagmev2/app/data/models/referral_codes_model.dart';
import 'package:tagmev2/app/data/network/network_helper.dart';
import 'package:tagmev2/app/data/repositories/profile_repository.dart';
import 'package:tagmev2/app/data/services/secure_storage.dart';
import 'package:tagmev2/app/data/services/token_refresher.dart';
import 'package:tagmev2/main.dart';

class RedeemRepository {
  static Future<dynamic> verifyRedeem(int incentive, int quantity) async {
    const url = '$BASE_URL/api/v1/incentive/';
    final body = jsonEncode({"incentive": incentive, "quantity": quantity});
    final refreshValid = await TokenRefresher().refresh();
    if (refreshValid) {
      try {
        final response = await NetworkHelper().postRequest(url,
            data: body,
            contentType: await SecureStorage.returnHeaderWithToken());
        if (response.statusCode == 200) {
          ProfileRepository.getUserDetailFromServer();
          return true;
        } else if (response.statusCode == 404) {
          return Future.error('Not enough quantity available.');
        } else if (response.statusCode == 400) {
          return Future.error('Not enough coins!');
        } else {
          return Future.error('Please contact support');
        }
      } on SocketException {
        return Future.error(
            'Please check your internet connection and try again. Socket');
      } catch (e) {
        return Future.error('Please contact support.');
      }
    }
  }

  static Future<dynamic> getRewards() async {
    String url = '$BASE_URL/api/v1/incentive-category';
    final refreshValid = await TokenRefresher().refresh();
    if (refreshValid) {
      final response = await NetworkHelper().getRequest(url,
          contentType: await SecureStorage.returnHeaderWithToken());
      final data = response.data;

      if (response.statusCode == 200) {
        List<redeemModel.Incentive> redeem = (response.data["results"] as List)
            .map((i) => redeemModel.Incentive.fromJson(i))
            .toList();
        return redeem;
      } else {
        return Future.error(data['message']);
      }
    }
  }

  static Future<List<history.Result>> getIncentives() async {
    String url = '$BASE_URL/api/v1/incentive-history';
    final refreshValid = await TokenRefresher().refresh();
    if (refreshValid) {
      final response = await NetworkHelper().getRequest(url,
          contentType: await SecureStorage.returnHeaderWithToken());
      final data = response.data;

      if (response.statusCode == 200) {
        List<history.Result> h1 = (response.data["results"] as List)
            .map((i) => history.Result.fromJson(i))
            .toList();
        return h1;
      } else {
        return Future.error(data['message']);
      }
    }
    return Future.error('');
  }

  static Future<dynamic> getReferralCode() async {
    String url = '$BASE_URL/api/v1/accounts/generate-refer-code';
    try {
      final refreshValid = await TokenRefresher().refresh();
      if (refreshValid) {
        final response = await NetworkHelper().getRequest(url,
            contentType: await SecureStorage.returnHeaderWithToken());
        final data = response.data;
        if (response.statusCode == 201) {
          RefferalCodes refferalCodes = RefferalCodes.fromJson(data);
          storage.writeReferralCode(
              Constants.REFERRAL_CODE, refferalCodes.code);
          return refferalCodes;
        } else {
          return Future.error(data['message']);
        }
      }
    } catch (e) {
      return Future.error('No internet.');
    }
  }

  static Future<dynamic> getIncentivesCategory() async {
    String url = '$BASE_URL/api/v1/incentive-category?ordering=id';
    final refreshValid = await TokenRefresher().refresh();
    if (refreshValid) {
      final response = await NetworkHelper().getRequest(url,
          contentType: await SecureStorage.returnHeaderWithToken());
      final data = response.data;

      if (response.statusCode == 200) {
        List<category.Result> h1 = (response.data["results"] as List)
            .map((i) => category.Result.fromJson(i))
            .toList();
        return h1;
      } else {
        return Future.error(data['message']);
      }
    }
    return Future.error('');
  }
}
