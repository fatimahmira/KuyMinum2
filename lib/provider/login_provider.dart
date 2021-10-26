import 'dart:convert';

import 'package:KuyMinum/config/view_state.dart';
import 'package:KuyMinum/provider/base_provider.dart';
import 'package:KuyMinum/service/Service.dart';
import 'package:KuyMinum/service/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends BaseProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User user = FirebaseAuth.instance.currentUser;
  AuthService _authService = AuthService();

  Future<bool> signInwithGoogle() async {
    try {
      setState(ViewState.Fetching);
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
      // print("user ${user.displayName}");
      setState(ViewState.Idle);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      setState(ViewState.Idle);
      return throw false;
    }
  }

  Future<bool> loginApi() async {
    try {
      setState(ViewState.Fetching);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var login = await signInwithGoogle();
      // prov.state == ViewState.Fetching;
      if (login == true) {
        print("google ok");
        Map dataRegister = {
          "email": user.email,
          "key": "mirakeling",
          "name": user.displayName,
          "password": user.email
        };
        Response res = await _authService.postLogin(dataRegister);
        print("res 1 ${res.data}");

        if(res.data["status"] == "trylogin"){
          res = await _authService.postLogin(dataRegister);
          print("res 2 "+ res.data);
        } else {
          print("masuk");
        }
        print("token = ${res.data["access_token"]}");
        await sharedPreferences.setString('token', res.data["access_token"]);
        setState(ViewState.Idle);

        return true;
      } else {
        return throw false;
      }
    } catch (e) {
      e.toString();
      return false;
    }
  }

  void loginCoba() async {
    try {
        // Map dataRegister = {
        //   "email": user.email,
        //   "key": "mirakeling",
        //   "name": user.displayName,
        //   "password": user.email
        // };
        Map dataRegister = {
          "email": "gagagaga@gmail.com",
          "key": "mirakeling",
          "name": "miraf",
          "password": "gagagaga@gmail.com"
        };
        Response res = await _authService.postLogin(dataRegister);
        print("res 1 $res");
        print("res 2 ${res.data["status"]}");
        if(res.data["status"] == "trylogin"){
          print("recall");
        } else {
          print("masuk");
        }

    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
