import 'package:flutter/cupertino.dart';
import 'package:todo_db_provider/data/local/db_helper.dart';
import 'package:todo_db_provider/user_model.dart';

class DbProvider extends ChangeNotifier{

  DbHelper? mainDb;
  DbProvider({required this.mainDb});
  List<UserModel> _allNotes = [];

  void addInProvider({required UserModel newNote})async{
    bool check = await mainDb!.addInDb(mTitle: newNote.title, mDesc: newNote.desc);
    if(check){
      _allNotes =await mainDb!.getFromDb();
      notifyListeners();
    }
  }

  void getFromProvider()async{
    _allNotes = await mainDb!.getFromDb();
    notifyListeners();
  }

  List<UserModel> getInitialNotes(){
    return _allNotes;
  }

  void updateInProvider({required UserModel newModel})async{
    bool check = await mainDb!.updateInDb(title: newModel.title, desc: newModel.desc, s_no: newModel.s_no!);
    if(check){
      _allNotes = await mainDb!.getFromDb();
      notifyListeners();
    }
  }

  void deleteInProvider({required int s_no})async{
    bool chcek = await mainDb!.deleteFromDb(s_no: s_no);
    if(chcek){
      _allNotes =await mainDb!.getFromDb();
      notifyListeners();
    }
  }

}