import '../model/task.dart';
import '../db/dbhelper.dart';

class TaskProvider {
  static const TABLENAME = 'task';
  static const String FIELD_ID = "id";
  static const String FIELD_TITLE = "title";
  static const String FIELD_IS_COMPLETED = "isCompleted";

  static const String CREATETABLESQL =
      "CREATE TABLE IF NOT EXISTS $TABLENAME ( $FIELD_ID TEXT PRIMARY KEY , $FIELD_TITLE TEXT, $FIELD_IS_COMPLETED INTEGER)";

  static const String DELETESQL = "DELETE FROM ${TABLENAME}";
  static const String SELECTSQLQUERYWITHID =
      "SELECT * from ${TABLENAME} where id = ? ";

  final dbHelper = DBHelper();

  Future<List<Task>> getAllTasks() async {
    var data = await dbHelper.getAllRecords(TABLENAME);
    List<Task> tasks =
        List.generate(data.length, (index) => Task.fromMap(data[index]));
    print(tasks.length);
    return tasks;
  }

  Future<List<Task>> searchTasks(String titleKey, String descriptionKey) async {
    var whereClause = " ${FIELD_TITLE} LIKE ? ";
    var data =
        await dbHelper.searchRecords(TABLENAME, whereClause, ['%${titleKey}%']);
    print("${whereClause},'%${titleKey}%'");

    List<Task> tasks =
        List.generate(data.length, (index) => Task.fromMap(data[index]));
    print("lenght: ${tasks.length} searched tasks: ${tasks.toString()}");
    return tasks;
  }

  Future<bool> insertTask(Task task) {
    return dbHelper.insertRecord(TABLENAME, task.toMap());
  }

  void updateTask(Task task) {
    dbHelper.updateRecord(TABLENAME, task.toMap(), " id=?", [task.id]);
  }

  Future<void> deleteTask(String id) async {
    var args = [id];
    dbHelper.deleteRecord(TABLENAME, " id=? ", args);
  }
}
