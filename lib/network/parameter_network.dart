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
  addCategory(data) async {
    print(apis.baseUrl);
    Response res = await apis.dio.post(apis.baseUrl + apis.addCategory,
         options: Options(
           headers: {"Authorization": Apis.tempToken}),
        data: data
    );
    return res;
  }
  addDegree(data) async {
    print(apis.baseUrl);
    Response res = await apis.dio.post(apis.baseUrl + apis.addDegree,
         options: Options(
           headers: {"Authorization": Apis.tempToken}),
        data: data
    );
    return res;
  }
  addGrade(data) async {
    print(apis.baseUrl);
    Response res = await apis.dio.post(apis.baseUrl + apis.addGrade,
         options: Options(
           headers: {"Authorization": Apis.tempToken}),
        data: data
    );
    return res;
  }
  addDiscipline(data) async {
    print(apis.baseUrl);
    Response res = await apis.dio.post(apis.baseUrl + apis.addDiscipline,
         options: Options(
           headers: {"Authorization": Apis.tempToken}),
        data: data
    );
    return res;
  }
  addWeight(data) async {
    print(apis.baseUrl);
    Response res = await apis.dio.post(apis.baseUrl + apis.addWeight,
         options: Options(
           headers: {"Authorization": Apis.tempToken}),
        data: data
    );
    return res;
  }
  addSeason(data) async {
    print(apis.baseUrl);
    Response res = await apis.dio.post(apis.baseUrl + apis.addSeason,
         options: Options(
           headers: {"Authorization": Apis.tempToken}),
        data: data
    );
    return res;
  }
}