import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_demo/facebook_login/service.dart';



class FireBaseModel{
 static Future<void> onTapFacebookLogin() async{
    // ignore: invalid_use_of_protected_member
//  state.setState(() {isLoading = true;});
    try{
      UserCredential? userCredential = await Service.signInWithFacebook();
      if(userCredential != null){
        print('FB Account Details --> ${userCredential.user!.email}');
        //  state.setState(() {isLoading = false;});
        //   Navigator.pushAndRemoveUntil(state.context,
        //     SlideLeftRoute(page: HomeScreen()), (route) => false,
        //   );
      }else{
        // ignore: invalid_use_of_protected_member
        // state.setState(() {isLoading = false;});
      }
    }catch(e){
      // ignore: invalid_use_of_protected_member
      // state.setState(() {isLoading = false;});
      print(e);
    }
  }
}


