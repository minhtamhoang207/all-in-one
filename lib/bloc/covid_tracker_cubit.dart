import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_cubit/model/covid.dart';
import 'package:search_cubit/repo/covid_repo.dart';

class CovidCubit extends Cubit<CovidState>{
  final CovidRepository _repository;
  CovidCubit(this._repository) : super(InitState());

  Future getCovidData() async{
    emit(SearchingState());

    try {
      final words = await _repository.getCovidData();
      final lastUpdate = await _repository.lastUpdate();

      if(words == null){
        emit(ErrorState("There is no result"));
      }else{
        emit(SearchedState(words, lastUpdate));
      }
    } on Exception catch (e) {
      print(e);
      emit(ErrorState(e.toString()));
    }
  }
}

abstract class CovidState{}

class InitState extends CovidState{

}

class SearchingState extends CovidState{

}

class SearchedState extends CovidState{
  final List<CovidInformation> covidData;
  final int lastUpdate;
  SearchedState(this.covidData, this.lastUpdate);

}

class ErrorState extends CovidState{
  final message;
  ErrorState(this.message);
}