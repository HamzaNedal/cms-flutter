import 'dart:math';

import 'package:cms/blocs/posts/posts_bloc.dart';
import 'package:cms/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCommentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("PostComments:" + Random().nextInt(2000).toString());
    return Scaffold(
        backgroundColor: kMainColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              BlocProvider.of<PostsBloc>(context).add(FetchPostsBackEvent());
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: kMainColor,
          title: const Text('Comments'),
        ),
        body: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
          if (state is PostsCommentsLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    child: ListView.builder(
                      itemCount: state.comments.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Color(0xff242526),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  // contentPadding: EdgeInsets.all(5),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.asset(
                                      "images/avatar.png",
                                      width: 30,
                                    ),
                                  ),
                                  title: Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Text(
                                      "${state.comments.data[index].name}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${state.comments.data[index].createDate}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    state.comments.data[index].comment,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                fillColor: Colors.white,
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 15),
                                hintText: "Comment",
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                  color: Colors.white,
                                  // focusColor: Colors.white,
                                  icon: Icon(Icons.send_rounded),
                                  onPressed: () {}))
                        ],
                      ),
                    ))
              ],
            );
          } else if (state is PostsCommentsLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center();
        }));
  }
}
