class Tax {
  final String? code;
  final String? codeCourse;
  final String? descriptionCourse;
  final double? amount;
  final int? academicYear;
  final DateTime? paymentDate;
  final DateTime? expirationDate;
  final String? status;
  final List<Causal>? causals;
  final String? type;
  final String? descriptionType;
  final bool? isSecondInstallment;

  Tax({
    this.code,
    this.codeCourse,
    this.descriptionCourse,
    this.amount,
    this.academicYear,
    this.paymentDate,
    this.expirationDate,
    this.status,
    this.causals,
    this.type,
    this.descriptionType,
    this.isSecondInstallment,
  });

  factory Tax.fromJson(Map<String, dynamic> json) {
    return Tax(
      code: json['codiceBollettino'],
      codeCourse: json['corsoDiStudi'],
      descriptionCourse: json['descCorsoDiStudi'],
      amount: double.tryParse(
          json['impoVers']?.toString() ?? '0.0'),
      academicYear: json['annoAcca'],
      paymentDate: _parseDate(json['dataVers']),
      expirationDate: json['scadenza'] != null && json['scadenza'].isNotEmpty
          ? _parseDate(json['scadenza'])
          : null,
      status: json['dataVers'] != null ? 'PAID' : 'UNPAID',
      causals: (json['causali'] as List<dynamic>?)
          ?.map((e) => Causal.fromJson(e))
          .toList(),
      type: json['tipoBoll'],
      descriptionType: json['descTipoBoll'],
      isSecondInstallment: json['isSecondaRata'] == "true",
    );
  }

  static DateTime? _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      return DateTime.parse(
        dateStr.split('/').reversed.join('-'),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  String toString() {
    return 'Tax(code: $code, codeCourse: $codeCourse, descriptionCourse: $descriptionCourse, amount: $amount, academicYear: $academicYear, paymentDate: $paymentDate, expirationDate: $expirationDate, status: $status, causals: $causals, type: $type, descriptionType: $descriptionType, isSecondInstallment: $isSecondInstallment)';
  }
}

class Causal {
  final String? description;
  final String? code;
  final int? installmentIndex;
  final double? amount;
  final bool? isMandatory;
  final int? academicYear;

  Causal({
    this.description,
    this.code,
    this.installmentIndex,
    this.amount,
    this.isMandatory,
    this.academicYear,
  });

  factory Causal.fromJson(Map<String, dynamic> json) {
    return Causal(
      description: json['descrizione'],
      code: json['codiceCausale'],
      installmentIndex: json['indiRata'],
      amount: double.tryParse(json['importo']?.toString() ?? '0.0'),
      isMandatory: json['isDovuto'] ?? false,
      academicYear: json['annoAccademico'],
    );
  }

  @override
  String toString() {
    return 'Causal(description: $description, code: $code, installmentIndex: $installmentIndex, amount: $amount, isMandatory: $isMandatory, academicYear: $academicYear)';
  }
}

List<Tax> parseTaxes(List<dynamic> jsonList) {
  return jsonList.map((json) => Tax.fromJson(json)).toList();
}
