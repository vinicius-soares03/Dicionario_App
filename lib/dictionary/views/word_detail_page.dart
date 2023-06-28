import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';

import '../controllers/word_list_page_controller.dart';
import '../models/word_detail_model.dart';

class WordDetailPage extends StatefulWidget {
  WordDetailModel? word;

  WordDetailPage({Key? key, required this.word});

  @override
  State<WordDetailPage> createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  final WordListPageController _pageController =
      GetIt.I.get<WordListPageController>();
  final FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    super.initState();
    initTts();
  }

  Future<void> initTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.1);
    await flutterTts.setVolume(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
        "Word Detail",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        InkWell(
          onTap: () async {
            _pageController.addToFavorites(widget.word!.word!, context);
          },
          child: Container(
            margin: EdgeInsets.only(right: 8),
            child: const Icon(Icons.favorite_border),
          ),
        )
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 32),
        child: Column(
          children: [
            _buildWordPronunciation(),
            _buildMeanings(),
          ],
        ),
      ),
    );
  }

  Widget _buildWordPronunciation() {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .3,
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            border: Border.all(color: Colors.black, width: 1.0)),
        child: RichText(
          text: TextSpan(
            text: "",
            style: const TextStyle(color: Colors.black, fontSize: 18),
            children: [
              TextSpan(text: "${widget.word?.word ?? ""} \n"),
              TextSpan(text: "${widget.word?.pronunciation?.all ?? ""}")
            ],
          ),
        ),
      ),
    );
  }

  _buildMeanings() {
    if (widget.word != null && widget.word!.results!.isNotEmpty) {
      Result wordDetail = widget.word!.results!.first;

      return Container(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Meanings",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8,top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildText("Definition: ", wordDetail.definition),
                      _buildText("Typeof: ", wordDetail.typeOf?.join(", ")),
                      _buildText(
                          "Derivation: ", wordDetail.derivation?.join(", ")),
                      _buildText("Examples: ", wordDetail.examples?.join(", ")),
                      _buildText("Syllables: ",
                          widget.word?.syllables?.list?.join(", ")),
                    ],
                  )),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  RichText _buildText(String? name, String? value) {
    return RichText(
        text: TextSpan(
      text: name,
      style: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      children: [
        TextSpan(
          text: "$value\n",
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
        )
      ],
    ));
  }
}
