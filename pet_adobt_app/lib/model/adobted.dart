class Adobted {
  Adobted({
    required this.id,
    required this.petId,
    required this.userId,
    required this.adobtDate,
    required this.totalPrice,
    required this.isDone,
  });

  String? id;
  String? petId;
  String? userId;
  String? adobtDate;
  int? totalPrice;
  bool? isDone;

  factory Adobted.fromJson(Map<String, dynamic> json) => Adobted(
        id: json["id"],
        petId: json["petId"],
        userId: json["userId"],
        adobtDate: json["adobt_date"],
        totalPrice: json["total_price"],
        isDone: json["is_done"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_hotel": petId,
        "userId": userId,
        "adobt_date": adobtDate,
        "total_price": totalPrice,
        "is_done": isDone,
      };
}

Adobted get initAdobted => Adobted(
    id: '',
    petId: '',
    userId: '',
    adobtDate: '',
    totalPrice: 0,
    isDone: false);
