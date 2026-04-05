import 'dart:convert';
import 'package:http/http.dart' as http;

class StockQuote {
  final String symbol;
  final String? shortName;
  final double? price;

  const StockQuote({
    required this.symbol,
    this.shortName,
    this.price,
  });
}

class YahooFinanceService {
  static const _baseUrl = 'https://query1.finance.yahoo.com/v8/finance/chart';

  final http.Client _client;

  YahooFinanceService({http.Client? client})
      : _client = client ?? http.Client();

  /// Fetches quote info (name + price) for a symbol.
  Future<StockQuote?> getQuote(String symbol) async {
    try {
      final uri = Uri.parse('$_baseUrl/$symbol?interval=1d&range=1d');
      final response = await _client.get(uri, headers: {
        'User-Agent': 'Mozilla/5.0',
      });

      if (response.statusCode != 200) return null;

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final result = json['chart']?['result'] as List?;
      if (result == null || result.isEmpty) return null;

      final meta = result[0]['meta'] as Map<String, dynamic>?;
      if (meta == null) return null;

      final price = meta['regularMarketPrice'];
      final shortName = meta['shortName'] as String?;
      final longName = meta['longName'] as String?;

      return StockQuote(
        symbol: symbol,
        shortName: shortName ?? longName,
        price: price != null ? (price as num).toDouble() : null,
      );
    } catch (_) {
      return null;
    }
  }

  /// Fetches current price for a single symbol.
  Future<double?> getPrice(String symbol) async {
    final quote = await getQuote(symbol);
    return quote?.price;
  }

  /// Fetches prices for multiple symbols in parallel.
  Future<Map<String, double>> getPrices(List<String> symbols) async {
    final results = <String, double>{};
    final futures = symbols.map((s) async {
      final price = await getPrice(s);
      if (price != null) results[s] = price;
    });
    await Future.wait(futures);
    return results;
  }

  /// Scrapes Chinese stock name from Yahoo Taiwan for TW/TWO symbols.
  /// Title format: "路易莎咖啡(2758.TWO) 走勢圖 - Yahoo股市"
  Future<String?> getChineseNameFromYahooTw(String code) async {
    for (final suffix in ['TWO', 'TW']) {
      try {
        final uri =
            Uri.parse('https://tw.stock.yahoo.com/quote/$code.$suffix');
        final response = await _client.get(uri, headers: {
          'User-Agent': 'Mozilla/5.0',
        });
        if (response.statusCode != 200) continue;

        final match = RegExp(r'<title>(.+?)\(' + RegExp.escape(code) + r'\.')
            .firstMatch(response.body);
        if (match != null) {
          final name = match.group(1)?.trim();
          if (name != null && name.isNotEmpty) return name;
        }
      } catch (_) {
        continue;
      }
    }
    return null;
  }

  void dispose() => _client.close();
}
