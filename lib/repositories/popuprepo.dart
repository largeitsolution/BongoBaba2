import 'package:active_ecommerce_flutter/data_model/popupmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:convert';
class Popuprepo{
  Future<PopupModel> getdata() async {
    try {
      var url = 'https://www.bongobaba.com/api/v2/popup';
      http.Response response = await http.get(Uri.parse(url));
      // var data = jsonDecode(response.body)['data'];

      print('Data :${response.body}');
      return popupModelFromJson(response.body);
    } catch (err) {
      print(err.toString());
    }
  }
}