class Result {
  Result({
    required this.id,
    required this.incentive,
    required this.createdAt,
    required this.updatedAt,
    required this.isIncentiveSent,
    this.deletedAt,
    required this.account,
  });

  int id;
  Incentive incentive;
  DateTime createdAt;
  DateTime updatedAt;
  bool isIncentiveSent;
  dynamic deletedAt;
  int account;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        incentive: Incentive.fromJson(json["incentive"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isIncentiveSent:
            json["incentive_sent"] == null ? false : json["incentive_sent"],
        deletedAt: json["deleted_at"],
        account: json["account"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "incentive": incentive.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "incentive_sent": isIncentiveSent,
        "deleted_at": deletedAt,
        "account": account,
      };
}

class Incentive {
  Incentive({
    required this.id,
    required this.name,
    required this.coinsRequired,
    required this.image,
    required this.isAlreadyBought,
    required this.isDelivered,
    required this.categoryName,
  });

  int id;
  String name;
  int coinsRequired;
  String image;
  bool isAlreadyBought;
  bool isDelivered;
  String categoryName;

  factory Incentive.fromJson(Map<String, dynamic> json) => Incentive(
        id: json["id"],
        name: json["name"],
        coinsRequired: json["coins_required"],
        image: json["image"],
        categoryName: json["category_name"],
        isAlreadyBought: json["is_already_bought"],
        isDelivered: json["is_delivered"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coins_required": coinsRequired,
        "category_name": categoryName,
        "image": image,
        "is_already_bought": isAlreadyBought,
        "is_delivered": isDelivered,
      };
}
