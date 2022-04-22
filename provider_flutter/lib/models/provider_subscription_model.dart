class ProviderSubscriptionModel {
  int? id;
  String? title;
  String? identifier;
  int? amount;
  String? type;
  String? endAt;
  int? planId;
  String? startAt;
  String? status;
  int? trialPeriod;

  ProviderSubscriptionModel({this.amount, this.endAt, this.id, this.identifier, this.planId, this.startAt, this.status, this.type, this.title, this.trialPeriod});

  factory ProviderSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return ProviderSubscriptionModel(
      amount: json['amount'],
      endAt: json['end_at'],
      id: json['id'],
      identifier: json['identifier'],
      planId: json['plan_id'],
      startAt: json['start_at'],
      status: json['status'],
      type: json['type'],
      title: json['title'],
      trialPeriod: json['trial_period'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['end_at'] = this.endAt;
    data['id'] = this.id;
    data['identifier'] = this.identifier;
    data['plan_id'] = this.planId;
    data['start_at'] = this.startAt;
    data['status'] = this.status;
    data['type'] = this.type;
    data['title'] = this.title;
    data['trial_period'] = this.trialPeriod;
    return data;
  }
}
