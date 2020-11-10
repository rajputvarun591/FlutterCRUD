class UserDetails {
  static const tableName = "user_details";
  static const columnId = "user_id";
  static const columnFirstName = "first_name";
  static const columnLastName = "last_name";
  static const columnImage = "image";
  static const columnDOB = "dob";
  static const columnEmail = "email";

  static const createTable = "CREATE TABLE $tableName ("
      "$columnId INTEGER PRIMARY KEY, "
      "$columnFirstName TEXT, "
      "$columnLastName TEXT, "
      "$columnEmail TEXT, "
      "$columnDOB TEXT, "
      "$columnImage TEXT "
      ")";

  int id;
  String firstName;
  String lastName;
  String email;
  String dob;
  String image;

  UserDetails.fromJsonResp(Map<String, dynamic> json)
      : id = json["id"],
        firstName = json["first_name"],
        lastName = json["last_name"],
        email = json["email"],
        dob = json["dob"],
        image = json["image"];
}
