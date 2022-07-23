import 'package:firebase_crud_operation/data/models/user_models.dart';
import 'package:firebase_crud_operation/data/remote_data_source/firestore_helper.dart';
import 'package:flutter/material.dart';

class UpdateDataPage extends StatefulWidget {
  final UserModel user;
  const UpdateDataPage({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdateDataPage> createState() => _UpdateDataPageState();
}

class _UpdateDataPageState extends State<UpdateDataPage> {
  TextEditingController? _usernameController;
  TextEditingController? _ageController;

  @override
  void initState() {
    _usernameController = TextEditingController(text: widget.user.username);
    _ageController = TextEditingController(text: widget.user.age);
    super.initState();
  }

  @override
  void dispose() {
    _usernameController!.dispose();
    _ageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update DataPage'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 25),
        child: Column(
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Username"
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Age"
              ),
            ),
            SizedBox(height: 15,),
            InkWell(
              onTap: (){
               FirestoreHelper.update(UserModel(id: widget.user.id,username: _usernameController!.text,age: _ageController!.text));
               Navigator.pop(context);
               final snackBar = SnackBar(
                 content: Text("Updated Successfully"),
                 duration: Duration(seconds: 1),
               );
               ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Container(
                height: 40,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green
                ),
                child: Center(child: Text("Update Data",style: TextStyle(color: Colors.white),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
