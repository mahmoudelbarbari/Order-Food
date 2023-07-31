import 'package:firebase_auth/firebase_auth.dart';
import 'package:order/core/database/firebase_db.dart';
import 'package:order/features/login/domain/entities/account_entites.dart';
import 'package:order/features/register/data/models/register_account_model.dart';
import 'package:order/features/register/domain/entities/register_entities.dart';

abstract class RemoteRegisterDatasource {
  Future<RegisterAccountEntity> remoteRegisterUser(String email,
      String password, RegisterAccountEntity registerAccountEntity);
  Future<LoginBaseResponse> getUserInfo(
      RegisterAccountModel registerAccountModel);
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
      if (e.code == 'weak-password') {
        return RegisterAccountEntity(message: e.message);
      } else if (e.code == 'email-already-in-use') {
        return RegisterAccountEntity(message: e.message);
      }
    } catch (e) {
      return RegisterAccountEntity(message: e.toString());
    }
    return RegisterAccountEntity(message: "server error", replyCode: 500);
  }

  @override
  Future<LoginBaseResponse> getUserInfo(
      RegisterAccountModel registerAccountModel) async {
    try {
      final user = firebaseDB.auth.currentUser;
      await firebaseDB.firebaseFirestore
          .collection("Users")
          .doc(user!.uid)
          .get()
          .then((value) {
        RegisterAccountModel.fromMap(value.data()!);
      });
      LoginBaseResponse(
          status: true, message: "Fetching the user info is Done!");
    } catch (e) {
      LoginBaseResponse(status: false, message: e.toString());
    }
    return LoginBaseResponse(status: false, message: "Server Error");
  }
}
