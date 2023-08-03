import '../../domain/entities/register_entities.dart';

class RegisterAccountModel extends RegisterAccountEntity {
  RegisterAccountModel({
    String? idUser,
    String? username,
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
  }) : super(
          idUser: idUser,
          username: username,
          email: email,
          gender: gender,
          name: name,
          phoneNumber: phoneNumber,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': idUser,
      'username': username,
      'name': name,
      'email': email,
      'gender': gender,
      'phoneNumber': phoneNumber,
    };
  }

  factory RegisterAccountModel.fromMap(map) {
    return RegisterAccountModel(
      idUser: map['id'],
      username: map['username'],
      name: map['name'],
      email: map['email'],
      gender: map['gender'],
      phoneNumber: map['phoneNumber'],
    );
  }

  factory RegisterAccountModel.fromEntity(RegisterAccountEntity entity) =>
      RegisterAccountModel(
        idUser: entity.idUser,
        username: entity.username,
        name: entity.name,
        email: entity.email,
        gender: entity.gender,
        phoneNumber: entity.phoneNumber,
      );
}
