import 'dart:convert';
import 'dart:io';
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

      //Just return the status code
      return response.statusCode;
    }
    return 401;
  } //_refreshTokens

  Future<int> getAndStoreTokens(String username, String password ) async {

    //Create the request
    final url = Impact.baseUrl + Impact.tokenEndpoint;
    final body = {'username': username, 'password': password};

    //Get the response
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If response is OK, decode it and store the tokens. Otherwise do nothing.
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      await sp.setString('access', decodedResponse['access']);
      await sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Just return the status code
    return response.statusCode;
  } //_getAndStoreTokens




Future<List<Steps>?> requestData() async {
    //Initialize the result
    List<Steps>? result;
    

    //Get the stored access token (Note that this code does not work if the tokens are null)
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access!)){
      await refreshTokens();
      access = sp.getString('access');
    }//if

    //Create the (representative) request
    final day = '2024-05-04';
    final url = '${Impact.baseUrl}${Impact.stepsEndpoint}${Impact.patientUsername}/day/$day/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    
    //if OK parse the response, otherwise return null
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      result = [];
      
      for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
        result.add(Steps.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data'][i]));
      }//for
    } //if
    else{
      result = null;
    }//else
    
    return result;

  } //_requestData

  

}