import 'package:get/get.dart';

class Message extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US':{
        'hi':"Hi",
        'home':"Home",
        'favorite':"Favorite",
        'cart':"Cart",
        'more':"More",
        'language':"Language",
        'khmerLanguage':"Khmer Language",
        'englishLanguage':"English Language"
    },
    'km_KH':{
      'hi':"សួស្តី",
      'home':"ដើម",
      'favorite':"ចូលចិត្ត",
      'cart':"កន្រ្តក់",
      'more':"បន្ថែម",
      'language':"ភាសា",
      'khmerLanguage':"ភាសាខ្មែរ",
      'englishLanguage':"ភាសាអង់គ្លេស"
    }
  };

}