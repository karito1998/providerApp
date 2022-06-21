import 'package:handyman_provider_flutter/models/booking_detail_response.dart';
import 'package:handyman_provider_flutter/models/pagination_model.dart';
import 'package:handyman_provider_flutter/models/service_detail_response.dart';
import 'package:handyman_provider_flutter/models/user_data.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingListResponse {
  List<BookingData>? data;
  Pagination? pagination;

  BookingListResponse({required this.data, required this.pagination});

  factory BookingListResponse.fromJson(Map<String, dynamic> json) {
    return BookingListResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => BookingData.fromJson(i)).toList() : null,
      pagination: json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class BookingData {
  String? address;
  int? customer_id;
  String? customer_name;
  String? date;
  String? description;
  num? discount;
  String? duration_diff;
  String? duration_diff_hour;
  List<Handyman>? handyman;
  int? id;
  int? payment_id;
  String? payment_method;
  String? payment_status;
  num? price;
  int? provider_id;
  String? provider_name;
  List<String>? image_attchments;
  List<Attachments>? service_attchments;
  List<Taxes>? taxes;
  CouponData? couponData;
  int? service_id;
  String? service_name;
  String? status;
  String? status_label;
  String? type;
  int? booking_address_id;
  int? quantity;
  num? total_calculated_price;
  num? totalAmount;

  //Local
  bool get isHourlyService => type.validate() == ServiceTypeHourly;

  BookingData({
    this.address,
    this.image_attchments,
    this.customer_id,
    this.customer_name,
    this.date,
    this.description,
    this.discount,
    this.duration_diff,
    this.duration_diff_hour,
    this.handyman,
    this.couponData,
    this.id,
    this.payment_id,
    this.payment_method,
    this.payment_status,
    this.price,
    this.provider_id,
    this.provider_name,
    //this.service_attchments,
    this.taxes,
    this.service_id,
    this.service_name,
    this.status,
    this.status_label,
    this.type,
    this.quantity,
    this.total_calculated_price,
    this.booking_address_id,
    this.totalAmount,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      address: json['address'],
      customer_id: json['customer_id'],
      customer_name: json['customer_name'],
      date: json['date'],
      description: json['description'],
      discount: json['discount'],
      duration_diff: json['duration_diff'],
      duration_diff_hour: json['duration_diff_hour'],
      handyman: json['handyman'] != null ? (json['handyman'] as List).map((i) => Handyman.fromJson(i)).toList() : [],
      id: json['id'],
      payment_id: json['payment_id'],
      payment_method: json['payment_method'],
      payment_status: json['payment_status'],
      price: json['price'],
      provider_id: json['provider_id'],
      provider_name: json['provider_name'],
      // service_attchments: json['service_attchments'] != null ? (json['service_attchments'] as List).map((i) => Attachments.fromJson(i)).toList() : null,
      //  image_attchments :json['attchments'],
      image_attchments: json['service_attchments'] != null ? List<String>.from(json['service_attchments']) : null,
      //service_attchments: json['service_attchments'] != null ? new List<String>.from(json['service_attchments']) : null,
      taxes: json['taxes'] != null ? (json['taxes'] as List).map((i) => Taxes.fromJson(i)).toList() : null,
      couponData: json['coupon_data'] != null ? CouponData.fromJson(json['coupon_data']) : null,
      service_id: json['service_id'],
      service_name: json['service_name'],
      status: json['status'],
      status_label: json['status_label'],
      quantity: json['quantity'],
      type: json['type'],
      booking_address_id: json['booking_address_id'],
      totalAmount: json['total_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customer_id;
    data['customer_name'] = this.customer_name;
    data['date'] = this.date;
    data['discount'] = this.discount;
    data['duration_diff'] = this.duration_diff;
    data['id'] = this.id;
    data['price'] = this.price;
    data['provider_id'] = this.provider_id;
    data['provider_name'] = this.provider_name;
    data['service_id'] = this.service_id;
    data['service_name'] = this.service_name;
    data['status'] = this.status;
    data['status_label'] = this.status_label;
    data['type'] = this.type;
    data['address'] = this.address;
    data['description'] = this.description;
    data['duration_diff_hour'] = this.duration_diff_hour;
    data['handyman'] = this.handyman;
    data['payment_id'] = this.payment_id;
    data['payment_method'] = this.payment_method;
    data['payment_status'] = this.payment_status;
    // data['service_attchments'] = this.service_attchments;
    //  data['attchments'] = this.image_attchments;
    if (this.image_attchments != null) {
      data['service_attchments'] = this.image_attchments;
    }
    /* if (this.service_attchments != null) {
      data['service_attchments'] = this.service_attchments!.map((v) => v.toJson()).toList();
    }*/
    data['booking_address_id'] = this.booking_address_id;
    data['quantity'] = this.quantity;
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    }
    if (this.couponData != null) {
      data['coupon_data'] = this.couponData!.toJson();
    }
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class Taxes {
  int? id;
  int? provider_id;
  String? title;
  String? type;
  int? value;
  num? totalCalculatedValue;

  Taxes({this.id, this.provider_id, this.title, this.type, this.value, this.totalCalculatedValue});

  factory Taxes.fromJson(Map<String, dynamic> json) {
    return Taxes(
      id: json['id'],
      provider_id: json['provider_id'],
      title: json['title'],
      type: json['type'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.provider_id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

class Handyman {
  int? id;
  int? bookingId;
  int? handymanId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  UserData? handyman;

  Handyman({this.id, this.bookingId, this.handymanId, this.createdAt, this.updatedAt, this.deletedAt, this.handyman});

  Handyman.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    handymanId = json['handyman_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    handyman = json['handyman'] != null ? new UserData.fromJson(json['handyman']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['handyman_id'] = this.handymanId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.handyman != null) {
      data['handyman'] = this.handyman!.toJson();
    }
    return data;
  }
}