import 'package:almaty_metro/api/api.dart';
import 'package:test/test.dart';

void main() {
  test('Api should load', () async {
    final api = AlmetroApi();
    final data = await api.downloadSubwayData();
    api.getSubwayFromResponse(data);
  });
}
