class Miscellaneous{
  double id;
   DateTime scheduleDate;
  Miscellaneous({required this.scheduleDate,required this.id});
  Miscellaneous.fromJson(Map<String, dynamic> parsedJson):id=parsedJson['id'],scheduleDate=parsedJson['scheduleDate'].toDate();


}

class Comments{
   DateTime date;
   String comment;
  Comments({required this.date,required this.comment});
  Comments.fromJson(Map<String,dynamic> parsedJson):date=parsedJson['date'].toDate(),comment=parsedJson['comment'];
  Comments.init({this.comment="",DateTime? creation}):this.date=creation??DateTime.utc(1999);
  Map<String,dynamic> toMap(){
    return {"date":date,
    "comment":comment};

  }
}