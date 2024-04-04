
import 'package:f3/services/auth/auth_service.dart';
import 'package:f3/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget{
  const MyDrawer({super.key});

void logout() {
  //get auth service
  final _auth =AuthService();
  _auth.signOut();

}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor : Theme.of(context).colorScheme.background,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Column(children: [

              //logo
DrawerHeader(child: Center(child: Icon(Icons.message,color: Theme.of(context).colorScheme.primary,
size: 40,),),),


            //home list tile
Padding(padding: const EdgeInsets.only(left: 25.0),
child:
ListTile(title: Text("HOME") ,
leading: Icon(Icons.home),
onTap: () {
Navigator.pop(context);
},
)
),


            //setings tile
Padding(padding: const EdgeInsets.only(left: 25.0),
child:
ListTile(title: Text("SETTING") ,
leading: Icon(Icons.settings),
onTap: () {
Navigator.pop(context);
Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage(),
),
);

},
)
),
   ],),


 /////////////////////logout list tile
Padding(padding: const EdgeInsets.only(left: 25.0),
child:
ListTile(title: Text("LOGOUT") ,
leading: Icon(Icons.logout),
onTap: logout,
)
),

        ],
      )
    );
  }
}