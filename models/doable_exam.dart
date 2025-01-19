class DoableExam {
  final int codiceInsegnamento;
  final int? codiceCorsoInsegnamento;
  final int? codiceModuloDidattico;
  final String descrizione;
  final double cfu;
  final String? ssd;
  final bool certificato;
  final bool superamento;

  DoableExam({
    required this.codiceInsegnamento,
    this.codiceCorsoInsegnamento,
    this.codiceModuloDidattico,
    required this.descrizione,
    required this.cfu,
    this.ssd,
    required this.certificato,
    required this.superamento,
  });

  factory DoableExam.fromJson(Map<String, dynamic> json) {
    return DoableExam(
      codiceInsegnamento: int.tryParse(json['codiceInsegnamento'].toString()) ?? 0,
      codiceCorsoInsegnamento: json['codiceCorsoInsegnamento'] != null
          ? int.tryParse(json['codiceCorsoInsegnamento'].toString())
          : null,
      codiceModuloDidattico: json['codiceModuloDidattico'] != null
          ? int.tryParse(json['codiceModuloDidattico'].toString())
          : null,
      descrizione: json['descrizione'] ?? 'Descrizione non disponibile',
      cfu: (json['cfu'] as num?)?.toDouble() ?? 0.0,
      ssd: json['ssd'],
      certificato: json['certificato'] ?? false,
      superamento: json['superamento'] ?? false,
    );
  }
}
