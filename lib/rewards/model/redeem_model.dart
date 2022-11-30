class Incentive {
  Incentive({
    required this.id,
    required this.name,
    required this.coinsRequired,
    required this.image,
  });

  int id;
  String name;
  int coinsRequired;
  String image;

  factory Incentive.fromJson(Map<String, dynamic> json) => Incentive(
    id: json["id"],
    name: json["name"],
    coinsRequired: json["coins_required"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coins_required": coinsRequired,
    "image": image,
  };
}
