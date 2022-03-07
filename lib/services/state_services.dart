import 'dart:convert';

import 'package:covid_tracker/models/world_states_model.dart';
import 'package:covid_tracker/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StateServices{

  Future<WorldStatesModel> fetchWorldStatesRecord() async{

    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> countriesListApi() async{

    dynamic data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception("Error");
    }
  }
}