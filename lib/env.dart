import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'OPEN_WEATHER_MAP_API_KEY')
  static const open_weather_map_api_key = _Env.open_weather_map_api_key;
}
