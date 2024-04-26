import 'Task.dart';

class RegularTask extends Task {
  RegularTask(
      {required String id, required String title, required String description, required bool isCompleted})
      : super(
          id: id,
          title: title,
          description: description,
          isCompleted: isCompleted,
        );

  @override
  String toString() {
    return 'RegularTask(id: $id, title: $title,description: $description, isCompleted: $isCompleted)';
  }
}
