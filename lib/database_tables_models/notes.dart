class Notes {
  static final String tableName = 'notes';
  static final String columnId = 'id';
  static final String columnDateTime = 'dateTime';
  static final String columnDateModified = 'dateModified';
  static final String columnTitle = 'title';
  static final String columnContent = 'content';

  static final String createTable = "CREATE TABLE $tableName ("
      "$columnId INTEGER PRIMARY KEY,"
      "$columnDateTime TEXT,"
      "$columnDateModified TEXT,"
      "$columnTitle TEXT ,"
      "$columnContent TEXT "
      ")";

  int id;
  String dateTime;
  String dateModified;
  String title;
  String content;

  Notes(this.dateTime, this.title, this.content, this.dateModified);

  Notes.update(this.id, this.title, this.content, this.dateModified);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['dateTime'] = dateTime;
    map['dateModified'] = dateModified;
    map['title'] = title;
    map['content'] = content;
    return map;
  }


  Map<String, dynamic> toMapForUpdate() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['dateModified'] = dateModified;
    map['title'] = title;
    map['content'] = content;
    return map;
  }

  Notes.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.dateTime = map['dateTime'];
    this.dateModified = map['dateModified'];
    this.title = map['title'];
    this.content = map['content'];
  }
}
