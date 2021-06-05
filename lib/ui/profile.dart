import 'dart:async';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cms/blocs/posts/posts_bloc.dart';
import 'package:cms/blocs/profile/profile_bloc.dart';
import 'package:cms/constants.dart';
import 'package:cms/data/model/user_posts.dart';
import 'package:cms/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_responsive/flutter_responsive.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // const oneSec = const Duration(seconds: 1);
    // Timer.periodic(oneSec, (Timer t) => print('hi!'));

    print(Random().nextInt(2000));
    // final ScrollController scrollController = ScrollController();
    // double heightPosts = 0.48;
    // double scrollAnimateContanier = 0;
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        // print(state);
      },
      builder: (context, state) {
        print(state);
        if (state is ProfileInitialState) {
          BlocProvider.of<ProfileBloc>(context).add(GetUserInfo());
          return Loading();
        }

        if (state is ProfileIsReadyState) {
          // print(state.heightPosts);
          return Scaffold(
            backgroundColor: kMainColor,
            body: ListView(
              children: profile(context, state),
            ),
            // floatingActionButton: showDraggableScrollableSheet(context),
          );
        }
      },
    );
  }
}

profile(context, ProfileIsReadyState state) {
  List<Widget> list = [];
  list.addAll([
    Container(
      // color: Colors.red,
      height: MediaQuery.of(context).size.height / 2,
      child: Stack(
        children: [
          Container(
            child: Image(
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
                image: AssetImage('images/background_profile.jpeg')),
          ),
          Container(
            // -0.3,MediaQuery.of(context).size.height / -2.95 / 1000
            alignment: Alignment(0, 0.3),
            height: MediaQuery.of(context).size.height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(122),
              child: Container(
                // alignment: Alignment(0, -50),
                width: 122,
                height: 122,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            // -0.295,MediaQuery.of(context).size.height / -3.0 / 1000
            alignment: Alignment(0, 0.295),
            height: MediaQuery.of(context).size.height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(115),
              child: Image.network(
                '${state.image}',
                fit: BoxFit.fitWidth,
                width: 115,
                height: 115,
              ),
            ),
          ),
          Container(
            //MediaQuery.of(context).size.height / 12 / 1000
            alignment: Alignment(0, 0.7),
            height: MediaQuery.of(context).size.height,
            child: Text(
              '${state.name}',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ],
      ),
    ),
  ]);

  list.addAll(state.posts.data.map<Widget>((data) {
    return Container(
      color: Color(0xff242526),
      margin: EdgeInsets.only(top: 10),

      // padding: EdgeInsets.only(top: 20),
      // alignment: Alignment(0, 0.5),
      // margin: EdgeInsets.symmetric(vertical: 350),
      // height: MediaQuery.of(context).size.height,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: (MediaQuery.of(context).size.width).toInt(),
                child: ListTile(
                  isThreeLine: true,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network("${state.image}"),
                  ),
                  title: Text(
                    "${state.name}",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: GestureDetector(
                    onTap: () {
                      return _showMyDialog(data, context);
                    },
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "${data.createDate}  ",
                        ),
                        WidgetSpan(
                          child: Icon(
                            data.status == 1 ? Icons.public : Icons.public_off,
                            size: 14,
                            color: data.status == 1 ? Colors.green : Colors.red,
                          ),
                        ),
                      ]),
                    ),
                  ),

                  //  Text(
                  //   "${data.createDate}",
                  //   style: TextStyle(color: Colors.white),
                  // ),
                ),
              ),
              Expanded(
                  flex: (MediaQuery.of(context).size.width / 3).toInt(),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 25),
                    child: DropdownButton(
                        dropdownColor: Color(0xff242526),

                        // value: "One",
                        underline: SizedBox(),
                        icon: Icon(Icons.more_vert_outlined),
                        items: <String>[
                          'Edit Post',
                          'Delete Post',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          if (newValue == "Delete Post") {
                            BlocProvider.of<ProfileBloc>(context)
                                .add(DeletePostEvent(data: data));
                          }
                        }),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${data.title}",
              style: TextStyle(color: Colors.white70),
            ),
          ),
          data.media.length > 1
              ? CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                  ),
                  items: data.media.map((photo) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Image.network("${photo.url}",
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.fill),
                    );
                  }).toList(),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 80,
                  child:
                      Image.network('${data.media[0]?.url}', fit: BoxFit.fill)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${data.description}",
              style: TextStyle(color: Colors.white70),
            ),
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<PostsBloc>(context)
                  .add(FetchPostCommentsEvent(slug: data.slug, index: 1));
              Navigator.pushNamed(context, '/post-comments');
            },
            child: Container(
                height: 35,
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelStyle: TextStyle(color: Colors.white, fontSize: 17.5),
                    labelText: "Comment",
                  ),
                )),
          ),
        ],
      ),
    );
  }));
  return list;
}

_showMyDialog(Data data, context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return AlertDialog(
            title: Text('Change Status'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  ListTile(
                    title: const Text('Active'),
                    leading: Radio(
                      value: 1,
                      groupValue: data.status,
                      onChanged: (value) {
                        BlocProvider.of<ProfileBloc>(context).add(
                            ChangeStatusOfPostEvent(status: value, data: data));
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Inactive'),
                    leading: Radio(
                      value: 0,
                      groupValue: data.status,
                      onChanged: (value) {
                        BlocProvider.of<ProfileBloc>(context).add(
                            ChangeStatusOfPostEvent(status: value, data: data));
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('save'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}

// showDraggableScrollableSheet(BuildContext context) {
//   return SizedBox.expand(
//     child: DraggableScrollableSheet(
//       builder: (BuildContext context, ScrollController scrollController) {
//         return Container(
//           color: kAppBarColor,
//           child: ListView.builder(
//             controller: scrollController,
//             itemCount: 25,
//             itemBuilder: (BuildContext context, int index) {
//               return ListTile(title: Text('Item $index'));
//             },
//           ),
//         );
//       },
//     ),
//   );
// }
// AnimatedContainer(
//   color: kMainColor,
//   duration: Duration(milliseconds: 500),
//   curve: Curves.easeInOut,
//   margin: EdgeInsets.only(
//       top: MediaQuery.of(context).size.height *
//           state.heightPosts),
//   child: ListView.builder(
//     controller: scrollController,
//     itemCount: state.posts.data.length,
//     itemBuilder: (context, index) {
//       return Container(
//         color: Color(0xff242526),
//         margin: EdgeInsets.only(top: 10),

//         // padding: EdgeInsets.only(top: 20),
//         // alignment: Alignment(0, 0.5),
//         // margin: EdgeInsets.symmetric(vertical: 350),
//         // height: MediaQuery.of(context).size.height,
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   flex: (MediaQuery.of(context).size.width)
//                       .toInt(),
//                   child: ListTile(
//                     isThreeLine: true,
//                     leading: ClipRRect(
//                       borderRadius: BorderRadius.circular(25),
//                       child: Image.network("${state.image}"),
//                     ),
//                     title: Text(
//                       "${state.name}",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     subtitle: Text(
//                       "${state.posts.data[index].createDate}",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                     flex:
//                         (MediaQuery.of(context).size.width / 3)
//                             .toInt(),
//                     child: Container(
//                       margin: EdgeInsets.only(bottom: 25),
//                       child: DropdownButton(
//                           dropdownColor: Color(0xff242526),

//                           // value: "One",
//                           underline: SizedBox(),
//                           icon: Icon(Icons.more_vert_outlined),
//                           items: <String>[
//                             'Edit Post',
//                             'Delete Post',
//                           ].map<DropdownMenuItem<String>>(
//                               (String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value,
//                                   style: TextStyle(
//                                       color: Colors.white)),
//                             );
//                           }).toList(),
//                           onChanged: (String newValue) {
//                             if (newValue == "Delete Post") {
//                               BlocProvider.of<ProfileBloc>(
//                                       context)
//                                   .add(DeletePostEvent(
//                                       index: index));
//                             }
//                           }),
//                     )),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 "${state.posts.data[index].title}",
//                 style: TextStyle(color: Colors.white70),
//               ),
//             ),
//             state.posts.data[index].media.length > 1
//                 ? CarouselSlider(
//                     options: CarouselOptions(
//                       viewportFraction: 1,
//                     ),
//                     items: state.posts.data[index].media
//                         .map((photo) {
//                       return Container(
//                         margin: EdgeInsets.symmetric(
//                             horizontal: 5.0),
//                         decoration:
//                             BoxDecoration(color: Colors.amber),
//                         child: Image.network("${photo.url}",
//                             width: MediaQuery.of(context)
//                                 .size
//                                 .width,
//                             height: MediaQuery.of(context)
//                                 .size
//                                 .height,
//                             fit: BoxFit.fill),
//                       );
//                     }).toList(),
//                   )
//                 : Container(
//                     width: MediaQuery.of(context).size.width,
//                     // height: 80,
//                     child: Image.network(
//                         '${state.posts.data[index].media[0]?.url}',
//                         fit: BoxFit.fill)),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 "${state.posts.data[index].description}",
//                 style: TextStyle(color: Colors.white70),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {},
//               child: Container(
//                   height: 35,
//                   child: TextField(
//                     enabled: false,
//                     decoration: InputDecoration(
//                       disabledBorder: OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: Colors.white),
//                       ),
//                       labelStyle: TextStyle(
//                           color: Colors.white, fontSize: 17.5),
//                       labelText: "Comment",
//                     ),
//                   )),
//             ),
//           ],
//         ),
//       );
//     },
//   ),
// ),
// GestureDetector(
//   onPanDown: (s) {
//     // scrollController.addListener(() {
//     //   scrollAnimateContanier = scrollController.offset;
//     // });
//     // if (state.heightPosts == 0.0 &&
//     //     scrollAnimateContanier == 0) {
//     //   // print('hello');S
//     //   BlocProvider.of<ProfileBloc>(context)
//     //       .add(ChangeStyleEvent(heightPosts: 0.48));
//     // }
//     // if (state.heightPosts > 0.0 &&
//     //     scrollAnimateContanier > 1) {
//     //   BlocProvider.of<ProfileBloc>(context)
//     //       .add(ChangeStyleEvent(heightPosts: 0.0));
//     //   // scrollController.animateTo(
//     //   //     scrollController.position.minScrollExtent,
//     //   //     duration: Duration(milliseconds: 500),
//     //   //     curve: Curves.fastOutSlowIn);
//     // }
//   },
//   child:AnimatedContainer(
//   color: kMainColor,
//   duration: Duration(milliseconds: 500),
//   curve: Curves.easeInOut,
//   margin: EdgeInsets.only(
//       top: MediaQuery.of(context).size.height *
//           state.heightPosts),
//   child: ListView.builder(
//     controller: scrollController,
//     itemCount: state.posts.data.length,
//     itemBuilder: (context, index) {
//       return Container(
//         color: Color(0xff242526),
//         margin: EdgeInsets.only(top: 10),

//         // padding: EdgeInsets.only(top: 20),
//         // alignment: Alignment(0, 0.5),
//         // margin: EdgeInsets.symmetric(vertical: 350),
//         // height: MediaQuery.of(context).size.height,
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   flex: (MediaQuery.of(context).size.width)
//                       .toInt(),
//                   child: ListTile(
//                     isThreeLine: true,
//                     leading: ClipRRect(
//                       borderRadius:
//                           BorderRadius.circular(25),
//                       child:
//                           Image.network("${state.image}"),
//                     ),
//                     title: Text(
//                       "${state.name}",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     subtitle: Text(
//                       "${state.posts.data[index].createDate}",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                     flex:
//                         (MediaQuery.of(context).size.width /
//                                 3)
//                             .toInt(),
//                     child: Container(
//                       margin: EdgeInsets.only(bottom: 25),
//                       child: DropdownButton(
//                           dropdownColor: Color(0xff242526),

//                           // value: "One",
//                           underline: SizedBox(),
//                           icon: Icon(
//                               Icons.more_vert_outlined),
//                           items: <String>[
//                             'Edit Post',
//                             'Delete Post',
//                           ].map<DropdownMenuItem<String>>(
//                               (String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value,
//                                   style: TextStyle(
//                                       color: Colors.white)),
//                             );
//                           }).toList(),
//                           onChanged: (String newValue) {
//                             if (newValue == "Delete Post") {
//                               BlocProvider.of<ProfileBloc>(
//                                       context)
//                                   .add(DeletePostEvent(
//                                       index: index));
//                             }
//                           }),
//                     )),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 "${state.posts.data[index].title}",
//                 style: TextStyle(color: Colors.white70),
//               ),
//             ),
//             state.posts.data[index].media.length > 1
//                 ? CarouselSlider(
//                     options: CarouselOptions(
//                       viewportFraction: 1,
//                     ),
//                     items: state.posts.data[index].media
//                         .map((photo) {
//                       return Container(
//                         margin: EdgeInsets.symmetric(
//                             horizontal: 5.0),
//                         decoration: BoxDecoration(
//                             color: Colors.amber),
//                         child: Image.network("${photo.url}",
//                             width: MediaQuery.of(context)
//                                 .size
//                                 .width,
//                             height: MediaQuery.of(context)
//                                 .size
//                                 .height,
//                             fit: BoxFit.fill),
//                       );
//                     }).toList(),
//                   )
//                 : Container(
//                     width:
//                         MediaQuery.of(context).size.width,
//                     // height: 80,
//                     child: Image.network(
//                         '${state.posts.data[index].media[0]?.url}',
//                         fit: BoxFit.fill)),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 "${state.posts.data[index].description}",
//                 style: TextStyle(color: Colors.white70),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {},
//               child: Container(
//                   height: 35,
//                   child: TextField(
//                     enabled: false,
//                     decoration: InputDecoration(
//                       disabledBorder: OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: Colors.white),
//                       ),
//                       labelStyle: TextStyle(
//                           color: Colors.white,
//                           fontSize: 17.5),
//                       labelText: "Comment",
//                     ),
//                   )),
//             ),
//           ],
//         ),
//       );
//     },
//   ),
// ),
// )
/*
 ListView.builder(
                itemCount: state.posts.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Color(0xff242526),
                    // alignment: Alignment(0, 0.5),
                    // margin: EdgeInsets.symmetric(vertical: 350),
                    // height: MediaQuery.of(context).size.height,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: ListTile(
                                isThreeLine: true,
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.network("${state.image}"),
                                ),
                                title: Text(
                                  "${state.name}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  "${state.posts.data[index].createDate}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.only(bottom: 25),
                              child: DropdownButton(
                                  dropdownColor: Color(0xff242526),

                                  // value: "One",
                                  underline: SizedBox(),
                                  icon: Icon(Icons.more_vert_outlined),
                                  items: <String>[
                                    'Edit Post',
                                    'Delete Post',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style:
                                              TextStyle(color: Colors.white)),
                                    );
                                  }).toList(),
                                  onChanged: (String newValue) {
                                    print(newValue);
                                  }),
                            )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${state.posts.data[index].title}",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        state.posts.data[index].media.length > 1
                            ? CarouselSlider(
                                options: CarouselOptions(
                                  viewportFraction: 1,
                                ),
                                items:
                                    state.posts.data[index].media.map((photo) {
                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:
                                        BoxDecoration(color: Colors.amber),
                                    child: Image.network("${photo.url}",
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        fit: BoxFit.fill),
                                  );
                                }).toList(),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                // height: 80,
                                child: Image.network(
                                    '${state.posts.data[index].media[0]?.url}',
                                    fit: BoxFit.fill)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${state.posts.data[index].description}",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              height: 35,
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 17.5),
                                  labelText: "Comment",
                                ),
                              )),
                        ),
                      ],
                    ),
                  );
                },
              ),
 */
