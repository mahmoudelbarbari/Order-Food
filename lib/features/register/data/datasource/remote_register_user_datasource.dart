import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:order/core/database/firebase_db.dart';
import 'package:order/features/register/data/models/register_account_model.dart';
import 'package:order/features/register/domain/entities/register_entities.dart';

abstract class RemoteRegisterDatasource {
  Future<RegisterAccountEntity> remoteRegisterUser(String email,
      String password, RegisterAccountEntity registerAccountEntity);
  Future<RegisterAccountModel> getUserInfo();
}

class RemoteRegisterDatasourceImlp implements RemoteRegisterDatasource {
  late FirebaseDatabseProvider firebaseDB;

  String? idUser;
  RemoteRegisterDatasourceImlp(this.firebaseDB);
  @override
  Future<RegisterAccountEntity> remoteRegisterUser(String email,
      String password, RegisterAccountEntity registerAccountEntity) async {
    try {
      final userData = await firebaseDB.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await firebaseDB.firebaseFirestore.collection("Users").doc().set({
        "idUser": userData.user!.uid,
        "email": userData.user!.email,
        "gender": registerAccountEntity.gender,
        "name": registerAccountEntity.name,
        "phoneNumber": registerAccountEntity.phoneNumber,
        "userName": registerAccountEntity.username,
      });

      return RegisterAccountEntity(
          idUser: idUser,
          email: email,
          gender: registerAccountEntity.gender,
          name: registerAccountEntity.name,
          phoneNumber: registerAccountEntity.phoneNumber,
          username: registerAccountEntity.username,
          message: registerAccountEntity.message);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          RegisterAccountEntity(
              message: "Your email address appears to be malformed.");
          break;
        case "wrong-password":
          RegisterAccountEntity(message: "Your password is wrong.");
          break;
        case "user-not-found":
          RegisterAccountEntity(message: "User with this email doesn't exist.");
          break;
        case "user-disabled":
          RegisterAccountEntity(
              message: "User with this email has been disabled.");
          break;
        case "too-many-requests":
          RegisterAccountEntity(message: "Too many requests");
          break;
        case "operation-not-allowed":
          RegisterAccountEntity(
              message: "Signing in with Email and Password is not enabled.");
          break;
        default:
          RegisterAccountEntity(message: "An undefined Error happened.");
      }
    } catch (e) {
      return RegisterAccountEntity(message: e.toString());
    }
    return RegisterAccountEntity(message: "server error", replyCode: 500);
  }

  @override
  Future<RegisterAccountModel> getUserInfo() async {
    User? getCurrentUser = firebaseDB.auth.currentUser;
    try {
      DocumentSnapshot userSnapshot = await firebaseDB.firebaseFirestore
          .collection("Users")
          .doc(getCurrentUser!.uid)
          .get();

      if (userSnapshot.exists) {
        RegisterAccountModel registerAccountModel =
            RegisterAccountModel.fromMap(userSnapshot.data());
        if (kDebugMode) {
          print("user data ${registerAccountModel.name}");
        }
        return registerAccountModel; // Return the retrieved model
      } else {
        return RegisterAccountModel(message: 'User not found', replyCode: 404);
      }
    } catch (e) {
      return RegisterAccountModel(message: e.toString(), replyCode: 500);
    }
  }

  // @override
  // Future<RegisterAccountModel> getUserInfo() async {
  //   User? getCurrentUser = firebaseDB.auth.currentUser;
  //   try {
  //     RegisterAccountModel registerAccountModel = RegisterAccountModel();
  //     await firebaseDB.firebaseFirestore
  //         .collection("Users")
  //         .doc(getCurrentUser!.uid)
  //         .get()
  //         .then((value) {
  //       registerAccountModel = RegisterAccountModel.fromMap(value.data());
  //       if (kDebugMode) {
  //         print("user data ${registerAccountModel.name}");
  //       }
  //     });
  //     return RegisterAccountModel(
  //         message: 'Profile info retrive success', replyCode: 200);
  //   } catch (e) {
  //     return RegisterAccountModel(message: e.toString(), replyCode: 500);
  //   }
  // }
}
