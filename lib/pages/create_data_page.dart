


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_operation/data/models/user_models.dart';
import 'package:firebase_crud_operation/data/remote_data_source/firestore_helper.dart';
import 'package:firebase_crud_operation/pages/read_data_page.dart';
import 'package:flutter/material.dart';

class CreateDataPage extends StatefulWidget {
  const CreateDataPage({Key? key}) : super(key: key);

  @override
  State<CreateDataPage> createState() => _CreateDataPageState();
}

class _CreateDataPageState extends State<CreateDataPage> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create DataPage"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 25),
        child: Column(
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Username"
              ),
            ),
            SizedBox(height: 14),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Age"
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: (){
                FirestoreHelper.create(UserModel(username: _usernameController.text,age: _ageController.text));

                final snackBar = SnackBar(
                  content: Text("Created Successfully"),
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
                child: Center(child: Text("Create",style: TextStyle(color: Colors.white),)),
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ReadDataPage()));
              },
              child: Container(
                height: 40,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green
                ),
                child: Center(child: Text("Read Data",style: TextStyle(color: Colors.white),)),
              ),
            ),

          ],
        ),
      ),
    );

  }



}
