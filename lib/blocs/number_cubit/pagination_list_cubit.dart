import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'pagination_list_state.dart';

class PaginationListCubit extends Cubit<PaginationListState> {
  PaginationListCubit() : super(PaginationListInitial());

  void pageLoadList(int first, int last, int page) {
    if (state is PaginationListLoging) return;
    final currentState = state;
    List<int> oldList = [];
    if (currentState is PaginationListLoaded) {
      oldList = currentState.itemList;
    }
        
    List<int> itemList = [];
    try {      
      if (page <= 5) {
        emit(PaginationListLoging(oldList:oldList,isfirstFetch: page==1));
        for (int i = oldList.length; i < oldList.length + 20; i++) {
          itemList.add(i);
        }
        final list = oldList + itemList;
        Future.delayed(const Duration(seconds: 1)).then((value) => emit(PaginationListLoaded(itemList: list)));        
      }
      else
      {
        Future.delayed(const Duration(seconds: 1)).then((value) => emit(PaginationListLoaded(itemList: oldList)));        
      }
    } catch (e) {
      emit(PaginationListError(errorLog: e.toString()));
    }
  }

  Future<void> updateValue(int index, int nextInt) async {
  final currentState = state;
  if (currentState is PaginationListLoaded) {
    // Create a copy of the list with the updated value
    final updatedItemList = List<int>.from(currentState.itemList);
    updatedItemList[index] = nextInt;
    // Emit the new state with the updated list
    emit(PaginationListLoaded(itemList: updatedItemList));
  }
}

  void addNewelementAtlast(int element) {
    final currentState  =state;
    if(currentState is PaginationListLoaded)
    {
        final updatedItemList = List<int>.from(currentState.itemList);
        updatedItemList.add(element);
        emit(PaginationListLoaded(itemList: updatedItemList));
    }
  }

   Future<void> removeValue(int index) async {
  final currentState = state;
  if (currentState is PaginationListLoaded) {
    // Create a copy of the list with the updated value
    final updatedItemList = List<int>.from(currentState.itemList);
    updatedItemList.removeAt(index);
    // Emit the new state with the updated list
    emit(PaginationListLoaded(itemList: updatedItemList));
  }
}

}
