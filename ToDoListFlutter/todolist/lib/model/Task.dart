import 'dart:convert';

class Task {
  String id;
  String title;
  String description; 
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description, 
    required this.isCompleted,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'], 
      isCompleted: map['isCompleted'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description, 
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
