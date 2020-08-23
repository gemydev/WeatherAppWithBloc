import 'package:bloc/bloc.dart';
import 'package:json_http_test/bloc/bloc.dart';
import 'package:json_http_test/bloc/weather_state.dart';
import 'package:json_http_test/data/WeatherRepo.dart';
import 'package:json_http_test/data/weather_model.dart';


class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{

  WeatherRepo weatherRepo;

  WeatherBloc(this.weatherRepo);

  @override
  WeatherState get initialState => WeatherIsNotSearched();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async*{
    if(event is FetchWeather){
      yield WeatherIsLoading();
      try{
        WeatherModel weather = await weatherRepo.getWeather(event.city);
        yield WeatherIsLoaded(weather);
      }catch(_){
        print(_);
        yield WeatherIsNotLoaded();
      }
    }else if(event is ResetWeather){
      yield WeatherIsNotSearched();
    }
  }

}
