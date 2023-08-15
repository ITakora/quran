class JadwalSholat {
  String status;
  Data data;

  JadwalSholat({
    required this.status,
    required this.data,
  });

  factory JadwalSholat.fromJson(Map<String, dynamic> json) => JadwalSholat(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  String ashar;
  String dhuha;
  String dzuhur;
  String imsak;
  String isya;
  String maghrib;
  String subuh;
  String tanggal;
  String terbit;

  Data({
    required this.ashar,
    required this.dhuha,
    required this.dzuhur,
    required this.imsak,
    required this.isya,
    required this.maghrib,
    required this.subuh,
    required this.tanggal,
    required this.terbit,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ashar: json["ashar"],
        dhuha: json["dhuha"],
        dzuhur: json["dzuhur"],
        imsak: json["imsak"],
        isya: json["isya"],
        maghrib: json["maghrib"],
        subuh: json["subuh"],
        tanggal: json["tanggal"],
        terbit: json["terbit"],
      );

  Map<String, dynamic> toJson() => {
        "ashar": ashar,
        "dhuha": dhuha,
        "dzuhur": dzuhur,
        "imsak": imsak,
        "isya": isya,
        "maghrib": maghrib,
        "subuh": subuh,
        "tanggal": tanggal,
        "terbit": terbit,
      };
}
