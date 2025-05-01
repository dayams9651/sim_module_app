class LoginResponse {
  Data? data;
  String? message;
  String? status;
  bool? success;
  int? code;

  LoginResponse(
      {this.data, this.message, this.status, this.success, this.code});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
    success = json['success'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    data['success'] = this.success;
    data['code'] = this.code;
    return data;
  }
}

class Data {
  String? token;
  String? department;
  String? crnMobile;
  String? crnEmail;
  String? crnId;
  String? companyId;
  String? username;
  String? crnType;
  int? validity;
  String? roleName;
  String? maintenance;
  Other? other;

  Data(
      {this.token,
        this.department,
        this.crnMobile,
        this.crnEmail,
        this.crnId,
        this.companyId,
        this.username,
        this.crnType,
        this.validity,
        this.roleName,
        this.maintenance,
        this.other});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    department = json['department'];
    crnMobile = json['crn_mobile'];
    crnEmail = json['crn_email'];
    crnId = json['crn_id'];
    companyId = json['company_id'];
    username = json['username'];
    crnType = json['crn_type'];
    validity = json['validity'];
    roleName = json['roleName'];
    maintenance = json['maintenance'];
    other = json['other'] != null ? new Other.fromJson(json['other']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['department'] = this.department;
    data['crn_mobile'] = this.crnMobile;
    data['crn_email'] = this.crnEmail;
    data['crn_id'] = this.crnId;
    data['company_id'] = this.companyId;
    data['username'] = this.username;
    data['crn_type'] = this.crnType;
    data['validity'] = this.validity;
    data['roleName'] = this.roleName;
    data['maintenance'] = this.maintenance;
    if (this.other != null) {
      data['other'] = this.other!.toJson();
    }
    return data;
  }
}

class Other {
  bool? mV;
  bool? eV;
  bool? cP;

  Other({this.mV, this.eV, this.cP});

  Other.fromJson(Map<String, dynamic> json) {
    mV = json['m_v'];
    eV = json['e_v'];
    cP = json['c_p'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['m_v'] = this.mV;
    data['e_v'] = this.eV;
    data['c_p'] = this.cP;
    return data;
  }
}
