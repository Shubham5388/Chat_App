
import 'package:f3/pages/chat_page.dart';
import 'package:f3/pages/components/user_tile.dart';
import 'package:f3/services/auth/auth_service.dart';
import 'package:f3/pages/components/my_drawer.dart';
import 'package:f3/services/auth/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
   HomePage({super.key});
//chat and auth services
final ChatService _chatService = ChatService();
final AuthService _authService = AuthService();



void logout() {
  //get auth service
  final auth =AuthService();
  auth.signOut();

}

  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(title: const Text("Home"),
  actions: [
    //logout button
    IconButton(onPressed: logout, icon: const Icon(Icons.logout))
  ],
  ),
drawer: const MyDrawer(),
body: _buildUserList(),
);
  }



Widget _buildUserList(){
return StreamBuilder(stream: _chatService.getUsersStream(),
 builder: (context,snapshot){
  // error
if(snapshot.hasError){
  return const Text("error");
}


  //loading
  if(snapshot.connectionState == ConnectionState.waiting){
    return const Text("Loading...");
  }

  // return list view
  return ListView(
    children: snapshot.data!.map<Widget>((userData)=>_buildUserListItem(userData,context)).toList(),
  );
 },
 );
}




//build individual list tile for user
Widget _buildUserListItem(Map<String,dynamic> userData,BuildContext context){
  //display all users except current users
if(userData["email"]!=_authService.getCurrentUser()!.email){
  return UserTile(text: userData["email"],
onTap: (){
  //tap on a user -> go to chat page
  Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(
    recieverEmail: userData["email"],
    recieverID: userData["uid"],
  ),
  ),
  );
},
);
}
else{
  return Container();
}

}
}