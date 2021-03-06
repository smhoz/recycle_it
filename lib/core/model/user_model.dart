import 'dart:convert';

class User {
  String? uid;
  String? name;
  String? surname;
  String? mail;
  String? balance;

  String? phoneNumber;

  User({
    this.uid,
    this.name,
    this.surname,
    this.mail,
    this.phoneNumber,
    this.balance,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'surname': surname,
      'mail': mail,
      'phone_number': phoneNumber,
      'balance': balance,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'].toString(),
      name: map['name'],
      surname: map['surname'],
      mail: map['mail'],
      phoneNumber: map['phone_number'],
      balance: map['balance'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
