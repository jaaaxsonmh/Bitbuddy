import 'package:bitbuddy/utils/routers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('Routes testing', () {

    var home = Routers.home;
    expect(home, Routers.home);

    var splash = Routers.splash;
    expect(splash, Routers.splash);
  });
}