import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:state_management/domain/entity/user_model.dart';
import 'package:state_management/domain/repository/api_services.dart';


// final pageCall = FutureProvider.family<UserModel,Map>((ref, arg) async{
//  final res = await ApiService().getUsers(arg['offset'],arg['limit']);
//   return res;
// });

class PageNotifier extends StateNotifier<UserModel?> {
  PageNotifier() : super(null);

  Future<void> firstPage() async {
    final res = await ApiService().getUsers(1, 20);
    if (res.success != null && res.success == true) {
      state = UserModel.fromJson(res.toJson());
    }
  }

  Future<void> loadPage(int offset, int limit) async {
    if (state != null && state!.offset! > 1) {
      final res = await ApiService().getUsers(offset, limit);
      final updatedUsersList = [...state!.users!, ...res.users!];
      state = state!.copyWith(users: updatedUsersList, limit: res.limit, offset: res.offset);
    }
  }
}

final userStateNotifier = StateNotifierProvider((ref) => PageNotifier());

final refreshControllerProvider = Provider<RefreshController>((ref) {
  return RefreshController(initialRefresh: false);
});

final userModelProvider = FutureProvider<UserModel?>((ref) async {
  final pageNotifier = ref.read(userStateNotifier.notifier);
  if (pageNotifier.state == null) {
    await pageNotifier.firstPage();
  }
  return pageNotifier.state;
});

class StateNotifierPage extends ConsumerWidget {
  const StateNotifierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshController = ref.read(refreshControllerProvider);
    final userModelAsyncValue = ref.watch(userModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('State Notifier Provider'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            if (userModelAsyncValue.asData?.value != null) // Use userModelAsyncValue.data instead of value
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: refreshController,
                  onRefresh: () async {
                    try {
                      await ref.read(userStateNotifier.notifier).firstPage().then((value) => refreshController.refreshCompleted());
                    } catch (e) {
                      refreshController.refreshCompleted();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  onLoading: () async {
                    try {
                      print(userModelAsyncValue.asData);
                      final offsetValue =await (userModelAsyncValue.asData?.value?.offset ?? 1) + 1; // Use userModelAsyncValue.data
                      await ref.read(userStateNotifier.notifier).loadPage(offsetValue, 20).then((value) {
                        refreshController.loadComplete();
                      });
                    } catch (e) {
                      refreshController.loadComplete();
                      refreshController.refreshCompleted();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: ListView.builder(
                    itemCount: userModelAsyncValue.asData?.value?.users?.length ?? 0, // Use userModelAsyncValue.data
                    itemBuilder: (context, int index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              if (userModelAsyncValue.asData?.value?.users?[index].profilePicture == '') ...[
                                CircleAvatar(
                                  radius: 32.5,
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                  child: Center(
                                    child: Text(
                                      '${userModelAsyncValue.asData?.value?.users?[index].firstName?[0].toUpperCase()}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                )
                              ] else ...[
                                CircleAvatar(
                                  radius: 32.5,
                                  backgroundImage: CachedNetworkImageProvider(
                                    userModelAsyncValue.asData?.value?.users?[index].profilePicture ?? '',
                                  ),
                                ),
                              ],
                              const SizedBox(width: 12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(userModelAsyncValue.asData?.value?.users?[index].firstName ?? ''),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
