



import 'package:firebase_crud_operation/data/models/user_models.dart';
import 'package:firebase_crud_operation/data/remote_data_source/firestore_helper.dart';
import 'package:firebase_crud_operation/pages/update_data_page.dart';
import 'package:flutter/material.dart';

class ReadDataPage extends StatelessWidget {
  const ReadDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read DataPage"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
        child: Column(
          children: [
            StreamBuilder<List<UserModel>>(
              stream: FirestoreHelper.read(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(snapshot.hasError){
                  Center(child: Text("Something Went Wrong"),);
                }
                if(snapshot.hasData){
                  final userData = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: userData!.length,
                      itemBuilder: (context, index){
                        final singleUser = userData[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: InkWell(
                            onLongPress: (){
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Delete'),
                                  content: const Text('Are you sure you want to delete?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: (){
                                        FirestoreHelper.delete(UserModel(id: singleUser.id,username: singleUser.username,age: singleUser.age));
                                        Navigator.pop(context);
                                      }, child: Text("Yes"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle
                                ),
                                child: Icon(Icons.person),
                              ),
                              title: Text("${singleUser.username}"),
                              subtitle: Text('${singleUser.age}'),
                              trailing: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateDataPage(user: UserModel(username: singleUser.username,age: singleUser.age,id: singleUser.id),)));
                                  },
                                  child: Icon(Icons.edit)),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator(),);
              }
            )
          ],
        ),
      ),
    );
  }
}
