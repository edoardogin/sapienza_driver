class Exam {
  final String codiceInsegnamento;
  final String? codiceCorso;
  final String? codiceModulo;
  final String nomeEsame;
  final DateTime date;
  final ExamResult result;
  final double cfu;
  final String ssd;
  final bool certified;
  final bool authorized;
  final String academicYear;
  final bool passed;

  Exam({
    required this.codiceInsegnamento,
    this.codiceCorso,
    this.codiceModulo,
    required this.nomeEsame,
    required this.date,
    required this.result,
    required this.cfu,
    required this.ssd,
    required this.certified,
    required this.authorized,
    required this.academicYear,
    required this.passed,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      codiceInsegnamento: json['codiceInsegnamento'],
      codiceCorso: json['codiceCorsoInsegnamento'],
      codiceModulo: json['codiceModuloDidattico'],
      nomeEsame: json['descrizione'],
      date: DateTime.parse(json['dataDate']),
      result: ExamResult.fromJson(json['esito']),
      cfu: (json['cfu'] as num).toDouble(),
      ssd: json['ssd'],
      certified: json['certificato'],
      authorized: json['autorizzato'],
      academicYear: json['annoAcca'],
      passed: json['superamento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codiceInsegnamento': codiceInsegnamento,
      'codiceCorsoInsegnamento': codiceCorso,
      'codiceModuloDidattico': codiceModulo,
      'nomeEsame': nomeEsame,
      'dataDate': date.toIso8601String(),
      'esito': result.toJson(),
      'cfu': cfu,
      'ssd': ssd,
      'certificato': certified,
      'autorizzato': authorized,
      'annoAcca': academicYear,
      'superamento': passed,
    };
  }
}

class ExamResult {
  final bool isNominal;
  final String nominalValue;
  final int nonNominalValue;

  ExamResult({
    required this.isNominal,
    required this.nominalValue,
    required this.nonNominalValue,
  });

  factory ExamResult.fromJson(Map<String, dynamic> json) {
    return ExamResult(
      isNominal: json['nominale'],
      nominalValue: json['valoreNominale'],
      nonNominalValue: json['valoreNonNominale'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nominale': isNominal,
      'valoreNominale': nominalValue,
      'valoreNonNominale': nonNominalValue,
    };
  }
}
