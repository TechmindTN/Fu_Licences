import 'package:dio/dio.dart';
import 'package:fu_licences/network/apis.dart';

class LicenceNetwork {
  Apis apis = Apis();

  login() async {
    Response res = await apis.dio.post(apis.baseUrl + apis.login,
        // options: Options(
        //   headers: {"Authorization": apis.tempToken}),
        // data: {"username": "hama",
        // "password":"hama1234"
        // });
         data: {"username": "club",
        "password":"12345"
        });

        
    return res;

  }
  getLicenceListInfo(clubid) async {
    Response res = await apis.dio.post(apis.baseUrl + apis.licenceListInfo,
        options: Options(headers: {"Authorization": apis.tempToken}),
        data: {'userid': 1,
        'club':clubid
        });
        print(res.data);
    return res;
  }

  getParameters() async {
    Response res = await apis.dio.get(
      apis.baseUrl + apis.getParameters,
      options: Options(headers: {"Authorization": apis.tempToken}),
    );
    return res;
  }

  addFullLicence(data) async {
    Response res = await apis.dio.post(apis.baseUrl + apis.addFullLicence,
        options: Options(headers: {"Authorization": apis.tempToken}),
        data: data);
    return res;
  }

  uploadImage(data) async {
    print('entered upload image network');
    print(apis.tempToken);
    Response res = await apis.dio.post(apis.baseUrl + apis.uploadImage,
        options: Options(
            contentType:
                "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
            headers: {"Authorization": apis.tempToken}),
        data: data);
        print('upload image network done');
    return res;
  }
  editProfile(data,id) async {
    Response res = await apis.dio.put(apis.baseUrl + apis.editProfile+id.toString()+"/",
        options: Options(headers: {"Authorization": apis.tempToken}),
        data: data);
    return res;
  }
  editAthleteLicence(data) async {
    Response res = await apis.dio.put(apis.baseUrl + apis.editAthleteLicence,
        options: Options(headers: {"Authorization": apis.tempToken}),
        data: data);
    return res;
  }

  editAthleteProfile(data,id) async {
    Response res = await apis.dio.put(apis.baseUrl + apis.editAthleteProfile+id.toString()+"/",
        options: Options(headers: {"Authorization": apis.tempToken}),
        data: data);
    return res;
  }


  editAthleteImages(data,id) async {
    Response res = await apis.dio.put(apis.baseUrl + apis.editAthlete+id.toString()+"/",
        options: Options(headers: {"Authorization": apis.tempToken}),
        data: data);
    return res;
  }

  renewLicence(data,id) async {
    try{
      Response res = await apis.dio.put(apis.baseUrl + apis.renewLicence+id+"/",
        options: Options(headers: {"Authorization": apis.tempToken}),
        data: data);
    return res;
  }
  catch(e){
    print(e);
   
  }
  }
  
}
