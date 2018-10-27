import 'package:test/test.dart';
import 'package:bitbuddy/utils/routers.dart';

void main() {

  test('Routes testing', () {

    var home = Routers.home;
    expect(home, Routers.home);

    var splash = Routers.splash;
    expect(splash, Routers.splash);
  });
}