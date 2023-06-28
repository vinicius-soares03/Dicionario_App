import 'package:flutter/material.dart';

class SnackBarMessages {



  static void showNotFoundMessage(BuildContext context, String word) {
    final snackBar = SnackBar(
      content: Text(' Word "$word" not found.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static void showMessageAddFavorite(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Saved in favorites.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


    static void showMessageRemoveFavorite(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Removed from favorites.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
