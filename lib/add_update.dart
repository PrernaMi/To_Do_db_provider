import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_db_provider/db_provider.dart';
import 'package:todo_db_provider/user_model.dart';

class AddUpdateNote extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  bool isFlag;
  int? s_no;
  String? prevTitle;
  String ?prevDesc;

  AddUpdateNote(
      {required this.isFlag,
      this.s_no,
      this.prevTitle,
      this.prevDesc});

  @override
  Widget build(BuildContext context) {
    print("serial no is $s_no");
    if (isFlag == false) {
      titleController.text = prevTitle!;
      descController.text = prevDesc!;
    }
    return Scaffold(
      appBar: AppBar(
        title: isFlag == true
            ? Center(child: Text("Add Your Note"))
            : Center(child: Text("Update your Note")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                labelText: "Title",
                icon: Icon(Icons.notes),
                hintText: "Enter your title...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: descController,
            decoration: InputDecoration(
                labelText: "Description",
                icon: Icon(Icons.description),
                hintText: "Enter your Description...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                isFlag == true
                    ? context.read<DbProvider>().addInProvider(
                        newNote: UserModel(
                            title: titleController.text.toString(),
                            desc: descController.text.toString()))
                    : context.read<DbProvider>().updateInProvider(
                        newModel: UserModel(title: titleController.text.toString(), desc: descController.text.toString(),s_no: s_no));
                Navigator.pop(context);
              },
              child: isFlag == true ? Text("Add") : Text("Update"))
        ],
      ),
    );
  }
}
