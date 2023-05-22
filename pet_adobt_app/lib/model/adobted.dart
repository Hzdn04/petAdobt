class Adobted {
  Adobted({
    this.id,
    this.petId,
    this.userId,
    this.adobtDate,
    this.totalPrice,
    this.address,
    this.user,
  });

  int? id;
  int? petId;
  int? userId;
  String? adobtDate;
  int? totalPrice;
  String? address;
  List<dynamic>? user;

  factory Adobted.fromJson(Map<String, dynamic> json) => Adobted(
        id: json["id"],
        petId: json["petId"],
        userId: json["userId"],
        adobtDate: json["adobt_date"],
        totalPrice: json["total_price"],
        address: json["address"],
        // user: List<dynamic>.from(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "petId": petId,
        "userId": userId,
        "adobt_date": adobtDate,
        "total_price": totalPrice,
        "address": address,
        "user": user,
      };
}

// Adobted get initAdobted =>
//     Adobted(id: "", petId: 0, userId: 0, adobtDate: '', totalPrice: 0);
