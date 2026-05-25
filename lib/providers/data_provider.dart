import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mms_app/utils/impact.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DataProvider extends ChangeNotifier {
  int? stepsTotal = 0;
  final Impact impact = Impact();

  DataProvider() {
    getStepsTotal();
  }

Future<int?> getStepsTotal() async {
    //Initialize the result
    int stepsTotal = 0;

    //Get the stored access token (Note that this code does not work if the tokens are null)
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access!)){
      await impact.refreshTokens();
      access = sp.getString('access');
    }//if

    //Create the (representative) request
    final day = '2024-02-04';
    final url = Impact.baseUrl + Impact.stepsEndpoint + Impact.patientUsername + '/day/$day/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    
    //if OK parse the response, otherwise return null
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
        stepsTotal += int.parse(decodedResponse['data']['data'][i]['value']);
      }//for
    } //if
    else{
      stepsTotal = 0;
    }//else
    print('Total steps: $stepsTotal');
    //Return the result
    notifyListeners();
    return stepsTotal;

  } //_requestData
  
}