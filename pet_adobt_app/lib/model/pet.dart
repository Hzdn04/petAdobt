class Pet {
  Pet({
    this.id,
    this.petType,
    this.race,
    this.name,
    this.age,
    this.price,
    this.stock,
    this.image,
  });

  int? id;
  String? petType;
  String? race;
  String? name;
  int? age;
  int? price;
  int? stock;
  String? image;

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        id: json["id"],
        petType: json["pet_type"],
        race: json["race"],
        name: json["name"],
        age: json["age"],
        price: json["price"],
        stock: json["stock"],
        image: json["image"],
      );

  get data => null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_hotel": petType,
        "race": race,
        "name": name,
        "age": age,
        "price": price,
        "stock": stock,
        "image": image,
      };
}

