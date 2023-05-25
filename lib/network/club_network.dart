import 'package:dio/dio.dart';

import 'apis.dart';

class ClubNetwork{
  Apis apis = Apis();
  addClub(data) async {
    print(apis.baseUrl);
    Response res = await apis.dio.post(apis.baseUrl + apis.addClub,

        //  options: Options(
        //    headers: {"Authorization": Apis.tempToken}),
        // data: {"username": "hama",
        // "password":"hama1234"
        // });
        data: data
    );
        //  data: {"username": "club",
        // "password":"12345"
        // });

        
    return res;

  }
}