import 'dart:convert';

import 'package:admin/Errors/Failure.dart';
import 'package:admin/const/const.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;

class GetDataFromHttp {
  Future<Either<Failure, List<Map<String, dynamic>>?>> GetDataHttp() async {
    try {
      http.Response response =
          await http.get(Uri.parse(localHost + gymCollection));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Map<String, dynamic>> dataToRes = [];
        data.forEach(
          (element) {
            dataToRes.add(element);
          },
        );
        return Right(dataToRes);
      } else {
        print('Failed to load members. Status code: ${response.statusCode}');
        return Left(
            Failure(message: response.statusCode.toString(), key: 'errorHttp'));
      }
    } catch (e) {
      return Left(
        Failure(message: e.toString(), key: 'errorHttp'),
      );
    }
  }

  Future<Either<Failure, String>> SetDataHttp(
      {required String collectionName,
      required Map<String, dynamic> data}) async {
    try {
      final send = jsonEncode(data);
      print(send);
      final http.Response response = await http.post(
        Uri.parse(localHost + "add-user"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: send,
      );

      if (response.statusCode == 201) {
        // If the server returns a successful response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Member added successfully: ${responseData['id']}');
        return Right("Member added successfully");
      } else {
        // If the server did not return a 201 CREATED response,
        // throw an exception.
        print('Failed to add member. Status code: ${response.statusCode}');
        return Left(Failure(key: '', message: "Failed to add member"));
      }
    } catch (e) {
      return Left(Failure(key: '', message: e.toString()));
    }
  }
}
