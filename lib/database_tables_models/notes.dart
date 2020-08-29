class Notes {
  static final String tableName = 'notes';
  static final String columnId = 'id';
  static final String columnDateTime = 'dateTime';
  static final String columnDateModified = 'dateModified';
  static final String columnTitle = 'title';
  static final String columnContent = 'content';
  static final String columnFavorite = 'favorite';

  static final String createTable = "CREATE TABLE $tableName ("
      "$columnId INTEGER PRIMARY KEY,"
      "$columnDateTime TEXT,"
      "$columnDateModified TEXT,"
      "$columnTitle TEXT ,"
      "$columnFavorite TEXT ,"
      "$columnContent TEXT "
      ")";

  int id;
  String dateTime;
  String dateModified;
  String title;
  String content;
  String favorite;

  Notes(this.dateTime, this.title, this.content, this.dateModified, this.favorite);

  Notes.update(this.id, this.title, this.content, this.dateModified);

  Notes.updateFavoriteStatus(this.id, this.favorite);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['dateTime'] = dateTime;
    map['dateModified'] = dateModified;
    map['title'] = title;
    map['content'] = content;
    map['favorite'] = favorite;
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
    this.favorite = map['favorite'];
  }

  Map<String, dynamic> toMapForFavorite() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['favorite'] = favorite;
    return map;
  }
}
