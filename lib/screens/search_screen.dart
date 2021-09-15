import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_cubit/bloc/todo_cubit.dart';
import 'package:search_cubit/repo/todos_repo.dart';

class Search extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  final cubit = TodoCubit(TodoRepository());
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider.value(
          value: cubit,
          child: BlocBuilder<TodoCubit, TodoState>(
            bloc: cubit,
            builder: (context, state){
              if(state is SearchingState){
                return Center(
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              else if (state is SearchedState){
                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              cubit.back();
                            },
                            child: Container(
                              height: 35,
                              width: 55,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(Icons.arrow_back, color: Colors.white),
                                ],
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.words.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.words[index].word, style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic
                                  )),
                                  Text("/ ${state.words[index].phonetic??"..."} /"),
                                  SizedBox(height: 10),
                                  Text(state.words[index].origin??""),
                                  SizedBox(height: 10),
                                  Text(state.words[index]?.meanings[0]?.definitions[0]?.definition??""),
                                  SizedBox(height: 10),
                                  Text("Example: ${state.words[index]?.meanings[0]?.definitions[0]?.example??""}",style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic
                                  )),
                                  SizedBox(height: 15),
                                  Divider(
                                    thickness: 1.5,
                                  )
                                ],
                              ),
                            );
                          }
                      ),
                    ),
                  ],
                );
              }
              else if (state is ErrorState){
                return Center(
                  child: InkWell(
                    onTap: (){
                      cubit.back();
                    },
                    child: Text("Not found",style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),),
                  ),
                );
              }
              return Center(
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.only(left: 15,right: 5),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                        hintText: "Please enter a word 🥵 ",
                        suffixIcon: InkWell(
                          onTap: (){
                            cubit.getWords(_controller.text);
                          },
                          child: Icon(
                              Icons.search
                          ),
                        ),
                        border: InputBorder.none
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
