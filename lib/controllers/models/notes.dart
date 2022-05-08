// ignore_for_file: empty_constructor_bodies, prefer_collection_literals

class Note {
  late int id;
  late String content;

  Note();

  // When we want to read from the database, we will read a map then we have to transfer this map to an object and vice versa when we want to insert into the database.
  Note.fromMap(Map<String, dynamic> rowMap) {
    // Named Constructor
    id = rowMap["id"];
    content = rowMap["content"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['content'] =
        content; // we neglect the id because it will be auto incremented >> it's not our business.
    return map;
  }
}
