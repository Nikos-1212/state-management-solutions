
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum City {
  surat,
  vapi,
  valsad,
}

typedef WeatherEmojis = String;

final selectedCityWeather = StateProvider<City?>((ref) => null);//state provdier
Future<WeatherEmojis> getWeather(City city) async {
  return Future.delayed(
      const Duration(seconds: 1),
      () => {
            City.surat: '☀️',
            City.valsad: '🌨️',
            City.vapi: '💨',
          }[city]!);
}


const unknownWeatgerImojis = '🤷‍♂️';
final weatherProvider = FutureProvider((ref) {
  final city = ref.watch(selectedCityWeather);
  if (city != null) {
    return getWeather(city);
  } else {
    return unknownWeatgerImojis;
  }
});////Future provdier

class SimpleProvider extends ConsumerWidget {
  const SimpleProvider(this._firstString, {super.key});
  final String _firstString;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather riverpod future Provider'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           const SizedBox(height: 15,),
            ref.watch(weatherProvider).when(
                  data: (data) => Text(data.toString(),style:const TextStyle(fontSize: 22),),
                  error: (error, stackTrace) => Text('${error.toString()} 😢',style:const TextStyle(fontSize: 22)),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            Expanded(
                child: ListView.builder(
                    itemCount: City.values.length,
                    itemBuilder: (context, int index) {
                      final city = City.values[index];
                      final selected = city == ref.watch(selectedCityWeather);
                      return ListTile(
                        title: Text(city.name),
                        trailing: selected ? const Icon(Icons.check) : null,
                        onTap: () {
                          ref.read(selectedCityWeather.notifier).state = city;
                        },
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
