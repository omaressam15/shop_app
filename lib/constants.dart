import 'package:shop_app/Dio/sherd_prefrens.dart';
import 'package:shop_app/LoginScreen/login_screen.dart';
import 'package:shop_app/components.dart';

void signOut(context)
{
  CacheHelper.removeData(key:'token',).
  then((value) {
    if(value)
    {
      navigateNoBack(LoginScreen(),context,);
    }
  });
}


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

 String token = '';

