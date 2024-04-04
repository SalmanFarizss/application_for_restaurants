import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/globals.dart';
import '../../../core/utils.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordControllse=TextEditingController();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal:width*0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              "Reset your Password",
              style: TextStyle(
                  fontSize: width * .06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Form(
              key: _formKey1,
              child: SizedBox(
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
            ),
            SizedBox(
              height: height * 0.025,
            ),
            InkWell(
              onTap: ()  async {
                if(_formKey1.currentState!.validate()){
                  SharedPreferences prefs=await SharedPreferences.getInstance();
                  String? email=prefs.getString(emailController.text);
                  if(email==null){
                    failureSnackBar(context, 'The email is not registered');
                  }else{
                    showDialog(context: context, builder: (context) => AlertDialog(
                      title: Text('Enter your new Password'),
                      content: Form(
                        key: _formKey2,
                        child: SizedBox(
                          height: height * 0.08,
                          child: TextFormField(
                            cursorColor: Colors.orange,
                            autofillHints: const [AutofillHints.password],
                            controller: passwordControllse,
                            validator: (value) {
                              return validatePassword(value);
                            },
                            obscureText:false,
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
                            ),
                            style:TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: const Color(0xFF1D2429),
                              fontSize:width*0.035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, child: Text('Cancel')) ,
                        TextButton(onPressed: (){
                          if(_formKey2.currentState!.validate()){
                            prefs.setString(emailController.text, passwordControllse.text);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }
                        }, child: Text('Save'))
                      ],
                    ),);
                  }
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
    );
  }
}
