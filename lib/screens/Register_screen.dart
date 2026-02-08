import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ws_cube/screens/Register_screen.dart';
import 'package:ws_cube/screens/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen ({super.key});

  TextEditingController  namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller =TextEditingController();


  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wd = MediaQuery.of(context).size.width;

    Future< void> Register() async{

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailcontroller.text, password: passwordcontroller.text);

        await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).set(
            {
              'name' : namecontroller.text,
              'email' : emailcontroller.text,
              'createdAt' : FieldValue.serverTimestamp(),

            });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Resgitser Succefull')));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()) );

      }
      catch(e) {
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
      }






    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: ht *1,
            width: wd *1,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/primaryBg.png'),fit: BoxFit.cover)
            ),
            child:Align(
              alignment: Alignment(-0.8, -0.9),
              child:  Text('Register',style: GoogleFonts.oswald(fontSize: 40,color: Colors.white,letterSpacing: 1,fontWeight: FontWeight.bold),),
            ) ,
          ),
          Align(
            alignment: Alignment.bottomCenter,

            child: Container(
              height: ht * 0.86,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,

            child: Container(
              height: ht * 0.83,
              width: wd *0.95,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
              ),

              child: Padding(

                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40,),
                    Text('Name',style: GoogleFonts.oswald(color: Colors.black,fontSize: 19,letterSpacing: 1),),
                    TextField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Enter Your Name',
                        hintStyle: GoogleFonts.oswald(color: Colors.black),
                      ),

                    ),
                    SizedBox(height: 20,),
                    Text('Email',style: GoogleFonts.oswald(color: Colors.black,fontSize: 19,letterSpacing: 1),),
                    TextField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        hintText: 'Enter Your Email',
                        hintStyle: GoogleFonts.oswald(color: Colors.black),
                      ),

                    ),
                    SizedBox(height: 40,),
                    Text('Password',style: GoogleFonts.oswald(color: Colors.black,fontSize: 19,letterSpacing: 1),),
                    TextField(
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_open),
                        hintText: 'Enter Your Password',
                        hintStyle: GoogleFonts.oswald(color: Colors.black),
                      ),

                    ),
                SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        Register();
                      },
                      child: Container(
                        width: wd *0.3,
                        height: ht *0.08,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),

                              bottomLeft: Radius.circular(40)
                          ),
                        ),


                        child: Text('Register',style: GoogleFonts.oswald(color: Colors.white,fontSize: 21,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SizedBox(height: 4,),
                    Divider(
                      color: Colors.green,
                      thickness: 2,
                    ),
                    SizedBox(height: 6,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: wd* 0.2,
                          height: ht *0.1,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/icon_apple.png'))
                          ),

                        ),
                        SizedBox(width: 1,),
                        Text('OR',style: GoogleFonts.oswald(color: Colors.green,fontSize: 18),),
                        Container(
                          width: wd* 0.2,
                          height: ht *0.1,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/icon_google.png'))
                          ),

                        ),

                      ],


                    ),
                    SizedBox(height: 10,),
                    Container(
                        alignment: Alignment.center,
                        child:  Text('v1.0.0 | Developed by Shoaib khan',style: GoogleFonts.oswald(color: Colors.black,fontSize: 8),)
                    )

                  ],

                ),
              ),
            ),
          )
        ],
      ),

    );
  }
}