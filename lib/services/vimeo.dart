import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:thepondapp/models/VimeoVideo.dart';

Future<String> getVideoUrl(videoId) async {
  final String token = '362be53a93cd0aec231e47c6c8f38530';

  final http.Response response = await http.get('https://api.vimeo.com/videos/$videoId', headers: {
    HttpHeaders.authorizationHeader: "Bearer $token",
  });
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response
    // then parse the JSON.
    VimeoVideo vimeoResponse = VimeoVideo.fromJson(jsonDecode(response.body));

    return vimeoResponse.files[0].link;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to retrieve vimeo video');
  }
}
