class AllOfflineUpcomingProgress {
  List<UpcomingProgress>? upcomingProgress;

  AllOfflineUpcomingProgress({this.upcomingProgress});

  AllOfflineUpcomingProgress.fromJson(Map<String, dynamic> json) {
    if (json['upcomingProgress'] != null) {
      upcomingProgress = <UpcomingProgress>[];
      json['upcomingProgress'].forEach((v) {
        upcomingProgress!.add(UpcomingProgress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (upcomingProgress != null) {
      data['upcomingProgress'] =
          upcomingProgress!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpcomingProgress {
  int? progressId;
  String? uomName;
  int? quantity;
  int? quantityId;
  String? locationName;
  String? subLocationName;
  String? subSubLocationName;
  String? activityHead;
  int? startTrigger;
  int? linkingActivityId;
  int? activityId;
  int? budgetId;
  String? activity;
  int? activityOrder;
  int? uomId;
  String? description;
  String? corel;
  int? locationId;
  int? subLocId;
  int? subSubLocId;
  int? status;
  // ignore: prefer_typing_uninitialized_variables
  var import;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  UpcomingProgress(
      {this.progressId,
      this.uomName,
      this.quantity,
      this.quantityId,
      this.locationName,
      this.subLocationName,
      this.subSubLocationName,
      this.activityHead,
      this.startTrigger,
      this.linkingActivityId,
      this.activityId,
      this.budgetId,
      this.activity,
      this.activityOrder,
      this.uomId,
      this.description,
      this.corel,
      this.locationId,
      this.subLocId,
      this.subSubLocId,
      this.status,
      this.import,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  UpcomingProgress.fromJson(Map<String, dynamic> json) {
    progressId = json['progress_id'];
    uomName = json['uom_name'];
    quantity = json['quantity'];
    quantityId = json['quantity_id'];
    locationName = json['location_name'];
    subLocationName = json['sub_location_name'];
    subSubLocationName = json['sub_sub_location_name'];
    activityHead = json['activity_head'];
    startTrigger = json['start_trigger'];
    linkingActivityId = json['linking_activity_id'];
    activityId = json['activity_id'];
    budgetId = json['budget_id'];
    activity = json['activity'];
    activityOrder = json['activity_order'];
    uomId = json['uom_id'];
    description = json['description'];
    corel = json['corel'];
    locationId = json['location_id'];
    subLocId = json['sub_loc_id'];
    subSubLocId = json['sub_sub_loc_id'];
    status = json['status'];
    import = json['import'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['progress_id'] = progressId;
    data['uom_name'] = uomName;
    data['quantity'] = quantity;
    data['quantity_id'] = quantityId;
    data['location_name'] = locationName;
    data['sub_location_name'] = subLocationName;
    data['sub_sub_location_name'] = subSubLocationName;
    data['activity_head'] = activityHead;
    data['start_trigger'] = startTrigger;
    data['linking_activity_id'] = linkingActivityId;
    data['activity_id'] = activityId;
    data['budget_id'] = budgetId;
    data['activity'] = activity;
    data['activity_order'] = activityOrder;
    data['uom_id'] = uomId;
    data['description'] = description;
    data['corel'] = corel;
    data['location_id'] = locationId;
    data['sub_loc_id'] = subLocId;
    data['sub_sub_loc_id'] = subSubLocId;
    data['status'] = status;
    data['import'] = import;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}