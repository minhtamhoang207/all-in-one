import 'dart:io';
import 'package:search_cubit/model/Word.dart';
import 'package:search_cubit/service/http_service.dart';

class TodoRepository{
  Future<List<Word>> getWords(String query)async{
    try {
      final response = await HttpService.getRequest("en_US/$query");

      if(response.statusCode == 200){
        final result = wordFromJson(response.body);
        return result;
      }else{
        return null;
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    }
  }
}