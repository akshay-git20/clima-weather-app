// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart ' as http;

class NetworkHelper {
  final String url;
  NetworkHelper({
    required this.url,
  });
  
  Future getdata() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
  
}
