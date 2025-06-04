class ExpenseTag {
  final String id;
  final String name;

  ExpenseTag({
    required this.id,
    required this.name,
  });


  factory ExpenseTag.fromJson(Map<String, dynamic> json) {
    return ExpenseTag(
      id: json['id'],
      name: json['name'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
  
}