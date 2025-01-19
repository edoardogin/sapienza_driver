class Isee {
  final String? data;
  final bool? redditoEstero;
  final String? protocollo;
  final bool? nonDichiaro;
  final double? valore;
  final String? annoFisc;

  Isee({
    this.data,
    this.redditoEstero,
    this.protocollo,
    this.nonDichiaro,
    this.valore,
    this.annoFisc,
  });

  factory Isee.fromJson(Map<String, dynamic> json) {
    return Isee(
      data: json['data']?.toString(),
      redditoEstero: json['redditoEstero'] == "true",
      protocollo: json['protocollo']?.toString(),
      nonDichiaro: json['nonDichiaro'] == "true",
      valore: double.tryParse(json['valore']?.toString() ?? '0.0'),
      annoFisc: json['annoFisc']?.toString(),
    );
  }

  @override
  String toString() {
    return 'Isee(data: $data, redditoEstero: $redditoEstero, protocollo: $protocollo, nonDichiaro: $nonDichiaro, valore: $valore, annoFisc: $annoFisc)';
  }
}

class IseeResponse {
  final List<Isee> iseeList;

  IseeResponse({required this.iseeList});

  factory IseeResponse.fromJson(Map<String, dynamic> json) {
    final risultati = json['risultatoLista']?['risultati'] as List<dynamic>? ?? [];
    return IseeResponse(
      iseeList: risultati.map((e) => Isee.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  String toString() {
    return 'IseeResponse(iseeList: $iseeList)';
  }
}
