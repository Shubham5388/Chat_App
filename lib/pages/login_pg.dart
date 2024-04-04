import 'package:f3/services/auth/auth_service.dart';
import 'package:f3/pages/components/butt_log.dart';
import 'package:f3/pages/components/my_txtfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

 class LoginPage extends StatelessWidget{

final TextEditingController _emailController = TextEditingController();
final TextEditingController _pwController = TextEditingController();
//tap to go on sign up page (rgstr)
final void Function()? onTap;

void login(BuildContext context) async{
//auth service
final authService = AuthService();

//try login
try{
  await authService.signInWithEmailPassword(_emailController.text, _pwController.text,);
}
//catch error
catch (e){
  showDialog(context: context,
   builder: (context) => 
   AlertDialog(
     title: Text(e.toString())
   )
   );
}
}

   LoginPage ({super.key,required this.onTap});

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
  "Welcome Back!!",
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


//login button
MyButton(text: "Loigin",
onTap: ()=> login(context),),
const SizedBox(height: 20,),


//regstr
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
Text("Not a member? " , style: TextStyle(color: Theme.of(context).colorScheme.primary),),


GestureDetector(
  onTap: onTap,
  child: Text("Sign Up" , style: TextStyle(fontWeight: FontWeight.bold ,
  color: Theme.of(context).colorScheme.primary),),
),

],)


],),
)
    );
  }
 }