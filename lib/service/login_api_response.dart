import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:product_test_app/model/login_request_model.dart';
import 'package:product_test_app/model/user_model.dart';
import 'package:product_test_app/util/api_endPoint.dart';


class AuthService {
  Future<User> doLogin(LoginRequest request) async {
    http.Response response = await http.post(
      Uri.parse(ApiEndpoint.loginURL),
      body: jsonEncode(request.toJson()),
      headers: {
        'content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }

      final result = jsonDecode(response.body);
      return User.fromJson(result);
    } else {
      throw "Something went wrong";
    }
  }
}