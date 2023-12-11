import 'dart:convert';

import 'package:state_management/domain/entity/user_model.dart';
import 'package:state_management/domain/repository/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:state_management/domain/repository/apis_config.dart';
class MyApiService implements ApiService {
  

  @override
Future<UserModel> getUsers(int offset, int limit) async {
  try {
    final response = await http.get(
      Uri.parse('${ApiURL.getUserPoint}?offset=$offset&limit=$limit'),
    );
    final data = json.decode(response.body);

    if (response.statusCode == 200 && data != null) {
      final res = UserModel.fromJson(data);
      if (res.success == true) {
        return res;
      } else {
        throw Exception('Request was not successful.'); // Throw an exception for unsuccessful response
      }
    } else {
      throw Exception('Failed to fetch data'); // Throw an exception for non-200 status codes
    }
  } catch (exception) {
    throw Exception('Failed to fetch data'); // Throw an exception for any exceptions
  }
}


  // @override
  // Future<Response> post(String endpoint, {Map<String, dynamic> data}) {
  //   // Implement the HTTP POST request logic.
  // }
  
  // Implement the constructor and any additional methods.
}
