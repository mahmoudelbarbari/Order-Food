import 'package:firebase_auth/firebase_auth.dart';
import 'package:order/core/database/firebase_db.dart';
import 'package:order/features/register/data/models/register_account_model.dart';
import 'package:order/features/register/domain/entities/register_entities.dart';

abstract class RemoteRegisterDatasource {
  Future<RegisterAccountEntity> remoteRegisterUser(String email,
      String password, RegisterAccountEntity registerAccountEntity);
  Future<List<RegisterAccountEntity>> getUserInfo();
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
  Future<List<RegisterAccountEntity>> getUserInfo() async {
    User? user = firebaseDB.auth.currentUser;
    List<RegisterAccountModel> loggedUser = [];
    await firebaseDB.firebaseFirestore
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedUser.add(RegisterAccountModel.fromMap(value.data()));
    });
    return loggedUser;
  }
}
