import 'package:http/http.dart' as http;
import 'dart:convert'; // For converting Dart objects to JSON

class Http_handler{

  String api_domain = "https://oliveorganizer.serralento.de";


  Future<void> post_tree_info(tree_number, zone_id, mass) async {
    final url = Uri.parse(api_domain);

    final Map<String, dynamic> data = {
      "tree_number": tree_number,
      "zone_id": zone_id,
      "mass": mass
    };

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('Response: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> get_tree_info(tree_number, zone_id) async {
    final url = Uri.parse(api_domain);

    final queryParams = {
      "tree_number": tree_number.toString(),
      "zone_id": zone_id.toString()
    };

    final response = await http.get(
      url.replace(queryParameters: queryParams),
    );


    if (response.statusCode == 200) {
      print('Response: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}