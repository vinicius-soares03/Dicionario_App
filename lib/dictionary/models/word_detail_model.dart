class WordDetailModel {
  String? word;
  List<Result>? results;
  Syllables? syllables;
  Pronunciation? pronunciation;
  double? frequency;

  WordDetailModel({
    this.word,
    this.results,
    this.syllables,
    this.pronunciation,
    this.frequency,
  });

  factory WordDetailModel.fromJson(Map<String, dynamic> json) {
    return WordDetailModel(
      word: json['word'],
      results: json['results'] != null
          ? List<Result>.from(json['results'].map((x) => Result.fromJson(x)))
          : null,
      syllables: json['syllables'] != null
          ? Syllables.fromJson(json['syllables'])
          : null,
      pronunciation: json['pronunciation'] != null
          ? Pronunciation.fromJson(json['pronunciation'])
          : null,
      frequency: json['frequency'],
    );
  }
}

class Result {
  String? definition;
  String? partOfSpeech;
  List<String>? synonyms;
  List<String>? typeOf;
  List<String>? hasTypes;
  List<String>? derivation;
  List<String>? examples;

  Result({
    this.definition,
    this.partOfSpeech,
    this.synonyms,
    this.typeOf,
    this.hasTypes,
    this.derivation,
    this.examples,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      definition: json['definition'],
      partOfSpeech: json['partOfSpeech'],
      synonyms: json['synonyms'] != null
          ? List<String>.from(json['synonyms'])
          : null,
      typeOf: json['typeOf'] != null ? List<String>.from(json['typeOf']) : null,
      hasTypes:
      json['hasTypes'] != null ? List<String>.from(json['hasTypes']) : null,
      derivation: json['derivation'] != null
          ? List<String>.from(json['derivation'])
          : null,
      examples: json['examples'] != null
          ? List<String>.from(json['examples'])
          : null,
    );
  }
}

class Syllables {
  int? count;
  List<String>? list;

  Syllables({
    this.count,
    this.list,
  });

  factory Syllables.fromJson(Map<String, dynamic> json) {
    return Syllables(
      count: json['count'],
      list: json['list'] != null ? List<String>.from(json['list']) : null,
    );
  }
}

class Pronunciation {
  String? all;

  Pronunciation({
    this.all,
  });

  factory Pronunciation.fromJson(Map<String, dynamic> json) {
    return Pronunciation(
      all: json['all'],
    );
  }
}
