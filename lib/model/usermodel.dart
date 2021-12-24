class UserModel {
  UserModel({
    this.name,
    this.email,
    this.dob,
    this.password,
  });

  String? name;
  String? email;
  String? dob;
  String? password;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    email: json["email"],
    dob: json["dob"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "dob": dob,
    "password": password,
  };
}