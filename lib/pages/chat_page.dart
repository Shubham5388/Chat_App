import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f3/pages/components/chat_bubble.dart';
import 'package:f3/pages/components/my_txtfield.dart';
import 'package:f3/services/auth/auth_service.dart';
import 'package:f3/services/auth/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget{
  final String recieverEmail;
  final String recieverID;
   const ChatPage({super.key,
  required this.recieverEmail,
  required this.recieverID  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
//text controller
final TextEditingController _messageController =TextEditingController();

//chat and auth services
final ChatService _chatService = ChatService();
final AuthService _authService = AuthService();

//textfield focus
FocusNode myFocusNode = FocusNode();

@override
  void initState() {
    super.initState();

//add listener to focus mode
myFocusNode.addListener(() {
  //cause a delay so that a keyboard have a time to showup
  //then the amount of space will be calculated
  //then scroll down
  Future.delayed(
    const Duration(microseconds:500),
    ()=> scrollDown(),
    );

});


//wait for a bit list view to built then scroll to bottom
Future.delayed(
  const Duration(milliseconds: 500),
  ()=>scrollDown(),
);

  }





@override
void dispose()
{
  myFocusNode.dispose();
  _messageController.dispose();
  super.dispose();
}

//scroll controller
final ScrollController _scrollController = ScrollController();
void scrollDown(){
  _scrollController.animateTo(_scrollController.position.maxScrollExtent, 
  duration: const Duration(seconds: 1), 
  curve: Curves.fastOutSlowIn);
}




//send message
void sendMessage() async{
  //if theres something inside the textfield
  if(_messageController.text.isNotEmpty){
    //send message
    await _chatService.sendMessage(widget.recieverID, _messageController.text);

    //clear text controller
    _messageController.clear();
  }
  scrollDown();
}

  @override
  Widget build(BuildContext context) {

return Scaffold(
  appBar: AppBar(
    title: Text(widget.recieverEmail),
  ),
   
    body : Column(children: [
//display all messsages 
Expanded(child : _buildMessageList()),


// user input
_buildUserInput(),
      
    ],)
);

  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(stream: _chatService.getMessages(widget.recieverID, senderID)
    , builder: (context,snapshot){
//errors
if(snapshot.hasError){
  return const Text("error");
}
//loading
if(snapshot.connectionState ==ConnectionState.waiting){
  return const Text("loading..");
}

//return list view
return ListView(
  controller: _scrollController,
  children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
);

    }
    );
  }

//build mesage item
Widget _buildMessageItem(DocumentSnapshot doc) {
Map<String,dynamic> data = doc.data() as Map<String,dynamic>;

//IS Current user
bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

//align message to right if sender is current user
var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;


return  Container(
  alignment: alignment,
  child: ChatBubble(message: data["message"],isCurrentUser: isCurrentUser,));
}

//build message input 
Widget _buildUserInput(){
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        //textfield should take most of the space
    
        Expanded(child: MyTextField(
          controller: _messageController ,
          hintText: "Type a message",
          ObscureText: false,
          focusNode: myFocusNode,
          ),
          ),
    
          //send button
          Container(decoration: BoxDecoration(color: Colors.green,shape: BoxShape.circle),
          child: IconButton(onPressed: sendMessage, icon: const Icon(Icons.send,color:Colors.white,) 
          )
          ),
    
    
      ],
    ),
  );
}
}