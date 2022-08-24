// ignore_for_file: avoid_print

import 'package:carmarket/models/car/car_model.dart';
import 'package:carmarket/services/dio/dio_client.dart';
import 'package:dio/dio.dart';

class CarServices {
  static Future<List<carDetails>?> carDetailsService(
    String url,
    String key,
  ) async {
    try {
      var response = await DioClient.dio.get(url);
      CarModel allCarDetails = CarModel.fromJson(response.data, key);
      print(allCarDetails.data);
      return allCarDetails.data;
    } on DioError catch (e) {
      print("Dio Error");
      print(e.error);
      print(e.response!.statusMessage);
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }
}