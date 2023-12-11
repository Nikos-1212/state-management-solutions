import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final counterProvider = StateProvider<int>((ref) => 0);
class SimpleStateCounterProvider extends ConsumerWidget {
  const SimpleStateCounterProvider({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final res = ref.watch(counterProvider);
    return Scaffold(
      body: Center(child:Text(res.toString(),style: const TextStyle(fontSize: 22),),),
      floatingActionButton: FloatingActionButton(onPressed: (){     
        ref.read(counterProvider.notifier).state++;           
      },child: const Center(child: Icon(Icons.add))),
    );
  }
}