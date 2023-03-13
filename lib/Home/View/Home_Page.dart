import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_01/Untils/Firebase_Helper.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  TextEditingController txtnote = TextEditingController();
  List l1 = [];
  int complete = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('Create');
          },
          elevation: 10,
          child: Icon(Icons.add),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${DateTime.now().weekday == 1 ? "Monday" : DateTime.now().weekday == 2 ? "Tuesday" : DateTime.now().weekday == 3 ? "Wednesday" : DateTime.now().weekday == 4 ? "Thursday" : DateTime.now().weekday == 5 ? "Friday" : DateTime.now().weekday == 6 ? "Saturday" : DateTime.now().weekday == 7 ? "Sunday" : ""},",
                  style: GoogleFonts.robotoMono(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
                Text(
                  "${DateTime.now().day} "
                  "${DateTime.now().month == 1 ? "january" : DateTime.now().month == 2 ? "February" : DateTime.now().month == 3 ? "March" : DateTime.now().month == 4 ? "April" : DateTime.now().month == 5 ? "May" : DateTime.now().month == 6 ? "June" : DateTime.now().month == 7 ? "July" : DateTime.now().month == 8 ? "August" : DateTime.now().month == 9 ? "September" : DateTime.now().month == 10 ? "October" : DateTime.now().month == 11 ? "November" : DateTime.now().month == 12 ? "December" : ""}",
                  style: GoogleFonts.robotoMono(fontSize: 30),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Fire_Helper.fire_helper.Readnote(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData) {
                    l1.clear();
                    complete = 0;
                    var docs = snapshot.data!.docs;
                    for (var doc in docs) {
                      Map data = doc.data() as Map;
                      l1.add({
                        "date": data['Note'],
                        "status": data['status'],
                        "id": doc.id
                      });
                    }
                    for (int i = 0; i < l1.length; i++) {
                      if (l1[i]['status'] == true) {
                        complete++;
                      }
                    }

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "${l1.length}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                  Text("Created tasks"),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${complete}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                  Text("Completed tasks")
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: l1.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Checkbox(
                                    onChanged: (value) {
                                      print("=========== $value");
                                      Fire_Helper.fire_helper.update(
                                          l1[index]['date'],
                                          l1[index]['id'],
                                          l1[index]['status'] == true
                                              ? false
                                              : true);
                                    },
                                    value: l1[index]['status']),
                                title: Text(
                                  "${l1[index]['date']}",
                                  style: GoogleFonts.robotoMono(
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          txtnote = TextEditingController(
                                              text: l1[index]['date']);
                                          Get.defaultDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller: txtnote,
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Fire_Helper.fire_helper
                                                          .update(
                                                              txtnote.text,
                                                              l1[index]['id'],
                                                              l1[index]
                                                                  ['status']);
                                                      Get.back();
                                                    },
                                                    child: Text("update"))
                                              ],
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.edit)),
                                    IconButton(
                                      onPressed: () {
                                      Get.defaultDialog(content:Text("Are You Sure to  delete "
                                          "this Task?"),onCancel:(){
                                        Get.back();
                                      },onConfirm: (){
                                        Fire_Helper.fire_helper.Delet(l1[index]['id']);
                                        Get.back();

                                      });
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
