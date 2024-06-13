import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:training_2024/data/datasources/auth_local_datasource.dart';
import 'package:training_2024/data/datasources/config.dart';
import 'package:training_2024/data/models/request/register_request_model.dart';
import 'package:training_2024/data/models/responses/auth_response_model.dart';

class AuthRemoteDatasource {
  //register user
  Future<Either<String, Data>> registerUser(RegisterRequestModel data) async {
    const String url = '${Config.baseUrl}/api/register';
    final response = await http.post(
      Uri.parse(url),
      body: data.toJson(),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 201) {
      return Right(Data.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  //login user
  Future<Either<String, Data>> login(String email, String password) async {
    const String url = '${Config.baseUrl}/api/login';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    return response.statusCode == 200
        ? Right(Data.fromJson(response.body))
        : Left(response.body);
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/api/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      },
    );

    if (response.statusCode == 200) {
      await AuthLocalDatasource().removeAuthData();
      return Right(response.body);
    } else {
      return Left(response.body);
    }
  }
}
