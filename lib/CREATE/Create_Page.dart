import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:note_01/Untils/Firebase_Helper.dart';

class Create_Page extends StatefulWidget {
  const Create_Page({Key? key}) : super(key: key);

  @override
  State<Create_Page> createState() => _Create_PageState();
}

class _Create_PageState extends State<Create_Page> {
  TextEditingController txtnote = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create Note"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: txtnote,
                maxLength: 40,
                decoration: InputDecoration(label: Text("Write Note"),filled: true,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.note_rounded)),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 10,
                        fixedSize: Size(100, 45),
                        textStyle:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Get.offNamed('/');
                    },
                    child: Text("Cancel"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 10,
                        fixedSize: Size(100, 45),
                        textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    onPressed: () async {
                     bool iscreate=await Fire_Helper.fire_helper.Cratenote(txtnote.text);
                     if(iscreate)
                       {
                         Get.back();
                         Get.snackbar("Successful", "");
                       }
                     else
                       {
                         Get.snackbar("Not succesfully", "");
                       }
                    },
                    child: Text("Create"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
