import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_demo/facebook_login/service.dart';



class FireBaseModel{
 static Future<void> onTapFacebookLogin() async{
    // ignore: invalid_use_of_protected_member
//  state.setState(() {isLoading = true;});
    try{
      UserCredential? userCredential = await Service.signInWithFacebook();
      print('FB Account Details --> ${userCredential!.user!.email}');
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
//
// onTapFacebookLogin(context) async {
//   try {
//     UserCredential userCredential = await authServices.signInWithFacebook();
//     if (userCredential != null) {
//       Toast.show('Sign in Successfully', context,
//           backgroundColor: ColorsRes.black,
//           textColor: ColorsRes.white,
//           duration: 5);
//       print('FB Account Details');
//     } else {
//       print('else-->>');
//     }
//   } catch (e) {
//     Toast.show(e.toString(), context,
//         backgroundColor: ColorsRes.black,
//         textColor: ColorsRes.white,
//         duration: 5);
//     print("catch --->>${e.toString()}");
//   }
// }

