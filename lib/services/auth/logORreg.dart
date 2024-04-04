import 'package:f3/pages/login_pg.dart';
import 'package:f3/pages/rgstr.dart';
import 'package:flutter/material.dart';

class log_or_reg extends StatefulWidget{
  const log_or_reg({super.key});

  @override
  State<log_or_reg> createState() =>_log_or_regState();
}

class _log_or_regState extends State<log_or_reg>{
  //initially show the login page
  bool showLoginPage = true;

//toggle between login and register page
void togglePages(){
  setState(() {
    showLoginPage = !showLoginPage;
  });
}


@override
Widget build(BuildContext context){
  if(showLoginPage){
    return LoginPage(onTap: togglePages,);
  }
  else{
    return RegisterPage(onTap: togglePages,);
  }
}

}