class FireBaseUserModel{
  FireBaseUserModel({
    this.name,
    this.email,
    this.imgUrl,
    this.uId,
  });

  String? name;
  String? email;
  String? imgUrl;
  String? uId;

  factory FireBaseUserModel.fromJson(Map<String, dynamic> json) => FireBaseUserModel(
    name: json["name"],
    email: json["email"],
    imgUrl: json["imgUrl"],
    uId: json["uId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "imgUrl": imgUrl,
    "uId": uId,
  };
}