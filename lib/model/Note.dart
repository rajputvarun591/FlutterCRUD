class Note {
  int _id;
  String _dateTime;
  String _title;
  String _content;

  Note(this._dateTime, this._title, this._content);

  Note.map(dynamic obj){
    this._id = obj['id'];
    this._dateTime = obj['dateTime'];
    this._title = obj['title'];
    this._content = obj['content'];
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['dateTime'] = _dateTime;
    map['title'] = _title;
    map['content'] = _content;

    if(_id != null){
      map['id'] = _id;
    }

    return map;
  }

  Note.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._dateTime = map['dateTime'];
    this._title = map['title'];
    this._content = map['content'];
  }

  int get id => _id;
  String get dateTime => _dateTime;
  String get title => _title;
  String get content => _content;

}