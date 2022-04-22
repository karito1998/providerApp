import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:handyman_provider_flutter/auth/sign_in_screen.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/register_response.dart';
import 'package:handyman_provider_flutter/models/user_data.dart';
import 'package:handyman_provider_flutter/networks/rest_apis.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:handyman_provider_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthServices {
  Future<void> updateUserData(UserData user) async {
    userService.updateDocument({
      'player_id': getStringAsync(PLAYERID),
      'updatedAt': Timestamp.now(),
    }, user.uid);
  }

  Future<void> signUpWithEmailPassword(context, {required RegisterData registerData, bool isLogin = true}) async {
    //
    UserCredential? userCredential = await _auth.createUserWithEmailAndPassword(email: registerData.email.validate(), password: registerData.password.validate()).catchError((e) {
      log("Err ${e.toString()}");
    });
    if (userCredential.user != null) {
      User currentUser = userCredential.user!;
      String displayName = registerData.first_name.validate() + registerData.last_name.validate();

      UserData userModel = UserData();

      userModel.uid = currentUser.uid;
      userModel.email = currentUser.email;
      userModel.contactNumber = registerData.contact_number;
      userModel.firstName = registerData.first_name.validate();
      userModel.lastName = registerData.last_name.validate();
      userModel.username = registerData.username.validate();
      userModel.displayName = displayName;
      userModel.userType = registerData.user_type.validate();
      userModel.createdAt = Timestamp.now().toDate().toString();
      userModel.updatedAt = Timestamp.now().toDate().toString();
      userModel.playerId = getStringAsync(PLAYERID);

      setRegisterData(currentUser: currentUser, registerData: registerData, userModel: userModel, isLogin: isLogin);
    }
  }

  Future<void> setRegisterData({required User currentUser, RegisterData? registerData, required UserData userModel, bool isLogin = true}) async {
    await userService.addDocumentWithCustomId(currentUser.uid, userModel.toJson()).then((value) async {
      if (isLogin) {
        if (registerData != null) {
          var request = {
            UserKeys.email: registerData.email.validate(),
            UserKeys.password: registerData.password.validate(),
            UserKeys.playerId: getStringAsync(PLAYERID),
          };

          await loginUser(request).then((res) async {
            if (res.data != null) saveUserData(res.data!);

            push(SignInScreen(), isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
          }).catchError((e) {
            toast("Please Login Again");
            throw USER_CANNOT_LOGIN;
          });
        }
      } else {
        saveUserData(userModel);
        push(SignInScreen(), isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
      }
    }).catchError((e) {
      log(e.toString());

      throw USER_NOT_CREATED;
    });
  }

  Future<void> changePassword(String newPassword) async {
    await FirebaseAuth.instance.currentUser!.updatePassword(newPassword).then((value) async {
      await setValue(PASSWORD, newPassword);
    });
  }

  Future<void> signInWithEmailPassword(context, {required String email, required String password}) async {
    _auth.signInWithEmailAndPassword(email: email, password: password).then((value) async {
      final User user = value.user!;
      UserData userModel = await userService.getUser(email: user.email);
      await updateUserData(userModel);
    }).catchError((error) async {
      if (!await isNetworkAvailable()) {
        throw 'Please check network connection';
      }
      throw 'Enter valid email and password';
    });
  }
}
