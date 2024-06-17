 class SpeciltiesModel{

  final String image;
  final String specialtyName;

  SpeciltiesModel({required this.image,required this.specialtyName});

  Map<String, dynamic> toMap(){
    return {

      'image':image,
     'specialtyName':specialtyName,
    };
  }
  factory SpeciltiesModel.fromMap(Map<String, dynamic> json){
    return SpeciltiesModel(
      image: json['image'],
      specialtyName: json['specialtyName'],
    );
  }
}