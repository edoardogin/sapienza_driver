
class Student {
  final String codiceFiscale;
  final String cognome;
  final String nome;
  final String dataDiNascita;
  final String luogoDiNascita;
  final String annoCorso;
  final String primaIscrizione;
  final String ultimaIscrizione;
  final String facolta;
  final String nomeCorso;
  final String annoAccademicoAttuale;
  final int matricola;
  final String codiceCorso;
  final int tipoStudente;
  final bool isErasmus;
  final String statoIscrizione;
  final String sesso;
  final String provinciaNascita;
  final String nazioneNascita;
  final String comuneNascita;
  final String emailPersonale;
  final bool emailConfermata;
  final String emailIstituzionale;
  final String cittadinanza;
  final int creditiTotali;
  final bool accessoPrenotazione;

  Student({
    required this.codiceFiscale,
    required this.cognome,
    required this.nome,
    required this.dataDiNascita,
    required this.luogoDiNascita,
    required this.annoCorso,
    required this.primaIscrizione,
    required this.ultimaIscrizione,
    required this.facolta,
    required this.nomeCorso,
    required this.annoAccademicoAttuale,
    required this.matricola,
    required this.codiceCorso,
    required this.tipoStudente,
    required this.isErasmus,
    required this.statoIscrizione,
    required this.sesso,
    required this.provinciaNascita,
    required this.nazioneNascita,
    required this.comuneNascita,
    required this.emailPersonale,
    required this.emailConfermata,
    required this.emailIstituzionale,
    required this.cittadinanza,
    required this.creditiTotali,
    required this.accessoPrenotazione,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      codiceFiscale: json['codiceFiscale'],
      cognome: json['cognome'],
      nome: json['nome'],
      dataDiNascita: json['dataDiNascita'],
      luogoDiNascita: json['luogoDiNascita'],
      annoCorso: json['annoCorso'],
      primaIscrizione: json['primaIscr'],
      ultimaIscrizione: json['ultIscr'],
      facolta: json['facolta'],
      nomeCorso: json['nomeCorso'],
      annoAccademicoAttuale: json['annoAccaAtt'],
      matricola: json['matricola'],
      codiceCorso: json['codCorso'],
      tipoStudente: json['tipoStudente'],
      isErasmus: json['isErasmus'],
      statoIscrizione: json['tipoIscrizione'],
      sesso: json['sesso'],
      provinciaNascita: json['provinciaNascita'],
      nazioneNascita: json['nazioneNascita'],
      comuneNascita: json['comuneDiNasciata'],
      emailPersonale: json['indiMail'],
      emailConfermata: json['mailConfermata'] == 'S',
      emailIstituzionale: json['indiMailIstituzionale'],
      cittadinanza: json['cittadinanza'],
      creditiTotali: int.parse(json['creditiTotali']),
      accessoPrenotazione: json['accessoPrenotazione'],
    );
  }
}
