import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

getData() async {
  try {
    String url =
        'https://hiit.ria.rocks/videos_api/cdn/com.rstream.crafts?versionCode=40&lurl=Canvas%20painting%20ideas';
    log('GET: $url');

    Response response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data;
    }
  } catch (e) {
    log('Error: $e');
    throw e;
  }
}

getComments() async {
  try {
    String url = 'http://cookbookrecipes.in/test.php';
    log('GET: $url');

    Response response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data;
    }
  } catch (e) {
    log('Error: $e');
    throw e;
  }
}
