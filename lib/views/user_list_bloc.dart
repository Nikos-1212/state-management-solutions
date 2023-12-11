// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:state_management/blocs/get_user_bloc/getuser_bloc.dart';

class UserPageList extends StatelessWidget {
   UserPageList(this.limit,this.offset,{super.key});

int offset;
int limit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bloc Listview',
          style: TextStyle(),
        ),
        // actions: [
        //   IconButton(onPressed: (){
        //   }, icon:const Icon(Icons.add))
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<GetuserBloc, GetuserState>(
          listener: (context, state) {          
          },
          builder: (context, state) {
            if(state is GetuserLoding)
            {
              return const Center(child: CircularProgressIndicator());
            }
            else if(state is GetuserError)
            {
              return Center(child: Text(state.error));
            }
            else if(state is GetuserLodded)
            {
                final res = state.userModel.users??[];
                  return SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      controller: context.read<GetuserBloc>().refreshController,
                      onRefresh: ()async{
                        try {
                          offset=1;
                          limit=20;
                          await Future.delayed(const Duration(milliseconds: 1000));                          
                          context.read<GetuserBloc>().add(const InitialGetuserEvent(1, 20));  
                          context.read<GetuserBloc>().refreshController.refreshCompleted();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                        }                          
                      },
                      onLoading: ()async{                        
                              offset=state.userModel.offset??0+1;
                              context.read<GetuserBloc>().add(LoadMoreGetuserEvent(offset, limit));                                                                           
                      },
                    child: ListView.builder(
                      itemCount: res.length,
                      itemBuilder: (context,int index){
                          return Column(
                            children: [
                                Row(
                                  children: [
                                      if(res[index].profilePicture=='')...[
                                        CircleAvatar(
                                            radius: 32.5,
                                            backgroundColor:Theme.of(context).colorScheme.secondary,
                                            child: Center(
                                              child: Text(
                                                '${res[index].firstName?[0].toUpperCase()}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ),
                                          )
                        
                                      ]
                                      else ...[
                                          CircleAvatar(
                                            radius:32.5,
                                             backgroundImage: CachedNetworkImageProvider(
                                                res[index].profilePicture??'',
                                              ),
                                          ),  
                                      ],
                        
                                     const SizedBox(width: 12,)                          ,
                                     Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                            Text(res[index].firstName??'')
                                      ],  
                                     )
                        
                                  ],
                                ),
                                const Divider(),
                            ],
                          );
                      }),
                  );
      
            }
            else 
            {
               return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
