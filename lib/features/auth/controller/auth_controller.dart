import 'package:application_for_restaurants/features/auth/screens/login_screen.dart';
import 'package:application_for_restaurants/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils.dart';
import '../repository/auth_repository.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());
final authControllerProvider = NotifierProvider<AuthController, bool>(() => AuthController());
class AuthController extends Notifier<bool>{
  AuthRepository get _repository => ref.read(authRepositoryProvider);
  @override
  build() {
    return false;
  }
  Future<void> userLogin({required String userName, required String password,required bool rememberMe,required BuildContext context}) async {
    state=true;
    var res=await _repository.userLogin(userName: userName, password: password, rememberMe: rememberMe);
    state=false;
    res.fold((l) => failureSnackBar(context,l.failure), (r) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
      successSnackBar(context, 'Login Success');
    });
  }
  Future<void> userLogOut({required BuildContext context}) async {
    state=true;
    var res=await _repository.userLogOut();
    state=false;
    res.fold((l) => failureSnackBar(context,l.failure), (r) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
      successSnackBar(context, 'Logout..');
    });
  }
}