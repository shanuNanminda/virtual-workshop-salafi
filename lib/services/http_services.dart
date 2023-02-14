import 'dart:convert';

import 'package:http/http.dart';
import 'package:virtual_workshop/constants.dart';

class HttpServices {

static String convertVideoLinkToImage(String videoUrl){
    // CUT LAST ELEVEN CHARS AND ADD  https://i.ytimg.com/vi/ AT THE BRGGING ... DONE
    print('https://i.ytimg.com/vi/${videoUrl.substring(videoUrl.length-11, videoUrl.length)}');
return 'https://i.ytimg.com/vi/${videoUrl.substring(videoUrl.length-11, videoUrl.length)}/hq720.jpg';

  }

  static Future<Map> postData(
      {required Map params, required String endPoint}) async {
    try {
      print(Constants.baseUrl + endPoint);
      Response res =
          await post(Uri.parse(Constants.baseUrl + endPoint), body: params);
      print(res.body);
      if (res.statusCode < 299 && res.statusCode > 199) {
        return jsonDecode(res.body);
      } else {
        return {res: 'connection error with code: ${res.statusCode}'};
      }
    } on Exception catch (err) {
      print(err);
      return {'result': 'something went wrong', 'problem': err};
    }
  }

  static Future<dynamic> getData(String endPoint) async {
    try {
      Response res = await get(Uri.parse(Constants.baseUrl + endPoint));
      if (res.statusCode < 299 && res.statusCode > 199) {
        return jsonDecode(res.body);
      } else {
        return {res: 'connection error with code: ${res.statusCode}'};
      }
    } on Exception catch (err) {
      print(err);
      return {'result': 'something went wrong', 'problem': err};
    }
  }
}
