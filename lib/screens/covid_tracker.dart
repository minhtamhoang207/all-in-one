import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_cubit/bloc/covid_tracker_cubit.dart';
import 'package:search_cubit/custom_widget/custom_text.dart';
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
    return Scaffold(
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
                return Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height/3,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://s.rfi.fr/media/display/76657a50-486a-11eb-ba02-005056bfd1d9/w:1280/p:16x9/vaccin18.webp"
                                ),
                                fit: BoxFit.cover
                              )
                          ),
                          child:  BackdropFilter(
                            filter:  ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                            child:  Container(
                              decoration:  BoxDecoration(color: Colors.blueAccent.withOpacity(0.3)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.15)
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 15, right: 15),
                      child: ListView(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height/10),
                          MyText(
                            text: "Update lần cuối: ${formatDateTime(DateTime.fromMillisecondsSinceEpoch(state.lastUpdate * 1000))}",
                            color: Colors.white,
                            size: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: MyText(
                              text: "${formatDateOnly(DateTime.fromMillisecondsSinceEpoch(state.lastUpdate * 1000))} (Hà Nội)",
                              color: Colors.white,
                              size: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 30, bottom: 30),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0.1,
                                          blurRadius: 0.1,
                                          offset: Offset(1, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        MyText(
                                          text: "TỔNG",
                                          size: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                        MyText(
                                          text: state.covidData[state.covidData.length-1].total??"",
                                          size: 35,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 30, bottom: 30),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 0.1,
                                            blurRadius: 0.1,
                                            offset: Offset(1, 3), // changes position of shadow
                                          ),
                                        ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        MyText(
                                          text: "CA MỚI",
                                          size: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                        MyText(
                                            text: state.covidData[state.covidData.length-1].dailyWoAdditional??"",
                                            size: 35,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.greenAccent
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 15,
                            itemBuilder: (context, index){
                              return Container(
                                margin: EdgeInsets.only(top: 9),
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0.1,
                                        blurRadius: 0.1,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              formatDateOnly(state.covidData[state.covidData.length-2-index]?.date)??"",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  fontSize: 14
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              "Tổng: ${state.covidData[state.covidData.length-2-index]?.total??""}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 25,
                                                  color: Colors.black
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_upward_rounded, color: Colors.green),
                                        Text(
                                          "${state.covidData[state.covidData.length-2-index]?.daily??""}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.redAccent.withOpacity(0.8)
                                          ),
                                        ),
                                        SizedBox(width: 20)
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    )
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
    );
  }

  formatDateTime(DateTime dateTime){
    String formattedDate = DateFormat('hh:mm  dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  formatDateOnly(DateTime dateTime){
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }
}
