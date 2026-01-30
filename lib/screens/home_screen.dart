import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        backgroundColor: Colors.yellowAccent,
        title: Text('Whatsapp'),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
        centerTitle: true,

        actions: [
          Icon(Icons.search),
          PopupMenuButton(
            itemBuilder: (context) {
              return [PopupMenuItem(value: 'clicked', child: Text('One')),PopupMenuItem(value: 'clicked', child: Text('two'))];
            },
          ),
        ],

        actionsIconTheme: IconThemeData(color: Colors.black),
      ),

      drawer: Drawer(

        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Shoaib',style: TextStyle(color: Colors.white),),
              accountEmail: Text('shoaib@gmail.com',style: TextStyle(color: Colors.black),),

              currentAccountPicture: CircleAvatar(child: Icon(Icons.person,color: Colors.black,),backgroundColor: Colors.green,),
               decoration: BoxDecoration(
                 color: Colors.yellowAccent
               ),
            ),

            ListTile(
              leading: Icon(Icons.mail),
              title: Text('inbox'),
              onTap: () {
                print('Inbox clicked');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                print('Setting Clicked');
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              height: 450,
              width: 1000,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/main_baner.jpg'),fit: BoxFit.cover)
          ),
            ),


            Container(height: 400, width: 1000, color: Colors.amber),


            Container(height: 100, width: 1000, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
