class PostUserModel {
  final String name;
  final String job;
  final String id;
  final String dateTime;

  PostUserModel({
    required this.name,
    required this.job,
    required this.id,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'job': job,
      'id': id,
      'dateTime': dateTime,
    };
  }

  factory PostUserModel.fromMap(Map<String, dynamic> map) {
    return PostUserModel(
      name: map['name'] ?? '',
      job: map['job'] ?? '',
      id: map['id'] ?? '',
      dateTime: map['createdAt'] ?? '',
    );
  }
}
