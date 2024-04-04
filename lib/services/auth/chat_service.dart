import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f3/module/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService{
  //get instance of firestore
final FirebaseFirestore _firestore =FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream
Stream<List<Map<String,dynamic>>> getUsersStream(){
return _firestore.collection("Users").snapshots().map((snapshot)  {
  return snapshot.docs.map((doc) {
    //go through each individual user
    final user = doc.data();

    return user;
  }).toList();
});
}

  //send message
Future <void> sendMessage(String recieverId,message) async{
//get current user info
final String currentUserID = _auth.currentUser!.uid;
final String currentUserEmail=_auth.currentUser!.email!;
final Timestamp timestamp = Timestamp.now();

//create a new message
Message newMessage = Message(senderID: currentUserID
, senderEmail: currentUserEmail,
 recieverID: currentUserID, 
 message: message, 
 timestamp: timestamp);


//construct chat room ID for the 2 users (Sorted to ensure uniquness)
List<String> ids = [currentUserID,recieverId];
ids.sort();
String chatRoomID = ids.join('_');

//add new message to the database
await _firestore
.collection("chat_rooms")
.doc(chatRoomID)
.collection("messages")
.add(newMessage.toMap());
}


  //get message

Stream<QuerySnapshot>getMessages(String userID,otherUserID) {
//construct chat room ID for the 2 users (Sorted to ensure uniquness)
List<String> ids = [ userID,otherUserID];
ids.sort();
String chatRoomID = ids.join('_');

//add new message to the database
return _firestore
.collection("chat_rooms")
.doc(chatRoomID)
.collection("messages")
.orderBy("timestamp",descending: false)
.snapshots();


}


}