import 'package:http/http.dart' as http;

const cxHead = 'cx-staging.herokuapp.com';
final client = http.Client();

const header = {
  'Content-Type': 'application/json',
  'Accept': 'application/json'
};

var authorizationHeader = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'APIKey': 'Pra8CPHHySKFEBYvgHRan1wP7LOnaoYkgT7J1dNw1AR6xlNt8u9c6'
};
