import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:state_management/utils/app_route_constants.dart';
import 'package:state_management/views/tabbar/about.dart';
import 'package:state_management/views/tabbar/contact_us.dart';
import 'package:state_management/views/tabbar/error_page.dart';
import 'package:state_management/views/tabbar/home.dart';
import 'package:state_management/views/tabbar/profile.dart';

class MyApproutes {
  static GoRouter returnRouter(bool isAuth) {
    GoRouter router = GoRouter(
      routes: [
        GoRoute(
          name: MyAppRouteConstants.homeRouteName,
          path: '/',
          
           builder: (BuildContext context, GoRouterState state) {
            return const Home();
          },
          // pageBuilder: (context, state) {
          //   return MaterialPage(child: Home());
          // },
        ),
        GoRoute(
          name: MyAppRouteConstants.profileRouteName,
          path: '/profile/:username/:userid',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: Profile(
              userid: state.pathParameters['userid']!,
              username: state.pathParameters['username']!,
            ));
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.aboutRouteName,
          path: '/about',
          pageBuilder: (context, state) {
            return MaterialPage(child: About());
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.contactUsRouteName,
          path: '/contact_us',
          pageBuilder: (context, state) {
            return MaterialPage(child: ContactUS());
          },
        )
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(child: ErrorPage());
      },
      // redirect: (context, state) {
      //   if (!isAuth &&
      //       state.location
      //           .startsWith('/${MyAppRouteConstants.profileRouteName}')) {
      //     return context.namedLocation(MyAppRouteConstants.contactUsRouteName);
      //   } else {
      //     return null;
      //   }
      // },
    );
    return router;
  }
}
