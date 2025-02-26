class PdfDocument {
  final String name;
  final String path;
  final String status;
  final DateTime date;
  final String originalPath;

  PdfDocument({
    required this.name,
    required this.path,
    required this.status,
    required this.date,
    this.originalPath = '',
  });
}

extension PdfDocumentJson on PdfDocument {
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'path': path,
      'status': status,
      'date': date.toIso8601String(),
      'originalPath': originalPath,
    };
  }

  static PdfDocument fromJson(Map<String, dynamic> json) {
    return PdfDocument(
      name: json['name'],
      path: json['path'],
      status: json['status'],
      date: DateTime.parse(json['date']),
      originalPath: json['originalPath'],
    );
  }
}