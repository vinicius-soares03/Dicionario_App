// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:dicionario_app/dictionary/controllers/word_list_page_controller.dart';
import 'package:dicionario_app/dictionary/models/word_detail_model.dart';
import 'package:dicionario_app/dictionary/views/favorite_words_list_page.dart';
import 'package:dicionario_app/dictionary/views/word_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import 'history_page.dart';

class WordListPage extends StatefulWidget {
  const WordListPage({super.key});

  @override
  State<WordListPage> createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {
  final WordListPageController _pageController =
      GetIt.I.get<WordListPageController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Dictionary",
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          child: Column(
            children: [
              _returnTabbar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _returnTabbar() {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      // height: MediaQuery.of(context).size.height,
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            ButtonsTabBar(
              backgroundColor: Colors.blue,
              buttonMargin: const EdgeInsets.only(left: 8, right: 8),
              contentPadding: EdgeInsets.all(8),
              unselectedBackgroundColor: Colors.grey,
              tabs: [
                const Tab(
                  text: 'Word List',
                ),
                const Tab(
                  text: 'History',
                ),
                const Tab(
                  text: 'Favorites',
                ),
              ],
            ),
            Container(
              height: 800,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              child: TabBarView(
                children: [
                  _returnWordList(),
                  HistoryPage(),
                  FavoriteWordsListPage()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _returnWordList() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Word List",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 1.2,
              height: 35,
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _pageController.wordForSearch,
                cursorColor: Colors.transparent,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search a word...",
                  contentPadding: EdgeInsets.only(left: 8),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                ),
                onEditingComplete: () {
                  _pageController.filterList();
                },
              ),
            ),
          ),
          FutureBuilder(
              future: _pageController.loadWordList(),
              builder: (context, connection) {
                if (connection.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  );
                } else if (connection.connectionState == ConnectionState.done) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: _pageController.words.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              child: Text("The word list is empty :("),
                            )
                          : ResponsiveGridList(
                              maxItemsPerRow: 2,
                              minItemWidth: 100,
                              listViewBuilderOptions: ListViewBuilderOptions(
                                  controller: ScrollController()),
                              children:
                                  _pageController.filterList().map((word) {
                                return InkWell(
                                  onTap: () async {
                                    final request = await _pageController
                                        .getWordDetails(word, context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Card(
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          word,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
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
