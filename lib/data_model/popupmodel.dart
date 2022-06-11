// To parse this JSON data, do
//
//     final popupModel = popupModelFromJson(jsonString);

import 'dart:convert';

PopupModel popupModelFromJson(String str) => PopupModel.fromJson(json.decode(str));

String popupModelToJson(PopupModel data) => json.encode(data.toJson());

class PopupModel {
    PopupModel({
        this.data,
        this.result,
        this.message,
    });

    List<Datum> data;
    bool result;
    String message;

    factory PopupModel.fromJson(Map<String, dynamic> json) => PopupModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        result: json["result"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "result": result,
        "message": message,
    };
}

class Datum {
    Datum({
        this.id,
        this.type,
        this.value,
    });

    int id;
    String type;
    String value;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
    };
}
