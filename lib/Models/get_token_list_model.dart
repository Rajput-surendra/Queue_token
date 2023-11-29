/// error : false
/// message : "Data Get Sucessfully !"
/// data : [{"id":"20","user_id":"127","token_id":"51","counter_id":"126","name":"Hari ","mobile":"8787878787","token_number":"1","time":"04:00 PM","status":"0","date":"2023-11-29","created_at":"2023-11-29 16:05:33","current_token":2}]

class GetTokenListModel {
  GetTokenListModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetTokenListModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
GetTokenListModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetTokenListModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "20"
/// user_id : "127"
/// token_id : "51"
/// counter_id : "126"
/// name : "Hari "
/// mobile : "8787878787"
/// token_number : "1"
/// time : "04:00 PM"
/// status : "0"
/// date : "2023-11-29"
/// created_at : "2023-11-29 16:05:33"
/// current_token : 2

class Data {
  Data({
      String? id, 
      String? userId, 
      String? tokenId, 
      String? counterId, 
      String? name, 
      String? mobile, 
      String? tokenNumber, 
      String? time, 
      String? status, 
      String? date, 
      String? createdAt, 
      num? currentToken,}){
    _id = id;
    _userId = userId;
    _tokenId = tokenId;
    _counterId = counterId;
    _name = name;
    _mobile = mobile;
    _tokenNumber = tokenNumber;
    _time = time;
    _status = status;
    _date = date;
    _createdAt = createdAt;
    _currentToken = currentToken;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _tokenId = json['token_id'];
    _counterId = json['counter_id'];
    _name = json['name'];
    _mobile = json['mobile'];
    _tokenNumber = json['token_number'];
    _time = json['time'];
    _status = json['status'];
    _date = json['date'];
    _createdAt = json['created_at'];
    _currentToken = json['current_token'];
  }
  String? _id;
  String? _userId;
  String? _tokenId;
  String? _counterId;
  String? _name;
  String? _mobile;
  String? _tokenNumber;
  String? _time;
  String? _status;
  String? _date;
  String? _createdAt;
  num? _currentToken;
Data copyWith({  String? id,
  String? userId,
  String? tokenId,
  String? counterId,
  String? name,
  String? mobile,
  String? tokenNumber,
  String? time,
  String? status,
  String? date,
  String? createdAt,
  num? currentToken,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  tokenId: tokenId ?? _tokenId,
  counterId: counterId ?? _counterId,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  tokenNumber: tokenNumber ?? _tokenNumber,
  time: time ?? _time,
  status: status ?? _status,
  date: date ?? _date,
  createdAt: createdAt ?? _createdAt,
  currentToken: currentToken ?? _currentToken,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get tokenId => _tokenId;
  String? get counterId => _counterId;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get tokenNumber => _tokenNumber;
  String? get time => _time;
  String? get status => _status;
  String? get date => _date;
  String? get createdAt => _createdAt;
  num? get currentToken => _currentToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['token_id'] = _tokenId;
    map['counter_id'] = _counterId;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['token_number'] = _tokenNumber;
    map['time'] = _time;
    map['status'] = _status;
    map['date'] = _date;
    map['created_at'] = _createdAt;
    map['current_token'] = _currentToken;
    return map;
  }

}