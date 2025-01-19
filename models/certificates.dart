enum CertificateType {
  registration,
  degreeWithExams,
  degreeWithExamsEng,
  degreeWithThesis,
  degreeWithThesisEng,
  degreeWithEvaluation,
  degreeWithEvaluationEng,
  examsCompleted,
  degreeForRansom,
}

int getCertificateValue(CertificateType certificate) {
  switch (certificate) {
    case CertificateType.registration:
      return 1;
    case CertificateType.degreeWithExams:
    case CertificateType.degreeWithThesis:
    case CertificateType.degreeWithEvaluation:
    default:
      return -1;
  }
}