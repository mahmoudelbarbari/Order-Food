import '../../domain/entities/register_entities.dart';

class RegisterAccountModel extends RegisterAccountEntity {
  RegisterAccountModel({
    String? idUser,
    String? username,
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
    String? message,
    int? replyCode,
  }) : super(
          idUser: idUser,
          username: username,
          email: email,
          gender: gender,
          name: name,
          phoneNumber: phoneNumber,
          message: message,
          replyCode: replyCode,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': idUser,
      'userName': username,
      'name': name,
      'email': email,
      'gender': gender,
      'phoneNumber': phoneNumber,
    };
  }

  factory RegisterAccountModel.fromMap(map) {
    if (map == null) {
      // Return a default instance or handle the null case accordingly
      return RegisterAccountModel();
    }

    print('Debugging fromMap:');
    print('idUser: ${map['idUser']}');
    print('userName: ${map['userName']}');
    print('email: ${map['email']}');
    print('gender: ${map['gender']}');
    print('name: ${map['name']}');
    print('phoneNumber: ${map['phoneNumber']}');
    return RegisterAccountModel(
      idUser: map['idUser'] ?? '',
      username: map['userName'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

  // factory RegisterAccountModel.fromMap(map) {
  //   print('Debugging fromMap:');
  //   print('idUser: ${map['idUser']}');
  //   print('userName: ${map['userName']}');
  //   print('email: ${map['email']}');
  //   print('gender: ${map['gender']}');
  //   print('name: ${map['name']}');
  //   print('phoneNumber: ${map['phoneNumber']}');

  //   return RegisterAccountModel(
  //     idUser: map['idUser'],
  //     username: map['userName'],
  //     email: map['email'],
  //     gender: map['gender'],
  //     name: map['name'],
  //     phoneNumber: map['phoneNumber'],
  //   );
  // }

  // factory RegisterAccountModel.fromEntity(RegisterAccountEntity entity) =>
  //     RegisterAccountModel(
  //       idUser: entity.idUser,
  //       username: entity.username,
  //       name: entity.name,
  //       email: entity.email,
  //       gender: entity.gender,
  //       phoneNumber: entity.phoneNumber,
  //     );
}
