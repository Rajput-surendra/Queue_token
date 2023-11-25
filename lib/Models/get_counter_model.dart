/// error : false
/// message : "Counters Get Successfully"
/// todays_tokens : [{"user_id":"56","compny_name":"Suru","mobile":"7855881255","role":"counter","address":"Vijay Nagar, Indore ","city":"Indore ","category":"1 ","today_tokens":[{"id":"2","user_name":"Surendra","counter_id":"56","category":"1","time_per_client":"5","from_time":"10 am","to_time":"11 am","total_token":"12","date":"2023-11-25","created_at":"2023-11-25 18:11:43","available_token":15,"current_token":10,"next_token":11}]}]
/// upcoming_tokens : [{"user_id":"56","compny_name":"Suru","mobile":"7855881255","role":"counter","address":"Vijay Nagar, Indore ","city":"Indore ","category":"1 ","next_day_tokens":[{"id":"3","user_name":"Harish","counter_id":"56","category":"1","time_per_client":"5","from_time":"10 am","to_time":"11 am","total_token":"12","date":"2023-11-26","created_at":"2023-11-25 18:11:43","available_token":15,"current_token":10,"next_token":11},{"id":"4","user_name":"Som","counter_id":"56","category":"1","time_per_client":"5","from_time":"10 am","to_time":"11 am","total_token":"12","date":"2023-11-26","created_at":"2023-11-25 18:11:43","available_token":15,"current_token":10,"next_token":11}]}]

class GetCounterModel {
  GetCounterModel({
      bool? error, 
      String? message, 
      List<TodaysTokens>? todaysTokens, 
      List<UpcomingTokens>? upcomingTokens,}){
    _error = error;
    _message = message;
    _todaysTokens = todaysTokens;
    _upcomingTokens = upcomingTokens;
}

  GetCounterModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['todays_tokens'] != null) {
      _todaysTokens = [];
      json['todays_tokens'].forEach((v) {
        _todaysTokens?.add(TodaysTokens.fromJson(v));
      });
    }
    if (json['upcoming_tokens'] != null) {
      _upcomingTokens = [];
      json['upcoming_tokens'].forEach((v) {
        _upcomingTokens?.add(UpcomingTokens.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<TodaysTokens>? _todaysTokens;
  List<UpcomingTokens>? _upcomingTokens;
GetCounterModel copyWith({  bool? error,
  String? message,
  List<TodaysTokens>? todaysTokens,
  List<UpcomingTokens>? upcomingTokens,
}) => GetCounterModel(  error: error ?? _error,
  message: message ?? _message,
  todaysTokens: todaysTokens ?? _todaysTokens,
  upcomingTokens: upcomingTokens ?? _upcomingTokens,
);
  bool? get error => _error;
  String? get message => _message;
  List<TodaysTokens>? get todaysTokens => _todaysTokens;
  List<UpcomingTokens>? get upcomingTokens => _upcomingTokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_todaysTokens != null) {
      map['todays_tokens'] = _todaysTokens?.map((v) => v.toJson()).toList();
    }
    if (_upcomingTokens != null) {
      map['upcoming_tokens'] = _upcomingTokens?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// user_id : "56"
/// compny_name : "Suru"
/// mobile : "7855881255"
/// role : "counter"
/// address : "Vijay Nagar, Indore "
/// city : "Indore "
/// category : "1 "
/// next_day_tokens : [{"id":"3","user_name":"Harish","counter_id":"56","category":"1","time_per_client":"5","from_time":"10 am","to_time":"11 am","total_token":"12","date":"2023-11-26","created_at":"2023-11-25 18:11:43","available_token":15,"current_token":10,"next_token":11},{"id":"4","user_name":"Som","counter_id":"56","category":"1","time_per_client":"5","from_time":"10 am","to_time":"11 am","total_token":"12","date":"2023-11-26","created_at":"2023-11-25 18:11:43","available_token":15,"current_token":10,"next_token":11}]

class UpcomingTokens {
  UpcomingTokens({
      String? userId, 
      String? compnyName, 
      String? mobile, 
      String? role, 
      String? address, 
      String? city, 
      String? category, 
      List<NextDayTokens>? nextDayTokens,}){
    _userId = userId;
    _compnyName = compnyName;
    _mobile = mobile;
    _role = role;
    _address = address;
    _city = city;
    _category = category;
    _nextDayTokens = nextDayTokens;
}

  UpcomingTokens.fromJson(dynamic json) {
    _userId = json['user_id'];
    _compnyName = json['compny_name'];
    _mobile = json['mobile'];
    _role = json['role'];
    _address = json['address'];
    _city = json['city'];
    _category = json['category'];
    if (json['next_day_tokens'] != null) {
      _nextDayTokens = [];
      json['next_day_tokens'].forEach((v) {
        _nextDayTokens?.add(NextDayTokens.fromJson(v));
      });
    }
  }
  String? _userId;
  String? _compnyName;
  String? _mobile;
  String? _role;
  String? _address;
  String? _city;
  String? _category;
  List<NextDayTokens>? _nextDayTokens;
UpcomingTokens copyWith({  String? userId,
  String? compnyName,
  String? mobile,
  String? role,
  String? address,
  String? city,
  String? category,
  List<NextDayTokens>? nextDayTokens,
}) => UpcomingTokens(  userId: userId ?? _userId,
  compnyName: compnyName ?? _compnyName,
  mobile: mobile ?? _mobile,
  role: role ?? _role,
  address: address ?? _address,
  city: city ?? _city,
  category: category ?? _category,
  nextDayTokens: nextDayTokens ?? _nextDayTokens,
);
  String? get userId => _userId;
  String? get compnyName => _compnyName;
  String? get mobile => _mobile;
  String? get role => _role;
  String? get address => _address;
  String? get city => _city;
  String? get category => _category;
  List<NextDayTokens>? get nextDayTokens => _nextDayTokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['compny_name'] = _compnyName;
    map['mobile'] = _mobile;
    map['role'] = _role;
    map['address'] = _address;
    map['city'] = _city;
    map['category'] = _category;
    if (_nextDayTokens != null) {
      map['next_day_tokens'] = _nextDayTokens?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "3"
/// user_name : "Harish"
/// counter_id : "56"
/// category : "1"
/// time_per_client : "5"
/// from_time : "10 am"
/// to_time : "11 am"
/// total_token : "12"
/// date : "2023-11-26"
/// created_at : "2023-11-25 18:11:43"
/// available_token : 15
/// current_token : 10
/// next_token : 11

class NextDayTokens {
  NextDayTokens({
      String? id, 
      String? userName, 
      String? counterId, 
      String? category, 
      String? timePerClient, 
      String? fromTime, 
      String? toTime, 
      String? totalToken, 
      String? date, 
      String? createdAt, 
      num? availableToken, 
      num? currentToken, 
      num? nextToken,}){
    _id = id;
    _userName = userName;
    _counterId = counterId;
    _category = category;
    _timePerClient = timePerClient;
    _fromTime = fromTime;
    _toTime = toTime;
    _totalToken = totalToken;
    _date = date;
    _createdAt = createdAt;
    _availableToken = availableToken;
    _currentToken = currentToken;
    _nextToken = nextToken;
}

  NextDayTokens.fromJson(dynamic json) {
    _id = json['id'];
    _userName = json['user_name'];
    _counterId = json['counter_id'];
    _category = json['category'];
    _timePerClient = json['time_per_client'];
    _fromTime = json['from_time'];
    _toTime = json['to_time'];
    _totalToken = json['total_token'];
    _date = json['date'];
    _createdAt = json['created_at'];
    _availableToken = json['available_token'];
    _currentToken = json['current_token'];
    _nextToken = json['next_token'];
  }
  String? _id;
  String? _userName;
  String? _counterId;
  String? _category;
  String? _timePerClient;
  String? _fromTime;
  String? _toTime;
  String? _totalToken;
  String? _date;
  String? _createdAt;
  num? _availableToken;
  num? _currentToken;
  num? _nextToken;
NextDayTokens copyWith({  String? id,
  String? userName,
  String? counterId,
  String? category,
  String? timePerClient,
  String? fromTime,
  String? toTime,
  String? totalToken,
  String? date,
  String? createdAt,
  num? availableToken,
  num? currentToken,
  num? nextToken,
}) => NextDayTokens(  id: id ?? _id,
  userName: userName ?? _userName,
  counterId: counterId ?? _counterId,
  category: category ?? _category,
  timePerClient: timePerClient ?? _timePerClient,
  fromTime: fromTime ?? _fromTime,
  toTime: toTime ?? _toTime,
  totalToken: totalToken ?? _totalToken,
  date: date ?? _date,
  createdAt: createdAt ?? _createdAt,
  availableToken: availableToken ?? _availableToken,
  currentToken: currentToken ?? _currentToken,
  nextToken: nextToken ?? _nextToken,
);
  String? get id => _id;
  String? get userName => _userName;
  String? get counterId => _counterId;
  String? get category => _category;
  String? get timePerClient => _timePerClient;
  String? get fromTime => _fromTime;
  String? get toTime => _toTime;
  String? get totalToken => _totalToken;
  String? get date => _date;
  String? get createdAt => _createdAt;
  num? get availableToken => _availableToken;
  num? get currentToken => _currentToken;
  num? get nextToken => _nextToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_name'] = _userName;
    map['counter_id'] = _counterId;
    map['category'] = _category;
    map['time_per_client'] = _timePerClient;
    map['from_time'] = _fromTime;
    map['to_time'] = _toTime;
    map['total_token'] = _totalToken;
    map['date'] = _date;
    map['created_at'] = _createdAt;
    map['available_token'] = _availableToken;
    map['current_token'] = _currentToken;
    map['next_token'] = _nextToken;
    return map;
  }

}

/// user_id : "56"
/// compny_name : "Suru"
/// mobile : "7855881255"
/// role : "counter"
/// address : "Vijay Nagar, Indore "
/// city : "Indore "
/// category : "1 "
/// today_tokens : [{"id":"2","user_name":"Surendra","counter_id":"56","category":"1","time_per_client":"5","from_time":"10 am","to_time":"11 am","total_token":"12","date":"2023-11-25","created_at":"2023-11-25 18:11:43","available_token":15,"current_token":10,"next_token":11}]

class TodaysTokens {
  TodaysTokens({
      String? userId, 
      String? compnyName, 
      String? mobile, 
      String? role, 
      String? address, 
      String? city, 
      String? category, 
      List<TodayTokens>? todayTokens,}){
    _userId = userId;
    _compnyName = compnyName;
    _mobile = mobile;
    _role = role;
    _address = address;
    _city = city;
    _category = category;
    _todayTokens = todayTokens;
}

  TodaysTokens.fromJson(dynamic json) {
    _userId = json['user_id'];
    _compnyName = json['compny_name'];
    _mobile = json['mobile'];
    _role = json['role'];
    _address = json['address'];
    _city = json['city'];
    _category = json['category'];
    if (json['today_tokens'] != null) {
      _todayTokens = [];
      json['today_tokens'].forEach((v) {
        _todayTokens?.add(TodayTokens.fromJson(v));
      });
    }
  }
  String? _userId;
  String? _compnyName;
  String? _mobile;
  String? _role;
  String? _address;
  String? _city;
  String? _category;
  List<TodayTokens>? _todayTokens;
TodaysTokens copyWith({  String? userId,
  String? compnyName,
  String? mobile,
  String? role,
  String? address,
  String? city,
  String? category,
  List<TodayTokens>? todayTokens,
}) => TodaysTokens(  userId: userId ?? _userId,
  compnyName: compnyName ?? _compnyName,
  mobile: mobile ?? _mobile,
  role: role ?? _role,
  address: address ?? _address,
  city: city ?? _city,
  category: category ?? _category,
  todayTokens: todayTokens ?? _todayTokens,
);
  String? get userId => _userId;
  String? get compnyName => _compnyName;
  String? get mobile => _mobile;
  String? get role => _role;
  String? get address => _address;
  String? get city => _city;
  String? get category => _category;
  List<TodayTokens>? get todayTokens => _todayTokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['compny_name'] = _compnyName;
    map['mobile'] = _mobile;
    map['role'] = _role;
    map['address'] = _address;
    map['city'] = _city;
    map['category'] = _category;
    if (_todayTokens != null) {
      map['today_tokens'] = _todayTokens?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "2"
/// user_name : "Surendra"
/// counter_id : "56"
/// category : "1"
/// time_per_client : "5"
/// from_time : "10 am"
/// to_time : "11 am"
/// total_token : "12"
/// date : "2023-11-25"
/// created_at : "2023-11-25 18:11:43"
/// available_token : 15
/// current_token : 10
/// next_token : 11

class TodayTokens {
  TodayTokens({
      String? id, 
      String? userName, 
      String? counterId, 
      String? category, 
      String? timePerClient, 
      String? fromTime, 
      String? toTime, 
      String? totalToken, 
      String? date, 
      String? createdAt, 
      num? availableToken, 
      num? currentToken, 
      num? nextToken,}){
    _id = id;
    _userName = userName;
    _counterId = counterId;
    _category = category;
    _timePerClient = timePerClient;
    _fromTime = fromTime;
    _toTime = toTime;
    _totalToken = totalToken;
    _date = date;
    _createdAt = createdAt;
    _availableToken = availableToken;
    _currentToken = currentToken;
    _nextToken = nextToken;
}

  TodayTokens.fromJson(dynamic json) {
    _id = json['id'];
    _userName = json['user_name'];
    _counterId = json['counter_id'];
    _category = json['category'];
    _timePerClient = json['time_per_client'];
    _fromTime = json['from_time'];
    _toTime = json['to_time'];
    _totalToken = json['total_token'];
    _date = json['date'];
    _createdAt = json['created_at'];
    _availableToken = json['available_token'];
    _currentToken = json['current_token'];
    _nextToken = json['next_token'];
  }
  String? _id;
  String? _userName;
  String? _counterId;
  String? _category;
  String? _timePerClient;
  String? _fromTime;
  String? _toTime;
  String? _totalToken;
  String? _date;
  String? _createdAt;
  num? _availableToken;
  num? _currentToken;
  num? _nextToken;
TodayTokens copyWith({  String? id,
  String? userName,
  String? counterId,
  String? category,
  String? timePerClient,
  String? fromTime,
  String? toTime,
  String? totalToken,
  String? date,
  String? createdAt,
  num? availableToken,
  num? currentToken,
  num? nextToken,
}) => TodayTokens(  id: id ?? _id,
  userName: userName ?? _userName,
  counterId: counterId ?? _counterId,
  category: category ?? _category,
  timePerClient: timePerClient ?? _timePerClient,
  fromTime: fromTime ?? _fromTime,
  toTime: toTime ?? _toTime,
  totalToken: totalToken ?? _totalToken,
  date: date ?? _date,
  createdAt: createdAt ?? _createdAt,
  availableToken: availableToken ?? _availableToken,
  currentToken: currentToken ?? _currentToken,
  nextToken: nextToken ?? _nextToken,
);
  String? get id => _id;
  String? get userName => _userName;
  String? get counterId => _counterId;
  String? get category => _category;
  String? get timePerClient => _timePerClient;
  String? get fromTime => _fromTime;
  String? get toTime => _toTime;
  String? get totalToken => _totalToken;
  String? get date => _date;
  String? get createdAt => _createdAt;
  num? get availableToken => _availableToken;
  num? get currentToken => _currentToken;
  num? get nextToken => _nextToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_name'] = _userName;
    map['counter_id'] = _counterId;
    map['category'] = _category;
    map['time_per_client'] = _timePerClient;
    map['from_time'] = _fromTime;
    map['to_time'] = _toTime;
    map['total_token'] = _totalToken;
    map['date'] = _date;
    map['created_at'] = _createdAt;
    map['available_token'] = _availableToken;
    map['current_token'] = _currentToken;
    map['next_token'] = _nextToken;
    return map;
  }

}