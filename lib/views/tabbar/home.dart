import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:state_management/blocs/get_user_bloc/getuser_bloc.dart';
import 'package:state_management/utils/app_route_constants.dart';
import 'package:state_management/views/pagination_list_cubit.dart';
import 'package:state_management/views/simple_provider.dart';
import 'package:state_management/views/state_notifier_pagination.dart';
import 'package:state_management/views/state_provider.dart';
import 'package:state_management/views/user_list_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All state management tools',
          style: TextStyle(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaginationListBycubit()));
              },
              child: Container(
                height: 45,
                child: const Row(
                  children: [Expanded(child: Text('Pagination with cubit'))],
                ),
              ),
            ),
            const Divider(height: 1),
            GestureDetector(
              onTap: () {
                
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => GetuserBloc()..add(const InitialGetuserEvent(1, 20)),
                              child: UserPageList(20, 1),
                            )));
              },
              child: Container(
                height: 45,
                child: const Row(
                  children: [Expanded(child: Text('Pagination with bloc'))],
                ),
              ),
            ),
            const Divider(height: 1),
             GestureDetector(
              onTap: () {                
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const SimpleProvider('Yes Featch String from provider')));
              },
              child: Container(
                height: 45,
                child: const Row(
                  children: [Expanded(child: Text('Pagination with Riverpod'))],
                ),
              ),
            ),
            const Divider(height: 1),

             GestureDetector(
              onTap: () {                
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const StateNotifierPage()));
              },
              child: Container(
                height: 45,
                child: const Row(
                  children: [Expanded(child: Text('Pagination with Riverpod'))],
                ),
              ),
            ),
            const Divider(height: 1),
              GestureDetector(
              onTap: () {                
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SimpleStateCounterProvider()));
              },
              child: Container(
                height: 45,
                child: const Row(
                  children: [Expanded(child: Text('Simple state provider'))],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
