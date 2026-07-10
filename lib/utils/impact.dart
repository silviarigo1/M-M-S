// This page contains the Impact class, which is used to interact with the Impact API. 
// As instance variables, it contains: the base url of the API, the endpoints of the API, 
// the username and the password of the user (that are taken from the login page),
// and the username of the patient.
// As methods it contains: refreshTokens, getAndStoreTokens and requestData.
// The first two methods are used to get and refresh the JWT tokens, while the last one is used to request 
// the step-related data of the patient.


import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:mms_app/models/steps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Impact{

  static String baseUrl = 'https://impact.dei.unipd.it/bwthw/';
  static final gateUrl = "gate/v1/";
  static final dataUrl = "data/v1/";
  static final username = '';
  static final password = '';
  static String pingEndpoint = 'gate/v1/ping/';
  static String tokenEndpoint = 'gate/v1/token/';
  static String refreshEndpoint = 'gate/v1/refresh/';
  static String stepsEndpoint = 'data/v1/steps/patients/';
  static String heartRateEndpoint = 'data/v1/resting_heart_rate/patients/';
  static String sleepEndpoint = 'data/v1/sleep/patients/';
  static String patientUsername = 'Jpefaq6m58';
  

//This method allows to refresh the stored JWT in SharedPreferences
  Future<int> refreshTokens() async {

    //Create the request
    final url = Impact.baseUrl + Impact.refreshEndpoint;
    final sp = await SharedPreferences.getInstance();
    final refresh = sp.getString('refresh');
    if (refresh != null) {
      final body = {'refresh': refresh};

      //Get the response
      print('Calling: $url');
      final response = await http.post(Uri.parse(url), body: body);

      //If the response is OK, set the tokens in SharedPreferences to the new values
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final sp = await SharedPreferences.getInstance();
        await sp.setString('access', decodedResponse['access']);
        await sp.setString('refresh', decodedResponse['refresh']);
      } 

      return response.statusCode;
    }
    return 401;
  } // _refreshTokens


  Future<int> getAndStoreTokens(String username, String password ) async {

    //Create the request
    final url = Impact.baseUrl + Impact.tokenEndpoint;
    final body = {'username': username, 'password': password};

    //Get the response
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    // If response is OK, decode it and store the tokens. Otherwise do nothing.
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      await sp.setString('access', decodedResponse['access']);
      await sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Just return the status code
    return response.statusCode;
  } //_getAndStoreTokens





}