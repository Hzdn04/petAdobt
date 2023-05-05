class Pet {
  Pet({
    required this.id,
    required this.petType,
    required this.race,
    required this.name,
    required this.age,
    required this.price,
    required this.stock,
    required this.image,
  });

  String id;
  String petType;
  String race;
  String name;
  int age;
  int price;
  int stock;
  String image;

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

Pet get initPet => Pet(
    id: '',
    petType: '',
    race: '',
    name: '',
    age: 0,
    price: 0,
    stock: 0,
    image: '',
  );
