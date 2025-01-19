class ReservedExam {
  final int codiceVerbale;
  final int codiceAppello;
  final String? tipoPrenotazione;
  final String codiceCorsoStudi;
  final String nomeCorsoStudi;
  final String nomeEsame;
  final double crediti;
  final String canale;
  final String docente;
  final String facolta;
  final int annoAccademico;
  final String dataAppello;
  final String? note;
  final int numeroPrenotazione;
  final String dataprenotazione;
  final String? dataInizioPrenotazione;
  final String? dataFinePrenotazione;
  final String? dataSeduta;
  final String? insegnamentoAuto;
  final String? tipologiaAuto;
  final bool questionario;
  final String? annualita;
  final String siglaModuloDidattico;
  final String ssd;
  final int diviSeduta;
  final String? noteCalendario;
  final String? noteTurno;
  final String? noteTurnoStud;
  final String? modalitaSvolgimento;

  ReservedExam({
    required this.codiceVerbale,
    required this.codiceAppello,
    this.tipoPrenotazione,
    required this.codiceCorsoStudi,
    required this.nomeCorsoStudi,
    required this.nomeEsame,
    required this.crediti,
    required this.canale,
    required this.docente,
    required this.facolta,
    required this.annoAccademico,
    required this.dataAppello,
    this.note,
    required this.numeroPrenotazione,
    required this.dataprenotazione,
    this.dataInizioPrenotazione,
    this.dataFinePrenotazione,
    this.dataSeduta,
    this.insegnamentoAuto,
    this.tipologiaAuto,
    required this.questionario,
    this.annualita,
    required this.siglaModuloDidattico,
    required this.ssd,
    required this.diviSeduta,
    this.noteCalendario,
    this.noteTurno,
    this.noteTurnoStud,
    this.modalitaSvolgimento,
  });

  /// Metodo per convertire una mappa JSON in un oggetto ReservedExam
  factory ReservedExam.fromJson(Map<String, dynamic> json) {
    return ReservedExam(
      codiceVerbale: int.tryParse(json['codIdenVerb']?.toString() ?? '0') ?? 0,
      codiceAppello: int.tryParse(json['codAppe']?.toString() ?? '0') ?? 0,
      tipoPrenotazione: json['tipoPren'],
      codiceCorsoStudi: json['codCorsoStud'] ?? '',
      nomeCorsoStudi: json['descCorsoStud'] ?? '',
      nomeEsame: json['descrizione'] ?? '',
      crediti: double.tryParse(json['crediti']?.toString() ?? '0.0') ?? 0.0,
      canale: json['canale'] ?? '',
      docente: json['docente'] ?? '',
      facolta: json['facolta'] ?? '',
      annoAccademico: int.tryParse(json['annoAcca']?.toString() ?? '0') ?? 0,
      dataAppello: json['dataAppe'] ?? '',
      note: json['note'],
      numeroPrenotazione:
          int.tryParse(json['numeroPrenotazione']?.toString() ?? '0') ?? 0,
      dataprenotazione: json['dataprenotazione'] ?? '',
      dataInizioPrenotazione: json['dataInizioPrenotazione'],
      dataFinePrenotazione: json['dataFinePrenotazione'],
      dataSeduta: json['dataSeduta'],
      insegnamentoAuto: json['insegnamentoAuto'],
      tipologiaAuto: json['tipologiaAuto'],
      questionario: json['questionario'] ?? false,
      annualita: json['annualita'],
      siglaModuloDidattico: json['SiglaModuloDidattico'] ?? '',
      ssd: json['ssd'] ?? '',
      diviSeduta: int.tryParse(json['diviSeduta']?.toString() ?? '-1') ?? -1,
      noteCalendario: json['noteCalendario'],
      noteTurno: json['noteTurno'],
      noteTurnoStud: json['noteTurnoStud'],
      modalitaSvolgimento: json['modalitaSvolgimento'],
    );
  }

  /// Metodo per convertire un oggetto ReservedExam in mappa JSON
  Map<String, dynamic> toJson() {
    return {
      'codiceVermale': codiceVerbale,
      'codiceAppello': codiceAppello,
      'tipoPrenotazione': tipoPrenotazione,
      'codiceCorsoStudi': codiceCorsoStudi,
      'nomeCorsoStudi': nomeCorsoStudi,
      'nomeEsame': nomeEsame,
      'crediti': crediti,
      'canale': canale,
      'docente': docente,
      'facolta': facolta,
      'annoAccademico': annoAccademico,
      'dataAppello': dataAppello,
      'note': note,
      'numeroPrenotazione': numeroPrenotazione,
      'dataprenotazione': dataprenotazione,
      'dataInizioPrenotazione': dataInizioPrenotazione,
      'dataFinePrenotazione': dataFinePrenotazione,
      'dataSeduta': dataSeduta,
      'insegnamentoAuto': insegnamentoAuto,
      'tipologiaAuto': tipologiaAuto,
      'questionario': questionario,
      'annualita': annualita,
      'SiglaModuloDidattico': siglaModuloDidattico,
      'ssd': ssd,
      'diviSeduta': diviSeduta,
      'noteCalendario': noteCalendario,
      'noteTurno': noteTurno,
      'noteTurnoStud': noteTurnoStud,
      'modalitaSvolgimento': modalitaSvolgimento,
    };
  }
}
