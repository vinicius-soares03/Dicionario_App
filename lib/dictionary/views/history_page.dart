import 'package:dicionario_app/dictionary/views/word_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controllers/word_list_page_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
            "History",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: _pageController.wordSearched.isEmpty
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text("No word searched."))
                  : ListView.builder(
                      itemCount: _pageController.wordSearched.length,
                      itemBuilder: (context, index) {
                        String word =
                            _pageController.wordSearched[index].word ?? "";
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WordDetailPage(
                                  word: _pageController.wordSearched[index],
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 50,
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  word,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}
