/// error : false
/// message : "Counters Get Successfully"
/// todays_tokens : [{"id":"39","user_name":"Deva ","counter_id":"114","category":"1","time_per_client":"3","from_time":"12:49","to_time":"08:49","total_token":"80","date":"2023-11-29","created_at":"2023-11-28 23:49:49","available_token":"80","current_token":"10","next_token":"11","company_name":"Alphawizz "},{"id":"26","user_name":"Ravi","counter_id":"56","category":"1","time_per_client":"10","from_time":"10 am","to_time":"01 pm","total_token":"18","date":"2023-11-29","created_at":"2023-11-28 16:14:16","available_token":"18","current_token":"10","next_token":"11","company_name":"Suru"},{"id":"27","user_name":"Sr.Vishal","counter_id":"102","category":"1","time_per_client":"10","from_time":"5:00 pm","to_time":"7:30 pm","total_token":"15","date":"2023-11-29","created_at":"2023-11-28 16:14:16","available_token":"13","current_token":"10","next_token":"11","company_name":"gggggg"},{"id":"37","user_name":"Raja ","counter_id":"102","category":"1","time_per_client":"6","from_time":"8:05 PM","to_time":"10:05 PM","total_token":"20","date":"2023-11-29","created_at":"2023-11-28 18:59:25","available_token":"19","current_token":"10","next_token":"11","company_name":"gggggg"},{"id":"40","user_name":"dr.abhishek","counter_id":"115","category":"1","time_per_client":"10","from_time":"12:00 PM","to_time":"2:00 PM","total_token":"12","date":"2023-11-29","created_at":"2023-11-29 11:05:27","available_token":"12","current_token":"10","next_token":"11","company_name":"dr.abhinav"}]
/// upcoming_tokens : [{"id":"41","user_name":"dr.abhishek","counter_id":"115","category":"0","time_per_client":"15","from_time":"12:00 PM","to_time":"2:00 PM","total_token":"8","date":"2023-11-30","created_at":"2023-11-29 11:06:00","available_token":"15","current_token":"10","next_token":"11","company_name":"dr.abhinav"}]

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

/// id : "41"
/// user_name : "dr.abhishek"
/// counter_id : "115"
/// category : "0"
/// time_per_client : "15"
/// from_time : "12:00 PM"
/// to_time : "2:00 PM"
/// total_token : "8"
/// date : "2023-11-30"
/// created_at : "2023-11-29 11:06:00"
/// available_token : "15"
/// current_token : "10"
/// next_token : "11"
/// company_name : "dr.abhinav"

class UpcomingTokens {
  UpcomingTokens({
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
      String? availableToken, 
      String? currentToken, 
      String? nextToken, 
      String? companyName,}){
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
    _companyName = companyName;
}

  UpcomingTokens.fromJson(dynamic json) {
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
    _companyName = json['company_name'];
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
  String? _availableToken;
  String? _currentToken;
  String? _nextToken;
  String? _companyName;
UpcomingTokens copyWith({  String? id,
  String? userName,
  String? counterId,
  String? category,
  String? timePerClient,
  String? fromTime,
  String? toTime,
  String? totalToken,
  String? date,
  String? createdAt,
  String? availableToken,
  String? currentToken,
  String? nextToken,
  String? companyName,
}) => UpcomingTokens(  id: id ?? _id,
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
  companyName: companyName ?? _companyName,
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
  String? get availableToken => _availableToken;
  String? get currentToken => _currentToken;
  String? get nextToken => _nextToken;
  String? get companyName => _companyName;

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
    map['company_name'] = _companyName;
    return map;
  }

}

/// id : "39"
/// user_name : "Deva "
/// counter_id : "114"
/// category : "1"
/// time_per_client : "3"
/// from_time : "12:49"
/// to_time : "08:49"
/// total_token : "80"
/// date : "2023-11-29"
/// created_at : "2023-11-28 23:49:49"
/// available_token : "80"
/// current_token : "10"
/// next_token : "11"
/// company_name : "Alphawizz "

class TodaysTokens {
  TodaysTokens({
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
      String? availableToken, 
      String? currentToken, 
      String? nextToken, 
      String? companyName,}){
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
    _companyName = companyName;
}

  TodaysTokens.fromJson(dynamic json) {
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
    _companyName = json['company_name'];
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
  String? _availableToken;
  String? _currentToken;
  String? _nextToken;
  String? _companyName;
TodaysTokens copyWith({  String? id,
  String? userName,
  String? counterId,
  String? category,
  String? timePerClient,
  String? fromTime,
  String? toTime,
  String? totalToken,
  String? date,
  String? createdAt,
  String? availableToken,
  String? currentToken,
  String? nextToken,
  String? companyName,
}) => TodaysTokens(  id: id ?? _id,
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
  companyName: companyName ?? _companyName,
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
  String? get availableToken => _availableToken;
  String? get currentToken => _currentToken;
  String? get nextToken => _nextToken;
  String? get companyName => _companyName;

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
    map['company_name'] = _companyName;
    return map;
  }

}