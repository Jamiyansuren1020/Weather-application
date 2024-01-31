import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/data/data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async{
      emit(WeatherBlocLoading());
      try{
         WeatherFactory weatherFactory = WeatherFactory(API_KEY, language: Language.ENGLISH);

         Weather weather = await weatherFactory.currentWeatherByLocation(
          event.position.latitude, 
          event.position.longitude);
          print(weather);
         emit(WeatherBlocSuccess(weather));
      } catch (error) {
        emit(WeatherBlocFailed());
      }
    });
  }
}
