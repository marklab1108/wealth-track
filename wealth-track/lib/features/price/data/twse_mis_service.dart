import 'dart:convert';
import 'package:http/http.dart' as http;

class TwStockQuote {
  final String code;
  final String name;
  final double? price;
  final String exchange; // "tse" or "otc"

  const TwStockQuote({
    required this.code,
    required this.name,
    this.price,
    required this.exchange,
  });
}

/// TWSE Market Information System (MIS) API.
/// Provides near real-time quotes (~5s delay) for 上市 (tse), 上櫃 (otc), and ETFs.
class TwseMisService {
  static const _baseUrl =
      'https://mis.twse.com.tw/stock/api/getStockInfo.jsp';

  final http.Client _client;

  TwseMisService({http.Client? client}) : _client = client ?? http.Client();

  /// Fetches quote for a single TW stock code.
  /// Tries tse_ first, then otc_ if not found.
  Future<TwStockQuote?> getQuote(String code) async {
    var result = await _fetchQuotes(['tse_$code.tw']);
    if (result.isNotEmpty) return result.values.first;

    result = await _fetchQuotes(['otc_$code.tw']);
    if (result.isNotEmpty) return result.values.first;

    return null;
  }

  /// Batch fetch quotes for multiple TW stock codes.
  /// Automatically tries tse_ first for all, then otc_ for any that weren't found.
  Future<Map<String, TwStockQuote>> getQuotes(List<String> codes) async {
    if (codes.isEmpty) return {};

    final results = <String, TwStockQuote>{};

    final tseSymbols = codes.map((c) => 'tse_$c.tw').toList();
    final tseResults = await _fetchQuotes(tseSymbols);
    results.addAll(tseResults);

    final missing = codes.where((c) => !results.containsKey(c)).toList();
    if (missing.isNotEmpty) {
      final otcSymbols = missing.map((c) => 'otc_$c.tw').toList();
      final otcResults = await _fetchQuotes(otcSymbols);
      results.addAll(otcResults);
    }

    return results;
  }

  Future<Map<String, TwStockQuote>> _fetchQuotes(
      List<String> exChList) async {
    try {
      final param = exChList.join('|');
      final uri = Uri.parse('$_baseUrl?ex_ch=$param&json=1&delay=0');
      final response = await _client.get(uri, headers: {
        'User-Agent': 'Mozilla/5.0',
      });

      if (response.statusCode != 200) return {};

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (json['rtcode'] != '0000') return {};

      final msgArray = json['msgArray'] as List?;
      if (msgArray == null || msgArray.isEmpty) return {};

      final results = <String, TwStockQuote>{};
      for (final item in msgArray) {
        final code = item['c']?.toString();
        final name = item['n']?.toString();
        final ex = item['ex']?.toString() ?? 'tse';

        if (code == null || name == null) continue;

        // 'z' = last trade price; '-' means no trade today, use 'y' (yesterday close)
        final zStr = item['z']?.toString();
        final yStr = item['y']?.toString();
        double? price;
        if (zStr != null && zStr != '-') {
          price = double.tryParse(zStr.replaceAll(',', ''));
        }
        price ??= yStr != null
            ? double.tryParse(yStr.replaceAll(',', ''))
            : null;

        results[code] = TwStockQuote(
          code: code,
          name: name,
          price: price,
          exchange: ex,
        );
      }

      return results;
    } catch (_) {
      return {};
    }
  }

  void dispose() => _client.close();
}
