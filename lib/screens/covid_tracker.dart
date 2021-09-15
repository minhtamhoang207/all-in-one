import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_cubit/bloc/covid_tracker_cubit.dart';
import 'package:search_cubit/repo/covid_repo.dart';
import 'package:intl/intl.dart';


class CovidTracker extends StatefulWidget {

  @override
  _CovidTrackerState createState() => _CovidTrackerState();
}

class _CovidTrackerState extends State<CovidTracker> {

  final cubit = CovidCubit(CovidRepository());

  @override
  void initState() {
    cubit.getCovidData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () => cubit.getCovidData(),
          child: BlocProvider.value(
            value: cubit,
            child: BlocBuilder<CovidCubit, CovidState>(
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
                              onTap: (){},
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                child: Center(child: Text("Last update: ${formatDateTime(DateTime.fromMillisecondsSinceEpoch(state.lastUpdate * 1000))}")),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.covidData.length,
                            itemBuilder: (context, index){
                              return Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: index.isEven?Colors.black12:Colors.grey.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        formatDateTime(state.covidData[state.covidData.length-1-index]?.date)??"",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                        ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Ca mắc mới: ${state.covidData[state.covidData.length-1-index]?.daily??""}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.redAccent.withOpacity(0.8)
                                        ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Tổng cộng: ${state.covidData[state.covidData.length-1-index]?.total??""}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.deepPurple.withOpacity(0.8)
                                        ),
                                    ),
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
                    child: Text("Not found",style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  formatDateTime(DateTime dateTime){
    String formattedDate = DateFormat('hh:mm  dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }
}
