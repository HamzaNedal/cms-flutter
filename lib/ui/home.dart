import 'dart:math';

import 'package:cms/blocs/posts/posts_bloc.dart';
import 'package:cms/blocs/profile/profile_bloc.dart';
import 'package:cms/constants.dart';
import 'package:cms/ui/profile.dart';
import 'package:cms/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HomeScreen extends StatelessWidget {
  double screenWidth = 0;
  double screenHeight = 0;
  @override
  Widget build(BuildContext context) {
    var bloc_provider = BlocProvider.of<PostsBloc>(context);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    bool isLoading = false;
    List<Widget> pages = [
      homePosts(bloc_provider, isLoading),
      Loading(),
      Profile()
    ];
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        return Scaffold(
          // drawer: Drawer(
          //   child: Container(
          //     color: kMainColor,
          //   ), // Populate the Drawer in the next step.
          // ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: kAppBarColor,
              title: Text(
                'Home Page',
                style: TextStyle(fontSize: 15),
              ),
              actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
            ),
          ),
          backgroundColor: kMainColor,
          body: Center(
            child: pages[bloc_provider.currentIndexBottomNavigationBar],
          ),

          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: kAppBarColor,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.search),
              //   label: 'Search',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
            currentIndex: bloc_provider.currentIndexBottomNavigationBar,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: (value) {
              bloc_provider.add(ClickBottomNavigationBarEvent(index: value));
              BlocProvider.of<ProfileBloc>(context)
                  .add(ChangeStyleEvent(heightPosts: 0.48));
            },
          ),
        );
      },
    );
  }

  Widget homePosts(bloc_provider, isLoading) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 12,
          child: SingleChildScrollView(
            child: BlocConsumer<PostsBloc, PostsState>(
              listener: (context, state) {
                if (state is PostsCommentsLoadingState) {
                  Navigator.pushNamed(context, '/post-comments');
                }
                if (state is PostsLoadingMoreState) {
                  bloc_provider.isRefreshingPage = true;
                }
                return Loading();
              },
              builder: (context, state) {
                // print(state);
                if (state is PostsLoadingState) {
                  if (bloc_provider.postsData.length == 0 ||
                      bloc_provider.isRefreshingPage) {
                    return Loading();
                  }
                  // return CircularProgressIndicator();
                } else if (state is PostsLoadedState ||
                    state is PostsLoadingMoreState) {
                  isLoading = false;
                  return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        // print(isLoading);
                        if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent &&
                            isLoading == false &&
                            bloc_provider.meta.currentPage <
                                bloc_provider.meta.lastPage) {
                          isLoading = true;
                          bloc_provider.add(FetchMorePostsEvent(
                            toPage: bloc_provider.meta.currentPage + 1,
                          ));
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.123,
                        child: show_posts(
                            context, bloc_provider, screenWidth, screenHeight),
                      ));
                } else if (state is PostsErrorState) {
                  return Text(
                    'We are sorry try again',
                    style: TextStyle(color: Colors.white),
                  );
                }
                return Center();
              },
            ),
          ),
        ),
        BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is PostsLoadingMoreState) {
              return Expanded(
                  flex: 1,
                  child: Container(
                    color: kMainColor,
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      backgroundColor: kAppBarColor,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ));
            }

            return Container();
          },
        )
      ],
    );
  }

  Widget show_posts(
      BuildContext context, PostsBloc blocProvider, screenWidth, screenHeight) {
    // final ItemScrollController itemScrollController = ItemScrollController();
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();

    return RefreshIndicator(
      backgroundColor: kAppBarColor,
      onRefresh: () async {
        await blocProvider.add(FetchPostsWhenRefeshEvent());
      },
      child: ScrollablePositionedList.builder(
        padding: EdgeInsets.only(top: 10),
        itemCount: blocProvider.postsData.length,
        itemBuilder: (context, i) {
          // itemPositionsListener.itemPositions.addListener(() {
          //   print(itemPositionsListener.itemPositions.value);
          //   bloc_provider.initialScrollIndex =
          //       itemPositionsListener.itemPositions.value.first.index;
          // });
          return Card(
            color: Color(0xff242526),
            margin: EdgeInsets.only(bottom: 15),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                        "${blocProvider.postsData[i].author.userImage}"),
                  ),
                  title: Text(
                    "${blocProvider.postsData[i].author.name}",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    '${blocProvider.postsData[i].createDate}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "${blocProvider.postsData[i].title}",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                blocProvider.postsData[i].media.length > 1
                    ? CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1,
                        ),
                        items: blocProvider.postsData[i].media.map((photo) {
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
                    : Image.network("${blocProvider.postsData[i].media[0].url}",
                        fit: BoxFit.fill),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "${blocProvider.postsData[i].description}",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    blocProvider.add(FetchPostCommentsEvent(
                        slug: blocProvider.postsData[i].slug, index: i));
                  },
                  child: Container(
                      width: screenWidth,
                      height: screenHeight / 20, // do it in both Container
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: TextStyle(
                              color: Colors.white, fontSize: screenHeight / 45),
                          labelText: "Comment",
                        ),
                      )),
                ),
              ],
            ),
          );
        },
        itemPositionsListener: itemPositionsListener,
        initialScrollIndex: blocProvider.initialScrollIndex,
      ),
    );
  }
}
