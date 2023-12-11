import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/blocs/number_cubit/pagination_list_cubit.dart';

class PaginationListBycubit extends StatefulWidget {
  const PaginationListBycubit({super.key});

  @override
  State<PaginationListBycubit> createState() => _PaginationListBycubitState();
}

class _PaginationListBycubitState extends State<PaginationListBycubit> {
  PaginationListCubit paginationListCubit = PaginationListCubit();
  int first = 0;
  int last = 20;
  int page = 1;
  final scrollController = ScrollController();
  final bool isFirst =true;
  void setupSrollcontroller()
  {
    
    scrollController.addListener(() {
      if(scrollController.position.atEdge)
      {
        if(scrollController.position.pixels !=0)
        {
          paginationListCubit.pageLoadList(first, last, page=page+1);
        }
      }
    });
  }
  @override
  void initState() {
    super.initState();
      paginationListCubit.pageLoadList(0, last, page);    
    setupSrollcontroller();  
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }  
@override
  void didUpdateWidget(covariant PaginationListBycubit oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cubit Listview',
          style: TextStyle(),
        ),
        actions: [
          IconButton(onPressed: (){
            paginationListCubit.addNewelementAtlast(Random().nextInt(5000000));
          }, icon:const Icon(Icons.add))
        ],
      ),
      body: BlocConsumer<PaginationListCubit, PaginationListState>(
        bloc: paginationListCubit,
        listener: (context, state) {},
        // listenWhen: (previous, current) =>current is ItemActionState,
        // buildWhen: (previous, current) => current is! ItemActionState,
        builder: (context, state) {          
          List<int> mainList =[];
          if(state is PaginationListLoging && state.isfirstFetch)
          {
            return const Center(child: CircularProgressIndicator());
          }
          else if(state is PaginationListLoging)
          {
                mainList=state.oldList;
          }
          else if (state is PaginationListLoaded) 
          {
                mainList = state.itemList;
          }    
           return Stack(
                     alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                  children: [
                    ListView.builder(
                      controller: scrollController,
                      itemCount: mainList.length,
                      itemBuilder: (context,int index){
                        return Column(
                          children: [
                            GestureDetector(
                              onLongPress: (){
                                paginationListCubit.removeValue(index);
                              },
                              onTap: ()async{                                
                                paginationListCubit.updateValue(index,Random().nextInt(100));
                                // context.read<PaginationListCubit>().updateValue(index,Random().nextInt(100));
                              },
                              child: Container(
                                color: Colors.transparent,
                                height: 45,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      Center(child: Text(mainList[index].toString()))
                                  ],
                                ),
                              ),
                            ),
                           const Divider(height: 1,),
                          ],
                        );
                      }),
                         if (state is PaginationListLoging)...[
                               _loadingIndicator()
                            ]
                  ],
                );
        },
      ),
    );
  }


  Widget _loadingIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }


}
