// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../controllers/word_list_page_controller.dart';

class FavoriteWordsListPage extends StatefulWidget {
  const FavoriteWordsListPage({super.key});

  @override
  State<FavoriteWordsListPage> createState() => _FavoriteWordsListPageState();
}

class _FavoriteWordsListPageState extends State<FavoriteWordsListPage> {
  @override
  Widget build(BuildContext context) {
    final WordListPageController _pageController =
        GetIt.I.get<WordListPageController>();
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Favorites Words",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          FutureBuilder(
              future: _pageController.getFavorites(),
              builder: (context, connection) {
                if (connection.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  );
                } else if (connection.connectionState == ConnectionState.done &&
                    connection.data != null) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: _pageController.words.isEmpty
                          ? Text("The favorite word list is empty :(")
                          : ListView.builder(
                              itemCount: connection.data?.length,
                              itemBuilder: (context, index) {
                                String word = connection.data![index];
                                return InkWell(
                                  onTap: () {
                                    _pageController.getWordDetails(
                                        word, context);
                                  },
                                  child: SizedBox(
                                    height: 50,
                                    child: Card(
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              word,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () async {
                                                await _pageController
                                                    .removeFromFavorites(
                                                        word, context);
                                                setState(() {});
                                              },
                                              alignment: Alignment.center,
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 25,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  );
                } else
                  return Container();
              }),
        ],
      ),
    );
  }
}
