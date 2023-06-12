import 'package:dio/dio.dart';

import 'apis.dart';

class ParameterNetwork{
  Apis apis = Apis();
  addLigue(data) async {
    print(apis.baseUrl);
    Response res = await apis.dio.post(apis.baseUrl + apis.addLigue,
         options: Options(
           headers: {"Authorization": Apis.tempToken}),
        data: data
    );
    return res;
  }
  // addLigue(data) async {
  //   print(apis.baseUrl);
  //   Response res = await apis.dio.post(apis.baseUrl + apis.addLigue,
  //        options: Options(
  //          headers: {"Authorization": Apis.tempToken}),
  //       data: data
  //   );
  //   return res;
  // }
  // addLigue(data) async {
  //   print(apis.baseUrl);
  //   Response res = await apis.dio.post(apis.baseUrl + apis.addLigue,
  //        options: Options(
  //          headers: {"Authorization": Apis.tempToken}),
  //       data: data
  //   );
  //   return res;
  // }
  // addLigue(data) async {
  //   print(apis.baseUrl);
  //   Response res = await apis.dio.post(apis.baseUrl + apis.addLigue,
  //        options: Options(
  //          headers: {"Authorization": Apis.tempToken}),
  //       data: data
  //   );
  //   return res;
  // }
  // addLigue(data) async {
  //   print(apis.baseUrl);
  //   Response res = await apis.dio.post(apis.baseUrl + apis.addLigue,
  //        options: Options(
  //          headers: {"Authorization": Apis.tempToken}),
  //       data: data
  //   );
  //   return res;
  // }
  // addLigue(data) async {
  //   print(apis.baseUrl);
  //   Response res = await apis.dio.post(apis.baseUrl + apis.addLigue,
  //        options: Options(
  //          headers: {"Authorization": Apis.tempToken}),
  //       data: data
  //   );
  //   return res;
  // }
  // addLigue(data) async {
  //   print(apis.baseUrl);
  //   Response res = await apis.dio.post(apis.baseUrl + apis.addLigue,
  //        options: Options(
  //          headers: {"Authorization": Apis.tempToken}),
  //       data: data
  //   );
  //   return res;
  // }
}