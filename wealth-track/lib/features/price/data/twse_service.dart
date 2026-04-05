import 'dart:convert';
import 'package:http/http.dart' as http;

class TwseService {
  static const _stockListUrl =
      'https://openapi.twse.com.tw/v1/opendata/t187ap03_L';

  final http.Client _client;
  Map<String, String>? _cache;
  DateTime? _cacheTime;

  TwseService({http.Client? client}) : _client = client ?? http.Client();

  /// Fetches Chinese short name for a TW stock code (e.g. "2330" → "台積電").
  Future<String?> getChineseName(String stockCode) async {
    await _ensureCache();
    return _cache?[stockCode];
  }

  Future<void> _ensureCache() async {
    if (_cache != null && _cacheTime != null) {
      final age = DateTime.now().difference(_cacheTime!);
      if (age.inHours < 24) return;
    }

    try {
      final response = await _client.get(Uri.parse(_stockListUrl));
      if (response.statusCode != 200) return;

      final list = jsonDecode(response.body) as List;
      final map = <String, String>{};
      for (final item in list) {
        final code = item['公司代號']?.toString().trim();
        final name = item['公司簡稱']?.toString().trim();
        if (code != null && code.isNotEmpty && name != null && name.isNotEmpty) {
          map[code] = name;
        }
      }

      _cache = map;
      _cacheTime = DateTime.now();
    } catch (_) {
      // Keep existing cache on failure
    }
  }

  void dispose() => _client.close();
}
