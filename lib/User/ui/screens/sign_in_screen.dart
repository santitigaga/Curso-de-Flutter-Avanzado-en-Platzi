import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import 'package:platzi_trips_app/platzi_trips_cupertino.dart';
import 'package:platzi_trips_app/widgets/button_green.dart';
import 'package:platzi_trips_app/widgets/gradient_back.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInScreen();
  }
}

class _SignInScreen extends State {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() {
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //snapshot data - Object user
        if (snapshot.hasData ) {
          return PlatziTripsCupertino();
        } else if (snapshot.hasError) {
          return Text("Ocurrio un error en la trasmision de datos");
        } else if(snapshot.connectionState != ConnectionState.waiting) {
            return SignInGoogleUI();
          }else{
          return Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 20,
                      width: 70,
                      child: CircularProgressIndicator(backgroundColor: Colors.cyan[400], )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text("C a r g a n d o", style: TextStyle(color: Colors.blue[400], fontSize: 22, fontFamily: "Lato", decoration: TextDecoration.none)
                    ),)
                ]
            ),
          );
        }
      },
        );
  }

  Widget SignInGoogleUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack("", null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome. \n This is you Travel App",
                style: TextStyle(
                    fontSize: 37.0,
                    fontFamily: "Lato",
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              ButtonGreen(
                  text: "Sign In with Gmail",
                  onPressed: () => userBloc.signIn().then((FirebaseUser user) =>
                      print("El usuario es ${user.displayName}")),
                  width: 300.0,
                  height: 50.0)
            ],
          )
        ],
      ),
    );
  }
}
