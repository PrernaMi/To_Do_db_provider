class UserModel {
  String title;
  String desc;
  int? s_no;
  int? isCompleted;

  UserModel(
      {required this.title, required this.desc, this.s_no, this.isCompleted});

  factory UserModel.fromMap(Map<String,dynamic>map){
    return UserModel(title: map['title'], desc: map['desc'],isCompleted: map['isCompleted'],s_no: map['s_no']);
  }

  Map<String,dynamic> toMap(){
    return {
      'title' : title,
      'desc' : desc,
      'isCompleted' : isCompleted,
      's_no' : s_no
    };
  }
}


