import 'package:dio/dio.dart';
import 'package:fu_licences/network/apis.dart';

class LicenceNetwork {
  Apis apis = Apis();
  login(data) async {
    Response res = await apis.dio.post(apis.baseUrl + apis.login,
        data: data
    );
    return res;
  }

  getLicenceListInfo(clubid) async {
    Response res = await apis.dio.post(apis.baseUrl + apis.licenceListInfo,
        options: Options(headers: {"Authorization": Apis.tempToken}),
        data: {'userid': 1,
        'club':clubid
        });
    return res;
  }

  getParameters() async {
    Response res = await apis.dio.get(
      apis.baseUrl + apis.getParameters,
      options: Options(headers: {"Authorization": Apis.tempToken}),
    );
    return res;
  }

  deleteLicence(id) async {
    Response res=await apis.dio.delete("${apis.baseUrl}${apis.deleteLicence}$id/",
        options: Options(headers: {"Authorization": Apis.tempToken}),);
        return res;
  }

  addFullLicence(data) async {
    Response res = await apis.dio.post(apis.baseUrl + apis.addFullLicence,
        options: Options(headers: {"Authorization": Apis.tempToken}),
        data: data);
    return res;
  }

  uploadImage(data) async {
    Response res = await apis.dio.post(apis.baseUrl + apis.uploadImage,
        options: Options(
            contentType:
                "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
            headers: {"Authorization": Apis.tempToken}),
        data: data);
    return res;
  }

  editProfile(data,id) async {
    Response res = await apis.dio.put("${apis.baseUrl}${apis.editProfile}$id/",
        options: Options(headers: {"Authorization": Apis.tempToken}),
        data: data);
    return res;
  }

  editAthleteLicence(data) async {
    Response res = await apis.dio.put(apis.baseUrl + apis.editAthleteLicence,
        options: Options(headers: {"Authorization": Apis.tempToken}),
        data: data);
    return res;
  }

  editAthleteProfile(data,id) async {
    Response res = await apis.dio.put("${apis.baseUrl}${apis.editAthleteProfile}$id/",
        options: Options(headers: {"Authorization": Apis.tempToken}),
        data: data);
    return res;
  }

  editArbitratorProfile(data,id) async {
    Response res = await apis.dio.put("${apis.baseUrl}${apis.editArbitratorProfile}$id/",
        options: Options(headers: {"Authorization": Apis.tempToken}),
        data: data);
    return res;
  }

 editArbitratorLicence(data) async {
    Response res = await apis.dio.put(apis.baseUrl + apis.editArbitratorLicence,
        options: Options(headers: {"Authorization": Apis.tempToken}),
        data: data);
    return res;
  }

  editCoachLicence(data) async {
    Response res = await apis.dio.put(apis.baseUrl + apis.editCoachLicence,
        options: Options(headers: {"Authorization": Apis.tempToken}),
        data: data);
    return res;
  }

  editCoachProfile(data,id) async {
    Response res = await apis.dio.put("${apis.baseUrl}${apis.editCoachProfile}$id/",
        options: Options(headers: {"Authorization": Apis.tempToken}),
        data: data);
    return res;
  }
  
  editAthleteImages(data,id) async {
    Response res = await apis.dio.put("${apis.baseUrl}${apis.editAthlete}$id/",
        options: Options(headers: {"Authorization": Apis.tempToken}),
        data: data);
    return res;
  }

  renewLicence(data,id) async {
    try{
      Response res = await apis.dio.put("${apis.baseUrl + apis.renewLicence+id}/",
        options: Options(headers: {"Authorization": Apis.tempToken}),
        data: data);
    return res;
  }
  catch(e){
    //print(e);
  }
  }

  renewArbitratorLicence(data,id) async {
    try{
      Response res = await apis.dio.put("${apis.baseUrl + apis.renewArbitratorLicence+id}/",
        options: Options(headers: {"Authorization": Apis.tempToken}),
        data: data);
    return res;
  }
  catch(e){
    //print(e);
  }
  }

  renewCoachLicence(data,id) async {
    try{
      Response res = await apis.dio.put("${apis.baseUrl + apis.renewCoachLicence+id}/",
        options: Options(headers: {"Authorization": Apis.tempToken}),
        data: data);
    return res;
  }
  catch(e){
    //print(e);
  }
  }

  validateLicence(licenceId) async {
    Response res = await apis.dio.put("${apis.baseUrl + apis.validateLicence+licenceId}/",
        options: Options(headers: {"Authorization": Apis.tempToken}),
        );
    return res;
  }

  getGeneralStats() async {
    Response res = await apis.dio.get(apis.baseUrl + apis.generalStats,
        options: Options(headers: {"Authorization": Apis.tempToken}),
        );
    return res;
  }
}
