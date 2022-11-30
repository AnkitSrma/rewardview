import 'dart:convert';

RedeemItems redeemItemsFromJson(String str) => RedeemItems.fromJson(json.decode(str));

String redeemItemsToJson(RedeemItems data) => json.encode(data.toJson());

class RedeemItems {
  RedeemItems({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    required this.photo,
    required this.phoneNumber,
    required this.isVerified,
    required this.isProfileCompleted,
    required this.coins,
    required this.badges,
    required this.certificates,
    required this.incentives,
    required this.gender,
    required this.disabilityStatus,
    required this.ethnicity,
    required this.province,
    required this.district,
    required this.municipality,
    required this.address,
    required this.age,
    this.homeLocation,
    required this.occupation,
  });

  int id;
  String firstName;
  dynamic middleName;
  String lastName;
  String email;
  String photo;
  String phoneNumber;
  bool isVerified;
  bool isProfileCompleted;
  int coins;
  List<dynamic> badges;
  List<dynamic> certificates;
  List<Incentive> incentives;
  String gender;
  String disabilityStatus;
  String ethnicity;
  int province;
  int district;
  int municipality;
  String address;
  int age;
  dynamic homeLocation;
  String occupation;

  factory RedeemItems.fromJson(Map<String, dynamic> json) => RedeemItems(
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    email: json["email"],
    photo: json["photo"],
    phoneNumber: json["phone_number"],
    isVerified: json["is_verified"],
    isProfileCompleted: json["is_profile_completed"],
    coins: json["coins"],
    badges: List<dynamic>.from(json["badges"].map((x) => x)),
    certificates: List<dynamic>.from(json["certificates"].map((x) => x)),
    incentives: List<Incentive>.from(json["incentives"].map((x) => Incentive.fromJson(x))),
    gender: json["gender"],
    disabilityStatus: json["disability_status"],
    ethnicity: json["ethnicity"],
    province: json["province"],
    district: json["district"],
    municipality: json["municipality"],
    address: json["address"],
    age: json["age"],
    homeLocation: json["home_location"],
    occupation: json["occupation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "email": email,
    "photo": photo,
    "phone_number": phoneNumber,
    "is_verified": isVerified,
    "is_profile_completed": isProfileCompleted,
    "coins": coins,
    "badges": List<dynamic>.from(badges.map((x) => x)),
    "certificates": List<dynamic>.from(certificates.map((x) => x)),
    "incentives": List<dynamic>.from(incentives.map((x) => x.toJson())),
    "gender": gender,
    "disability_status": disabilityStatus,
    "ethnicity": ethnicity,
    "province": province,
    "district": district,
    "municipality": municipality,
    "address": address,
    "age": age,
    "home_location": homeLocation,
    "occupation": occupation,
  };
}

class Incentive {
  Incentive({
    required this.id,
    required this.name,
    required this.coinsRequired,
    required this.image,
    this.isAlreadyBought,
  });

  int id;
  String name;
  int coinsRequired;
  String image;
  dynamic isAlreadyBought;

  factory Incentive.fromJson(Map<String, dynamic> json) => Incentive(
    id: json["id"],
    name: json["name"],
    coinsRequired: json["coins_required"],
    image: json["image"],
    isAlreadyBought: json["is_already_bought"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coins_required": coinsRequired,
    "image": image,
    "is_already_bought": isAlreadyBought,
  };
}
