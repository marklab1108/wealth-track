import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinGeckoQuote {
  final String id;
  final String symbol;
  final String name;

  const CoinGeckoQuote({
    required this.id,
    required this.symbol,
    required this.name,
  });
}

class CoinGeckoService {
  static const _baseUrl = 'https://api.coingecko.com/api/v3';

  final http.Client _client;
  final _idCache = <String, String>{};

  CoinGeckoService({http.Client? client})
      : _client = client ?? http.Client();

  /// Searches for a coin by symbol/name. Returns best match.
  Future<CoinGeckoQuote?> searchCoin(String query) async {
    try {
      final uri = Uri.parse(
        '$_baseUrl/search?query=${Uri.encodeComponent(query)}',
      );
      final response = await _client.get(uri);
      if (response.statusCode != 200) return null;

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final coins = json['coins'] as List?;
      if (coins == null || coins.isEmpty) return null;

      final queryLower = query.toLowerCase();
      Map<String, dynamic>? best;
      for (final coin in coins) {
        if ((coin['symbol'] as String?)?.toLowerCase() == queryLower) {
          best = coin as Map<String, dynamic>;
          break;
        }
      }
      best ??= coins.first as Map<String, dynamic>;

      final id = best['id'] as String;
      final symbol = (best['symbol'] as String).toUpperCase();
      final name = best['name'] as String;

      _idCache[symbol] = id;
      return CoinGeckoQuote(id: id, symbol: symbol, name: name);
    } catch (_) {
      return null;
    }
  }

  /// Resolves a symbol (BTC) to a CoinGecko ID (bitcoin).
  Future<String?> getIdBySymbol(String symbol) async {
    final upper = symbol.toUpperCase();
    if (_idCache.containsKey(upper)) return _idCache[upper];

    final quote = await searchCoin(symbol);
    return quote?.id;
  }

  /// Fetches USD prices for a list of CoinGecko IDs.
  Future<Map<String, double>> getPrices(List<String> ids) async {
    if (ids.isEmpty) return {};

    try {
      final idsParam = ids.join(',');
      final uri = Uri.parse(
        '$_baseUrl/simple/price?ids=$idsParam&vs_currencies=usd',
      );
      final response = await _client.get(uri);
      if (response.statusCode != 200) return {};

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final results = <String, double>{};

      for (final entry in json.entries) {
        final priceData = entry.value as Map<String, dynamic>?;
        final price = priceData?['usd'];
        if (price != null) {
          results[entry.key] = (price as num).toDouble();
        }
      }
      return results;
    } catch (_) {
      return {};
    }
  }

  void dispose() => _client.close();
}
