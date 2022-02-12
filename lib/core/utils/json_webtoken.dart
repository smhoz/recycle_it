import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class JwtManager {
  final String _secretKey = dotenv.env['JWT_SECRET_KEY'] as String;
  String signJwt(dynamic _data) {
    JWT _jwt = JWT(_data);
    int _expiredTime = 1000;

    String token = _jwt.sign(SecretKey(_secretKey),
        expiresIn: Duration(seconds: _expiredTime));

    return token;
  }

  dynamic verifyJwt(String token) {
    try {
      // Verify a token
      final _result = JWT.verify(token, SecretKey(_secretKey));

      return _result.payload;
    } on JWTExpiredError {
      print('jwt expired');
      return null;
    } on JWTError catch (ex) {
      print(ex.message); // ex: invalid signature
      return null;
    }
  }
}
