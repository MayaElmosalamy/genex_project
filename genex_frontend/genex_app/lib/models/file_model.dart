// lib/models/file_model.dart
class FileModel {
  final String fileName;
  final String fileUrl;

  FileModel({
    required this.fileName,
    required this.fileUrl,
  });

  // Factory method to create FileModel from JSON
  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      fileName: json['file_name'],
      fileUrl: json['file_url'],
    );
  }

  // Method to convert FileModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'file_name': fileName,
      'file_url': fileUrl,
    };
  }
}
