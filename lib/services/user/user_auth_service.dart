// ignore_for_file: avoid_print

import 'package:carmarket/view/constants/styles/colors.dart';
import 'package:carmarket/models/local_storage/local_storage.dart';
import 'package:carmarket/models/profile/profile_model.dart';
import 'package:carmarket/services/dio/dio_client.dart';
import 'package:carmarket/view/home/bottom_nav.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class UserAuthServices {
  //
  //<<<<<User_Login>>>>>//
  static Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    print(email);
    print(password);
    try {
      var response = await DioClient.dio.post("/login", data: {
        "email": email,
        "password": password,
      });

      print(response.data);

      //<<<<<Saving_Id_Token>>>>>//
      Map<String, String> user = {
        "uId": response.data['_id'],
        "token": response.data['token'],
        "email": response.data['email'],
        "name": response.data['name']
      };
      GetLocalStorage.saveToken(user);

      Get.offAll(const BottomNavBar());
      Get.snackbar(
        "Success",
        "Successfully logged in.",
        backgroundColor: kWhite,
      );
      return "success";

      //<<<<<Dio_Error>>>>>//
    } on DioError catch (e) {
      print("Dio error");
      print(e.response!.data);
      print(e.response!.statusMessage);

      Get.snackbar(
        'Warning',
        e.response!.data['message'],
        backgroundColor: kWhite,
      );

      if (e.type == DioErrorType.other) {
        Get.snackbar(
          'Warning',
          'No internet connection.',
          backgroundColor: kWhite,
        );
        print("no internet");
        return "No internet connection";
      }

      if (e.response != null) {
        return e.response!.data['message'];
      }
      return "";
    }
  }

  //<<<<<User_Signup>>>>>//
  static Future<String> signupUser(ProfileModel profileModelData) async {
    Map<String, dynamic> headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    try {
      Map signupData = ProfileModel(
        name: profileModelData.name,
        email: profileModelData.email,
        phone: profileModelData.phone,
        age: profileModelData.age,
        gender: profileModelData.gender,
        address: profileModelData.address,
        district: profileModelData.district,
        password: profileModelData.password,
      ).toJson();

      final response = await DioClient.dio.post(
        "/signup",
        data: signupData,
        options: Options(
          followRedirects: false,
          headers: headers,
        ),
      );

      //<<<<<Registering_User_Details>>>>>//
      Map<String, String> user = {
        "uId": response.data['user'],
        "token": response.data['token'],
        "email": response.data['email'],
        "name": response.data['name']
      };
      GetLocalStorage.saveToken(user);

      print("Success");
      print(response.data);

      Get.snackbar(
        "Success",
        response.data["messagge"],
        backgroundColor: kWhite,
      );
      return "success";
      //
      //<<<<<Dio_Error>>>>>//
    } on DioError catch (e) {
      print("Dio Error");
      print(e.error);
      print(e.response!.data);
      print(e.response!.statusMessage);

      Get.snackbar(
        'Warning',
        e.response!.data['message'],
        backgroundColor: kWhite,
      );

      if (e.type == DioErrorType.other) {
        print("no internet");
        return "no internet connection";
      }

      if (e.response != null) {
        return e.response!.data['message'];
      }
      return 'something went wrong';
    }
  }
}
