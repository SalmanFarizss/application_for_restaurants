import 'package:application_for_restaurants/features/auth/controller/auth_controller.dart';
import 'package:application_for_restaurants/features/auth/screens/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/globals.dart';
import '../../../core/utils.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final visibleProvider = StateProvider<bool>((ref)=>false);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool check = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(authControllerProvider);
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: CircleAvatar(backgroundColor: Colors.orange),
              )
            : Padding(
                padding: EdgeInsets.all(width * .1),
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height:height*0.28,
                              child: Image.asset('assets/images/login_image.png',fit: BoxFit.cover,)),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text(
                            "Log In \nyour account",
                            style: TextStyle(
                                fontSize: width * .06,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          SizedBox(
                            height: height * 0.08,
                            child: TextFormField(
                              cursorColor: Colors.orange,
                              autofillHints: const [AutofillHints.name],
                              validator: (value) {
                                return  validateEmail(value);
                              },
                              controller: emailController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Username/Email',
                                labelStyle: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: const Color(0xFF57636C),
                                  fontSize: width*0.035,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: 'Please Enter Username/Email',
                                hintStyle: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: const Color(0xFF57636C),
                                  fontSize: width*0.035,
                                  fontWeight: FontWeight.normal,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color:Colors.orange,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.only(top: height*0.015,left: width*0.05),
                              ),
                              style:TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: const Color(0xFF1D2429),
                                fontSize: width*0.035,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          SizedBox(
                            height: height * 0.08,
                            child: Consumer(
                              builder: (context,ref,child) {
                                bool isVisible=ref.watch(visibleProvider);
                                return TextFormField(
                                  cursorColor: Colors.orange,
                                  autofillHints: const [AutofillHints.password],
                                  controller: passwordController,
                                  validator: (value) {
                                    return validatePassword(value);
                                  },
                                  obscureText: !isVisible,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: const Color(0xFF57636C),
                                      fontSize:width*0.035,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    hintText: 'Please Enter Password',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: const Color(0xFF57636C),
                                      fontSize: width*0.035,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.orange,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color:Colors.orange,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.orange,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.orange,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.only(top: height*0.015,left: width*0.05),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        ref.read(visibleProvider.notifier).update((state) => !state);
                                      },
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        isVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: const Color(0xFF757575),
                                        size: width*0.04,
                                      ),
                                    ),
                                  ),
                                  style:TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: const Color(0xFF1D2429),
                                    fontSize:width*0.035,
                                    fontWeight: FontWeight.normal,
                                  ),
                                );
                              }
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: height * 0.01,
                                    width: width * 0.05,
                                    child: Transform.scale(
                                      scale: 1,
                                      child: Checkbox(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                width * .01)),
                                        side: BorderSide(width: width * 0.002),
                                        value: check,
                                        onChanged: (value) {
                                          setState(() {
                                            check = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Remember me",
                                    style: TextStyle(
                                        fontSize: width * .032,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword(),)),
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      fontSize: width * .03,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.08,
                          ),
                          InkWell(
                            onTap: () {
                           if (_formKey.currentState!.validate()) {
                             ref
                                 .read(authControllerProvider.notifier)
                                 .userLogin(
                                 userName: emailController.text,
                                 password: passwordController.text,
                                 rememberMe: check,
                                 context: context);
                             emailController.clear();
                             passwordController.clear();
                             check=false;
                           }
                            },
                            child: Container(
                              height: height * 0.06,
                              width: width * 0.8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: width * .04,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
