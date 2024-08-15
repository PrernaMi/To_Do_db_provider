import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_db_provider/add_update.dart';
import 'package:todo_db_provider/db_provider.dart';
import 'package:todo_db_provider/user_model.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<DbProvider>().getFromProvider();
  }

  double progress = 0;
  @override
  Widget build(BuildContext context) {
    List<UserModel> allNotes = [];
    allNotes = context.watch<DbProvider>().getInitialNotes();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.blue.shade200]),
                  borderRadius: BorderRadius.circular(15)),
              height: 200,
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "Today's progress summery",
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          )),
                      /*-------Task Added-------*/
                      Expanded(
                          flex: 1,
                          child: Text(
                            "${allNotes.length} Tasks",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                      SizedBox(
                        height: 25,
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Progress",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text("40%", style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        width: 140,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: Colors.grey.shade400,
                                                    width: 7)),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      Container(
                                        width: 70,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: Colors.white70,
                                                    width: 7)),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            /*------------------Images------------*/
                            Expanded(
                              flex: 1,
                              child: Stack(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    "assets/images/img.png",
                                    height: 40,
                                    width: 40,
                                  )),
                                  Positioned(
                                      left: 20,
                                      child: ClipOval(
                                          child: Image.asset(
                                        "assets/images/img_1.png",
                                        height: 40,
                                        width: 40,
                                      ))),
                                  Positioned(
                                      left: 40,
                                      child: ClipOval(
                                          child: Image.asset(
                                        "assets/images/img_2.png",
                                        height: 40,
                                        width: 40,
                                      ))),
                                  Positioned(
                                      left: 60,
                                      child: ClipOval(
                                          child: Image.asset(
                                        "assets/images/img_3.png",
                                        height: 40,
                                        width: 40,
                                      )))
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's task",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "See all",
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                ),
              ],
            ),
            Expanded(
              child: allNotes.isNotEmpty
                  ? ListView.builder(
                      itemCount: allNotes.length,
                      itemBuilder: (_, Index) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text("${Index + 1}"),
                          ),
                          title: Text(allNotes[Index].title),
                          subtitle: Text(allNotes[Index].desc),
                          trailing: SizedBox(
                            width: 60,
                            child: Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return AddUpdateNote(
                                          isFlag: false,
                                          s_no: allNotes[Index].s_no!,
                                          prevTitle: allNotes[Index].title,
                                          prevDesc: allNotes[Index].desc,
                                        );
                                      }));
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      size: 30,
                                    )),
                                InkWell(
                                    onTap: () {
                                      context
                                          .read<DbProvider>()
                                          .deleteInProvider(
                                              s_no: allNotes[Index].s_no!);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      size: 30,
                                    ))
                              ],
                            ),
                          ),
                        );
                      })
                  : Center(
                      child: Text(
                      "No Notes yet..",
                      style: TextStyle(fontSize: 25),
                    )),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddUpdateNote(
              isFlag: true,
            );
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
