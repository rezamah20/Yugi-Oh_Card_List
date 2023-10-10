import 'dart:convert';
import 'package:flutter/cupertino.dart';

import '../model/allcard.dart';
import 'package:http/http.dart' as http;


class ApiService {

  final String baseUrl = "https://db.ygoprodeck.com/api/v7/cardinfo.php";

  Future<List<Cards>> getData() async{
        final response = await http.get(Uri.parse(baseUrl));

        if(response.statusCode == 200){

          Iterable it = jsonDecode(response.body)['data'];
          var cards = it.map((card) => Cards.fromJson(card)).toList();

          return cards;
        }else{
          throw Exception('Failed to load jobs from API');
        }
  }

  Future<List<DetailCards>> getDetail(String name) async{
    final response = await http.get(Uri.parse("$baseUrl?name=$name"));
    print(response);

    if(response.statusCode == 200){
      // print(response.body);
      Iterable it = jsonDecode(response.body)['data'];
      print(response.body);

      var cards = it.map((card) => DetailCards.fromJson(card)).toList();
      // const List<Country> countryOptions = <Country>[
      //   Country(name: 'Africa'),
      //   Country(name: 'Asia'),
      // ];
      //  print(countryOptions);
      return cards;
    }else{
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<List<BannerCard>> getBannerCard(String name) async{
    final response = await http.get(Uri.parse("$baseUrl?cardset=$name"));
    print(response);

    if(response.statusCode == 200){

      Iterable it = jsonDecode(response.body)['data'];
      print(response.body);
      var cards = it.map((card) => BannerCard.fromJson(card)).toList();

      return cards;
    }else{
      throw Exception('Failed to load jobs from API');
    }
  }
}