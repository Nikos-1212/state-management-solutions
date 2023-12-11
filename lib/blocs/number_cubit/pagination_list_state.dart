part of 'pagination_list_cubit.dart';

sealed class PaginationListState extends Equatable {
  const PaginationListState();

  @override
  List<Object> get props => [];
}

sealed class ActionState extends PaginationListState {
  @override
  List<Object> get props => [];
}

final class PaginationListInitial extends PaginationListState {
List<Object> get props => [];
}

final class PaginationListLoging extends PaginationListState {
  const PaginationListLoging({required this.oldList,required this.isfirstFetch});
  final List<int> oldList;
  final bool isfirstFetch;
    @override
  List<Object> get props => [oldList,isfirstFetch];
}

final class PaginationListLoaded extends PaginationListState {
  const PaginationListLoaded({required this.itemList});
  final List<int> itemList;
  @override
  List<Object> get props => [itemList];
}

final class PaginationListError extends PaginationListState {
  PaginationListError({required this.errorLog});
  final String errorLog;
    @override
  List<Object> get props => [errorLog];
}


final class ItemActionState extends ActionState {  
}