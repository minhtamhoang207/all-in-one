import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_cubit/model/Word.dart';
import 'package:search_cubit/repo/todos_repo.dart';

class TodoCubit extends Cubit<TodoState>{
  final TodoRepository _repository;
  TodoCubit(this._repository) : super(InitState());

  Future getWords(String query) async{
    print("seachiung");
    emit(SearchingState());

    try {
      final words = await _repository.getWords(query);

      if(words == null){
        emit(ErrorState("There is no result"));
      }else{
        print("searched");
        emit(SearchedState(words));
      }
    } on Exception catch (e) {
      print(e);
      emit(ErrorState(e.toString()));
    }
  }
  back(){
    emit(InitState());
  }
}

abstract class TodoState{}

class InitState extends TodoState{

}

class SearchingState extends TodoState{

}

class SearchedState extends TodoState{
  final List<Word> words;
  SearchedState(this.words);

}

class ErrorState extends TodoState{
  final message;
  ErrorState(this.message);
}