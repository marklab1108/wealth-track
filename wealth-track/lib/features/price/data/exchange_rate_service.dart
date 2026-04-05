import 'dart:convert';
import 'package:http/http.dart' as http;

class ExchangeRateService {
  static const _baseUrl = 'https://open.er-api.com/v6/latest';

  final http.Client _client;

  ExchangeRateService({http.Client? client})
      : _client = client ?? http.Client();

  /// Fetches exchange rate from [base] to [target].
  /// Returns null on failure.
  Future<double?> getRate(String base, String target) async {
    try {
      final uri = Uri.parse('$_baseUrl/$base');
      final response = await _client.get(uri);
      if (response.statusCode != 200) return null;

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (json['result'] != 'success') return null;

      final rates = json['rates'] as Map<String, dynamic>?;
      if (rates == null) return null;

      final rate = rates[target];
      if (rate == null) return null;
      return (rate as num).toDouble();
    } catch (_) {
      return null;
    }
  }

  void dispose() => _client.close();
}
