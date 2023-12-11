import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:state_management/domain/entity/user_model.dart';
import 'package:state_management/domain/repository/api_services.dart';

part 'getuser_event.dart';
part 'getuser_state.dart';

class GetuserBloc extends Bloc<GetuserEvent, GetuserState> {
  GetuserBloc() : super(GetuserLoding()) {
    on<InitialGetuserEvent>(initialGetuserEvent);
    on<LoadMoreGetuserEvent>(loadMoreGetuserEvent);
  }  
    RefreshController refreshController =RefreshController(initialRefresh: false);
  FutureOr<void> initialGetuserEvent(InitialGetuserEvent event, Emitter<GetuserState> emit) async{
      try {
                final res = await ApiService().getUsers(event.offset,event.limit);
                if(res.success ==true)  
                { 
                    emit(GetuserLodded(userModel: res));                                        
                }
                else
                {
                    emit(GetuserError(error: res.toString()));
                }

          } catch (e) 
          {            
            emit(GetuserError(error: e.toString()));
          }
  }

  FutureOr<void> loadMoreGetuserEvent(LoadMoreGetuserEvent event, Emitter<GetuserState> emit) async{
      try {
                final res = await ApiService().getUsers(event.offset,event.limit);
                if(res.success ==true)  
                { 
                    if(event.offset>=1)
                    {
                      if(state is GetuserLodded)
                      {          
                        try {
                              final currentState = state as GetuserLodded;
                              final updatedUsersList = [...currentState.userModel.users!, ...res.users!];
                              final updatedUserModel = currentState.userModel.copyWith(users: updatedUsersList,limit: res.limit,offset: res.offset);
                              emit(GetuserLodded(userModel: updatedUserModel));  
                              refreshController.loadComplete();
                              refreshController.refreshCompleted();                            
                        } catch (e) {
                          print(e.toString());
                          emit(GetuserError(error: res.toString()));
                        }                      
                        
                      }
                    }
                }
                else
                {
                    emit(GetuserError(error: res.toString()));
                }

          } catch (e) 
          {            
            emit(GetuserError(error: e.toString()));
          }
  }
}
