import 'dart:convert';

CovidData covidDataFromJson(String str) => CovidData.fromJson(json.decode(str));

String covidDataToJson(CovidData data) => json.encode(data.toJson());

class CovidData {
  CovidData({
    this.data,
    this.err,
    this.msg,
    this.server,
    this.serverTime,
  });

  Data data;
  int err;
  String msg;
  String server;
  int serverTime;

  factory CovidData.fromJson(Map<String, dynamic> json) => CovidData(
    data: Data.fromJson(json["data"]),
    err: json["err"],
    msg: json["msg"],
    server: json["server"],
    serverTime: json["server_time"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "err": err,
    "msg": msg,
    "server": server,
    "server_time": serverTime,
  };
}

class Data {
  Data({
    this.data,
    this.lastUpdated,
  });

  List<CovidInformation> data;
  int lastUpdated;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<CovidInformation>.from(json["data"].map((x) => CovidInformation.fromJson(x))),
    lastUpdated: json["lastUpdated"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "lastUpdated": lastUpdated,
  };
}

class CovidInformation {
  CovidInformation({
    this.date,
    this.total,
    this.ma7,
    this.daily,
    this.additional,
    this.dailyWoAdditional,
  });

  DateTime date;
  String total;
  String ma7;
  String daily;
  String additional;
  String dailyWoAdditional;

  factory CovidInformation.fromJson(Map<String, dynamic> json) => CovidInformation(
    date: DateTime.parse(json["date"]),
    total: json["total"],
    ma7: json["ma7"],
    daily: json["daily"],
    additional: json["additional"],
    dailyWoAdditional: json["daily-wo-additional"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "total": total,
    "ma7": ma7,
    "daily": daily,
    "additional": additional,
    "daily-wo-additional": dailyWoAdditional,
  };
}
