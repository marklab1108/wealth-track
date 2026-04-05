import 'package:http/http.dart' as http;

class FundQuote {
  final String code;
  final String name;
  final double nav;
  final String currency;
  final String date;

  const FundQuote({
    required this.code,
    required this.name,
    required this.nav,
    required this.currency,
    required this.date,
  });
}

class YahooFundService {
  static const _baseUrl = 'https://tw.stock.yahoo.com/fund';

  final http.Client _client;

  /// Regex for the server-side injected meta JSON inside root.App.main.
  static final _metaPattern = RegExp(
    r'"meta":\{"name":"([^"]+)","price":"([0-9.]+)","currencyCode":"([^"]+)",'
    r'"priceChange":"[^"]*","priceChangePercent":"[^"]*",'
    r'"latestPriceDate":"([^"]+)"',
  );

  YahooFundService({http.Client? client})
      : _client = client ?? http.Client();

  /// Fetches fund info (name + NAV) from Yahoo TW fund page.
  /// [code] is the Yahoo/Morningstar fund ID, e.g. "F000014SAX:FO".
  Future<FundQuote?> getQuote(String code) async {
    try {
      final uri = Uri.parse('$_baseUrl/$code/summary');
      final response = await _client.get(uri, headers: {
        'User-Agent': 'Mozilla/5.0',
      });

      if (response.statusCode != 200) return null;

      final match = _metaPattern.firstMatch(response.body);
      if (match == null) return null;

      final nav = double.tryParse(match.group(2)!);
      if (nav == null) return null;

      return FundQuote(
        code: code,
        name: match.group(1)!,
        nav: nav,
        currency: match.group(3)!,
        date: match.group(4)!,
      );
    } catch (_) {
      return null;
    }
  }

  /// Fetches NAVs for multiple fund codes in parallel.
  Future<Map<String, FundQuote>> getQuotes(List<String> codes) async {
    if (codes.isEmpty) return {};

    final results = <String, FundQuote>{};
    final futures = codes.map((code) async {
      final quote = await getQuote(code);
      if (quote != null) results[code] = quote;
    });
    await Future.wait(futures);
    return results;
  }

  void dispose() => _client.close();
}
