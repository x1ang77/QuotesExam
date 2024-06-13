import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_id_flutter/model/quotes_model.dart';

class QuotesApi {
  final String quotesApi = "https://fcapi-1y70.onrender.com/quotes";

  Future<List<Quotes>> getQuotes() async {
    final response = await http.get(Uri.parse(quotesApi));

    if(response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      print(jsonData);
      return jsonData.map((json) => Quotes.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}