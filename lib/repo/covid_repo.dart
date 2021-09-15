import 'dart:io';
import 'package:search_cubit/model/covid.dart';
import 'package:search_cubit/service/covid_service.dart';

class CovidRepository{
  Future<List<CovidInformation>> getCovidData()async{
    try {
      final response = await CovidService.getRequest();

      if(response.statusCode == 200){
        final result = covidDataFromJson(response.body);
        return result.data.data;
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
  Future<int> lastUpdate()async{
    try {
      final response = await CovidService.getRequest();

      if(response.statusCode == 200){
        final result = covidDataFromJson(response.body);
        return result.data.lastUpdated;
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