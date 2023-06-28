// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dicionario_app/API/service_word.dart';
import 'package:dicionario_app/dictionary/models/word_detail_model.dart';
import 'package:dicionario_app/utils/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/widgets/snack_bar.dart';
import '../views/word_detail_page.dart';

class WordListPageController {
  final ServiceWord _serviceWord = ServiceWord();
  FlutterTts flutterTts = FlutterTts();
  final Loading _loadings = Loading();
  final TextEditingController wordForSearch = TextEditingController();

  List<String> words = [];
  List<WordDetailModel> wordSearched = [];

  List<String> filterList() { 
    List<String> filteredList =
        words.where((word) => word.contains(wordForSearch.text)).toList();
    return filteredList;
  }

  Future<WordDetailModel?> getWordDetails(
      String word, BuildContext context) async {
    if (verifyCache(word, context)) {
    } else {
      final request = await _serviceWord.getWordDetails(word);
      if (request != null) {
        addToHistory(request);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WordDetailPage(
              word: request,
            ),
          ),
        );
      } else {
        SnackBarMessages.showNotFoundMessage(context, word);
      }
      return request;
    }
  }

  bool verifyCache(String word, BuildContext context) {
    bool haveCache = false;
    for (var i = 0; i < wordSearched.length; i++) {
      if (wordSearched[i].word == word) {
        haveCache = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WordDetailPage(
              word: wordSearched[i],
            ),
          ),
        );
      }
    }
    return haveCache;
  }

  Future<void> loadWordList() async {
    String jsonString =
        await rootBundle.loadString('lib/utils/words_dictionary.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    List<String> _words = jsonData.keys.toList();
    words = _words;
  }

  Future speakWord(BuildContext context) async {
    var result = await flutterTts.speak("Hello World");
  }

  void addToHistory(WordDetailModel wordDetail) async {
    if (!wordSearched.contains(wordDetail)) {
      wordSearched.add(wordDetail);
    }
  }

  Future<List<String>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String favoritesJson = prefs.getString('favorites') ?? "";
    if (favoritesJson != "") {
      List<dynamic> favoritesDynamic = jsonDecode(favoritesJson);
      List<String> favorites = favoritesDynamic.cast<String>();
      return favorites;
    } else {
      return [];
    }
  }

  Future<void> addToFavorites(String newFavorite, BuildContext context) async {
    List<String> favorites = await getFavorites();
    if (!favorites.contains(newFavorite)) {
      favorites.add(newFavorite);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String favoritesJson = jsonEncode(favorites);
      prefs.setString('favorites', favoritesJson);
      SnackBarMessages.showMessageAddFavorite(context);
    }
  }

  Future<void> removeFromFavorites(String word, BuildContext context) async {
    List<String> favorites = await getFavorites();
    if (favorites.contains(word)) {
      favorites.remove(word);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String favoritesJson = jsonEncode(favorites);
      prefs.setString('favorites', favoritesJson);
      SnackBarMessages.showMessageRemoveFavorite(context);
    }
  }
}
