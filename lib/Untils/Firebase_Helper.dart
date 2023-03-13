
import 'package:cloud_firestore/cloud_firestore.dart';

class Fire_Helper
{
  Fire_Helper._();
  static Fire_Helper fire_helper =Fire_Helper._();

  Future<bool> Cratenote(String note)
  async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    bool isNote =false;
    await firestore.collection("note").add({"Note":note, "status" : false}).then((value) {
      isNote=true;
    }).catchError((error){
      isNote=false;
    });
    return isNote;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> Readnote(){

   FirebaseFirestore firestore = FirebaseFirestore.instance;
   return firestore.collection("note").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> ReadTruenote(){

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection("note").where("status",isEqualTo: true).snapshots();
  }

  void Delet(String id)
  {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("note").doc(id).delete();
  }

  void update(String note,String id,bool status)
  {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("note").doc(id).update({"Note":note,"status" : status});

  }
}