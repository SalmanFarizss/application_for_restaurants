import 'package:application_for_restaurants/core/typedef.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository{
  AuthRepository();
  FutureVoid userLogin({required String userName, required String password,required bool rememberMe}) async {
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      String? storedPass=prefs.getString(userName);
      if(storedPass==null){
        prefs.setString(userName, password);
        if(rememberMe){
          prefs.setString('remembered', userName);
        }
      }else{
        if(storedPass==password){
          if(rememberMe){
            prefs.setString('remembered', userName);
          }
        }else{
          throw 'Invalid Password';
        }
      }
      return right('');
    }catch(e){
      return left(Failure(failure: e.toString()));
    }
  }
  FutureVoid userLogOut() async {
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.remove('remembered');
       return right('');
    }catch(e){
      return left(Failure(failure: e.toString()));
    }
  }
}