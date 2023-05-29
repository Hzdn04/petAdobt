class Adobted {
  Adobted({
    this.id,
    this.petId,
    this.userId,
    this.name,
    this.adobtDate,
    this.totalPrice,
    this.status,
  });

  int? id;
  int? petId;
  int? userId;
  String? name;
  String? adobtDate;
  int? totalPrice;
  int? status;

  factory Adobted.fromJson(Map<String, dynamic> json) => Adobted(
        id: json["id"],
        petId: json["petId"],
        userId: json["userId"],
        name: json["name"],
        adobtDate: json["adobt_date"],
        totalPrice: json["total_price"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "petId": petId,
        "userId": userId,
        "name": name,
        "adobt_date": adobtDate,
        "total_price": totalPrice,
        "status": status,
      };
}

// Adobted get initAdobted =>
//     Adobted(id: "", petId: 0, userId: 0, adobtDate: '', totalPrice: 0);
