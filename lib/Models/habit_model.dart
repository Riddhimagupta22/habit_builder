class HabitModel{
  String id;
  String name;
  String description;
   List <String> completeddates;
  
  HabitModel({
    required this.id,
    required this.name,
    required this.description,
    required this.completeddates,
    
});
  
  Map<String,dynamic> toMap() => {
    'name': name,
    'description': description,
    'completeddates': completeddates,
    
  };

  factory HabitModel.fromMap(String id,Map<String,dynamic> map ) {
    return HabitModel(
      id: id,
      name: map['name'],
      description: map['description'],
      completeddates: map['completeddates'],
    );
  }
}