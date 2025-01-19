# Sapienza Driver

**Sapienza Driver** is a Flutter/Dart package designed to interface with the Sapienza University systems, providing functionalities for managing exams, certificates, news, and other student-related data. This package simplifies interaction with university APIs.

---

## Features

- **Exams Management**:
  - Fetch completed, reservable, and reserved exams.
  - Make and manage exam reservations.

- **Certificates**:
  - Generate academic certificates.
  - Download certificate PDFs directly.

- **News Fetching**:
  - Retrieve university news with descriptions and images.
  - Search with optional filters and pagination.

- **Tax Management**:
  - Retrieve paid and unpaid taxes.
  - Download payment slips in PDF format.

---

## Getting Started

1. Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  sapienza_driver: ^1.0.0
```

2. Install the package:
```bash
flutter pub get
```

3. Import the necessary handlers:
```flutter
import 'package:sapienza_driver/handlers/exam_handler.dart';
import 'package:sapienza_driver/handlers/news_handler.dart';
import 'package:sapienza_driver/handlers/certificate_handler.dart';
```

## Usage
    
### Fetch Completed Exams
```flutter
await authHandler.login(studentID, password);
token = authHandler.token;
if (token == null) throw Exception('Token non valido');
    
final examHandler = ExamHandler(token: token!);

void fetchExams() async {
    try {
        final exams = await examHandler.getExamsDone('studentID');
        for (var exam in exams) {
            print('Exam: ${exam.nomeEsame}, Score: ${exam.result}');
        }
    } catch (e) {
        print('Error fetching exams: $e');
    }
}
```

### Student Informations
```flutter
await authHandler.login(studentID, password);
token = authHandler.token;
if (token == null) throw Exception('Token non valido');
    
final studentHandler = StudentHandler(token: token!);
var info = await studentHandler.getStudentInfo(studentID);
print(info.nome);
```

### Reserve an Exam
```flutter
await authHandler.login(studentID, password);
token = authHandler.token;
if (token == null) throw Exception('Token non valido');
    
final studentHandler = StudentHandler(token: token!);
var info = await studentHandler.getStudentInfo(studentID);
    
var examReservationHandler = ExamReservationHandler(token: token!);
var examHandler = ExamHandler(token: token!);
List<DoableExam> doableExams = await examHandler.getDoableExams(studentID);

var availableExams = await examReservationHandler.getAvailableReservations(doableExams.first, info); // find available exams
var firstExam = availableExams.first;

await examReservationHandler.insertReservation(
    reportID: firstExam.codiceVerbale.toString(), // Verbale ID of Exam
    sessionID: firstExam.codiceAppello.toString(), // Session ID of Exam
    courseCode: firstExam.codiceCorsoStudi // Code of your course
);
```


## Additional Information

- Contributions: Contributions are welcome! Feel free to fork the repository and submit pull requests.
- Issues: If you encounter any issues, please file them in the GitHub Issues section.
- License: This package is distributed under the MIT License.

Edoardo Ginghina
https://www.linkedin.com/in/edoardo-ginghina/
