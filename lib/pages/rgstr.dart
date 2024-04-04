import 'package:f3/services/auth/auth_service.dart';
import 'package:f3/pages/components/butt_log.dart';
import 'package:f3/pages/components/my_txtfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget{
final TextEditingController _emailController = TextEditingController();
final TextEditingController _pwController = TextEditingController();
final TextEditingController _cpwController = TextEditingController();

//tap to go on login page (login)
final void Function()? onTap;

RegisterPage({super.key,required this.onTap});

void register(BuildContext context) { 
//auth service
final _auth = AuthService();
 
if(_pwController.text == _cpwController.text){
  try{
  _auth.signUpWithEmailPassword(_emailController.text, _pwController.text);
}
catch (e){
   showDialog(context: context,
   builder: (context) => 
   AlertDialog(
     title: Text(e.toString())
   ),
   );
}
}

else{
  showDialog(context: context,
   builder: (context) => const AlertDialog(
     title: Text("password dont match")
   )
   );
}


}


  @override
  Widget build(BuildContext context){
return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
  children: [
//logo
Icon(Icons.message,
size: 60,
color: Theme.of(context).colorScheme.primary,),

const SizedBox(height: 50),

//welc bck msg
Text(
  "Lets create a new account!!",
  style: TextStyle(
    color: Theme.of(context).colorScheme.primary,
    fontSize: 16
  ),),

const SizedBox(height: 50),

//email
MyTextField(hintText: "Email",ObscureText: false,controller: _emailController,),

const SizedBox(height: 10,),
//pw textfield
MyTextField(hintText: "Password",ObscureText: true,controller: _pwController,),
const SizedBox(height: 25,),

const SizedBox(height: 10,),
//confirm_pw textfield
MyTextField(hintText: "Confirm Password",ObscureText: true,controller: _cpwController,),
const SizedBox(height: 25,),

//login button
MyButton(text: "Register",
onTap: ()=> register(context),),


const SizedBox(height: 20,),


//regstr
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
Text("Already member? " , style: TextStyle(color: Theme.of(context).colorScheme.primary),),

GestureDetector(
  onTap: onTap,
  child: Text("Login" , style: TextStyle(fontWeight: FontWeight.bold ,
  color: Theme.of(context).colorScheme.primary),),
),

],)


],),
)
    );  }

}