class UserModel {
  String? name;
  String? email;
  String? role;
  String? uid;
  int? phonenumber;

// receiving data
  UserModel({this.name, this.uid, this.email, this.role, this.phonenumber});
  factory UserModel.fromMap(map) => UserModel(
        name: map['name'],
        uid: map['uid'],
        email: map['email'],
        role: map['role'],
        phonenumber: map['phonenumber'],
      );
// sending data
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'email': email,
      'role': role,
      'phonenumber': phonenumber,
    };
  }
}
