import 'dart:convert';

import 'package:dicionario_app/dictionary/models/word_detail_model.dart';
import 'package:http/http.dart' as http;

class ServiceWord {
  String url = "https://www.wordsapi.com/mashape/words";

  Future<WordDetailModel?> getWordDetails(String word) async {
    final _url =
        "$url/$word?when=2023-06-25T18:28:59.917Z&encrypted=8cfdb189e722959be89407bee758bcb1aeb5240939fe90b8";
    try {
      final result = await http.get(
        Uri.parse(_url),
        headers: {
          "content-type": "application/json",
        },
      );
      if (result.statusCode >= 200 && result.statusCode < 300) {
        return WordDetailModel.fromJson(jsonDecode(result.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
