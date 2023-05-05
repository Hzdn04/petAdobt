class User {
  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.name,
    this.age,
    this.address,
    this.phone,
    this.image,
    this.role,
  });

  String? id;
  String? username;
  String? email;
  String? password;
  String? name;
  int? age;
  String? address;
  String? phone;
  String? image;
  int? role;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        age: json["age"],
        address: json["address"],
        phone: json["phone"],
        image: json["image"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "email": email,
        "password": password,
        "age": age,
        "address": address,
        "phone": phone,
        "image": image,
        "role": role,
      };
}
