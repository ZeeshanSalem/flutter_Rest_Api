import 'package:flutter/material.dart';
import 'package:flutter_rest_api/screen/user_list_model.dart';
import 'package:flutter_rest_api/user_model.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => UserListModel(),
          child: Consumer<UserListModel>(
            builder: (context, model, child) =>
                model.isLoading ?  Center(child: CircularProgressIndicator(),) :
                    SingleChildScrollView(
                      child: Column(
                        children:[

                      ...model.userList.map<Widget>((e) => UserTile(
                        onDelete: () async{
//                          model.user.id = e.id;
                          model.deleteUser(e);
//                          model.user.id = e.id;
//                          showDialog(
//                            context: context,
//                            child: Dialog(
//                              child: Container(
//                                child: SingleChildScrollView(
//                                  child: Column(
//                                    children: [
//
//                                      InputTextField(
//                                        controller: TextEditingController(text: e.id),
//                                        labelText: "Id",
//                                        hintText: "01",
////                                        icon: "assets/static_assets/profile_icon.png",
//                                        onChange: (String val) {
//                                          e.id = val;
//                                        },
//                                        validator: (String val) {
//                                          if (val == null || val.length < 1) {
//                                            return 'Please enter you id ';
//                                          } else {
//                                            return null;
//                                          }
//                                        },
//                                      ),
//
//                                      InputTextField(
//                                        controller: TextEditingController(text: e.name),
//                                        labelText: "name",
//                                        hintText: "zeeshan",
////                                        icon: "assets/static_assets/profile_icon.png",
//                                        onChange: (String val) {
//                                          e.name = val;
//                                        },
//                                        validator: (String val) {
//                                          if (val == null || val.length < 1) {
//                                            return 'Please enter you name ';
//                                          } else {
//                                            return null;
//                                          }
//                                        },
//                                      ),
//
//                                      InputTextField(
//                                        controller: TextEditingController(text: e.avatar),
//                                        labelText: "Image",
//                                        hintText: "imag",
////                                        icon: "assets/static_assets/profile_icon.png",
//                                        onChange: (String val) {
//                                          e.avatar = val;
//                                        },
//                                        validator: (String val) {
//                                          if (val == null || val.length < 1) {
//                                            return 'Please enter you name ';
//                                          } else {
//                                            return null;
//                                          }
//                                        },
//                                      ),
//
//                                      RaisedButton(
//                                          child: Text("Update"),
//                                          onPressed: () async{
//                                            await model.updateUser(e);
//                                            Navigator.pop(context);
//                                          }),
//
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            ),
//                          );
                        },
                        user: e,
                      )).toList(),

                          SizedBox(height: 10,),

                          Align(
                            alignment: Alignment.centerRight,
                            child: FloatingActionButton(
                              child: Icon(Icons.add),
                              onPressed: (){
                                showDialog(
                                  context: context,
                                  child: Dialog(
                                    child: Container(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [

                                            InputTextField(
                                              controller: TextEditingController(text: model.user.id),
                                              labelText: "Id",
                                              hintText: "01",
//                                        icon: "assets/static_assets/profile_icon.png",
                                              onChange: (String val) {
                                                model.user.id = val;
                                              },
                                              validator: (String val) {
                                                if (val == null || val.length < 1) {
                                                  return 'Please enter you id ';
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),

                                            InputTextField(
                                              controller: TextEditingController(text: model.user.name),
                                              labelText: "name",
                                              hintText: "zeeshan",
//                                        icon: "assets/static_assets/profile_icon.png",
                                              onChange: (String val) {
                                                model.user.name = val;
                                              },
                                              validator: (String val) {
                                                if (val == null || val.length < 1) {
                                                  return 'Please enter you name ';
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),

                                            Stack(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(right: 13.0),
                                                  height: 68.0,
                                                  width: 68.0,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(50),
                                                    child: model.isLoading ?
                                                        CircularProgressIndicator()
                                                        :
                                                        FadeInImage(
                                                            placeholder: AssetImage("asset/place_holder.png"),
                                                            image: AssetImage("asset/place_holder.png")),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 05,
                                                  bottom: 02,
                                                  child: ClipOval(
                                                    child: Material(
                                                      color: Colors.transparent, // button color
                                                      child: InkWell(
                                                        splashColor: Colors.blue, // inkwell color
                                                        child: SizedBox(
                                                            width: 30,
                                                            height: 30,
                                                            child: Icon(
                                                              Icons.add_a_photo,
                                                              size: 20,
                                                              color: Colors.white,
                                                            )),
                                                        onTap: () async {
                                                          await model.getImageFromGallery();

                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),


                                            RaisedButton(
                                                child: Text("Add"),
                                                onPressed: () async{
                                                await model.addUser();
                                                Navigator.pop(context);
                                            }),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )

                        ],
                        ),
                    )
            ),
          ),
        ),
//      floatingActionButton:
    );
  }
}

class UserTile extends StatelessWidget {
  User user;
  final onDelete;
  UserTile({this.user, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 50.0,
          child: ClipRRect(
            child: FadeInImage(
              placeholder: AssetImage("asset/place_holder.png"),
              image: user.avatar ==  null ? AssetImage("asset/place_holder.png") :NetworkImage(
                user.avatar
              ),
            )
          ),
        ),
        title: Text(user.id ??'Two-line ListTile'),
        subtitle: Text(user.name ??'Here is a second line'),
        trailing: IconButton(
          onPressed: onDelete,
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}



class InputTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String icon;
  final bool isPassword;
  final bool setBorder;
  final onChange;
  final inputType;
  final validator;
  final controller;

  InputTextField(
      {this.labelText,
        this.hintText,
        this.icon,
        this.isPassword = false,
        this.setBorder = false,
        this.onChange,
        this.inputType,
        this.validator,
        this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          color: Colors.black
      ),
      controller: this.controller ?? TextEditingController(),
      validator: validator,
      keyboardType: inputType ?? TextInputType.text,
      onChanged: onChange,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.add),
        border: setBorder ? OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ):InputBorder.none,
//        contentPadding: setBorder ? EdgeInsets.symmetric(horizontal: 10) : EdgeInsets.symmetric(horizontal: 0),
        hintText: "$hintText",
        labelText: "$labelText",
        prefixIconConstraints: BoxConstraints.expand(
          width: 40.0,
          height: 40.0,
        ),
        labelStyle: TextStyle(
          color: Colors.blueGrey,
          fontSize: 14.0,
        ),
        hintStyle: TextStyle(
          color: Color(0xFFD9D9D9),
          fontSize: 14.0,
        ),
      ),
    );
  }
}
