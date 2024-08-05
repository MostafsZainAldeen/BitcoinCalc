import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '40277C49-67AD-42DF-9D2A-C472489ABC3C';

class CoinData {
  Future<Map<String, String>> getCoinData(String selectedCurrency) async { //جلب اسعار العملات
    Map<String, String> cryptoPrices = {};  // تخزين
    for (String crypto in cryptoList) {
      String requestURL =       // بناء رابط الطلب باستخدام العملة الرقمية والعملة التقليدية المختارة
      '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(requestURL));

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(2);
        // رقمين بعد الفاصلة
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
