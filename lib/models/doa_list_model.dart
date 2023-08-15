class Doa {
  String id;
  String doa;
  String ayat;
  String latin;
  String artinya;

  Doa({
    required this.id,
    required this.doa,
    required this.ayat,
    required this.latin,
    required this.artinya,
  });

  factory Doa.fromJson(Map<String, dynamic> json) => Doa(
        id: json["id"],
        doa: json["doa"],
        ayat: json["ayat"],
        latin: json["latin"],
        artinya: json["artinya"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doa": doa,
        "ayat": ayat,
        "latin": latin,
        "artinya": artinya,
      };
}
