import 'package:dicionario_app/dictionary/controllers/word_list_page_controller.dart';
import 'package:get_it/get_it.dart';

class Inject {

  static initialize() {
    GetIt getIt = GetIt.instance;
  
    //CONTROLLERS
    getIt.registerLazySingleton<WordListPageController>(() => WordListPageController());

  }
}