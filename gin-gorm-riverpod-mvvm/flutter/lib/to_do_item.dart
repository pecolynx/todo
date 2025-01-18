class ToDoItem {
  int id;
  String title;
  bool isDone;
  ToDoItem({required this.id, required this.title, this.isDone = false});

  ToDoItem.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as int,
          title: json['text']! as String,
          isDone: json['isComplete']! as bool,
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': title,
        'isComplete': isDone,
      };

  static List<ToDoItem> fromList(List<dynamic> jsonList) {
    final list = <ToDoItem>[];
    for (final elementJson in jsonList) {
      try {
        final obj = ToDoItem.fromJson(elementJson as Map<String, dynamic>);
        list.add(obj);
      } catch (e) {
        print('error $e parsing $elementJson');
      }
    }
    return list;
  }
}
