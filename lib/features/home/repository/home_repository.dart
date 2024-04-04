import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/data_model.dart';
final homeRepositoryProvider=Provider((ref) => HomeRepository());
class HomeRepository{
  Future<Restaurants> getRestaurants()async{
    var datas;
    final response = await http.get((Uri.parse("https://firstflight-web.ipixsolutions.net/api/getRestaurants")));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      datas = Restaurants.fromJson(data);
    } else {
      "Failed to load data";
    }
    return datas;
  }
}