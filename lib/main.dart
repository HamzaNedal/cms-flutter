import 'package:cms/blocs/auth/auth_bloc.dart';
import 'package:cms/blocs/posts/posts_bloc.dart';
import 'package:cms/data/repository/auth_repo.dart';
import 'package:cms/data/repository/comment_repo.dart';
import 'package:cms/data/repository/post_repo.dart';
import 'package:cms/ui/Auth/signup.dart';
import 'package:cms/ui/Auth/login.dart';
import 'package:cms/ui/home.dart';
import 'package:cms/ui/post_comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future getAccessToken() => Future.delayed(Duration(seconds: 1), () async {
          var pref = await SharedPreferences.getInstance();
          return pref.get('access_token');
        });
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthRepositoryImpl()),
        ),
        BlocProvider<PostsBloc>(
          create: (BuildContext context) =>
              PostsBloc(PostsImp(), CommentsImp())..add(FetchPostsEvent()),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CMS',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            // backgroundColor: Colors.black,
          ),
          initialRoute: 'loginScreen',
          routes: {
            '/login': (context) => LoginScreen(),
            '/signup': (context) => SignupScreen(),
            '/home': (context) => HomeScreen(),
            '/post-comments': (context) => PostCommentsScreen(),
          },
          home: FutureBuilder(
            future: getAccessToken(),
            builder: (context, responce) {
              if (ConnectionState.done == responce.connectionState) {
                if (responce.data != null) {
                  return HomeScreen();
                } else {
                  return LoginScreen();
                }
              } else {
                return Center(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          )),
    );
  }
}
