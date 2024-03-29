class CompletedProgress {
  bool? success;
  List<CompletedProgressListData>? data;

  CompletedProgress({this.success, this.data});

  CompletedProgress.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CompletedProgressListData>[];
      json['data'].forEach((v) {
        data!.add(CompletedProgressListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompletedProgressListData {
  num? checklistId;
  num? checkStatus;
  num? triggerId;
  num? cmId;
  String? locationName;
  String? subLocationName;
  String? subSubLocationName;
  String? activity;
  String? activityHead;
  String? uomName;
  num? dailyId;
  num? progressId;
  num? contractorId;
  num? cumulativeQuantity;
  num? achivedQuantity;
  num? totalQuantity;
  String? progressDate;
  num? progressPercentage;
  // ignore: prefer_typing_uninitialized_variables
  var debetContactor;
  num? progType;
  String? remarks;
  num? draftStatus;
  String? createdAt;
  String? updatedAt;
  num? id;
  num? clientId;
  num? projectId;
  num? type;
  num? linkActivityId;
  num? createdBy;
  num? updatedBy;

  CompletedProgressListData(
      {this.checklistId,
      this.checkStatus,
      this.triggerId,
      this.cmId,
      this.locationName,
      this.subLocationName,
      this.subSubLocationName,
      this.activity,
      this.activityHead,
      this.uomName,
      this.dailyId,
      this.progressId,
      this.contractorId,
      this.cumulativeQuantity,
      this.achivedQuantity,
      this.totalQuantity,
      this.progressDate,
      this.progressPercentage,
      this.debetContactor,
      this.progType,
      this.remarks,
      this.draftStatus,
      this.createdAt,
      this.updatedAt,
      this.id,
      this.clientId,
      this.projectId,
      this.type,
      this.linkActivityId,
      this.createdBy,
      this.updatedBy});

  CompletedProgressListData.fromJson(Map<String, dynamic> json) {
    checklistId = json['checklist_id'];
    checkStatus = json['check_status'];
    triggerId = json['trigger_id'];
    cmId = json['cm_id'];
    locationName = json['location_name'];
    subLocationName = json['sub_location_name'];
    subSubLocationName = json['sub_sub_location_name'];
    activity = json['activity'];
    activityHead = json['activity_head'];
    uomName = json['uom_name'];
    dailyId = json['daily_id'];
    progressId = json['progress_id'];
    contractorId = json['contractor_id'];
    cumulativeQuantity = json['cumulative_quantity'];
    achivedQuantity = json['achived_quantity'];
    totalQuantity = json['total_quantity'];
    progressDate = json['progress_date'];
    progressPercentage = json['progress_percentage'];
    debetContactor = json['debet_contactor'];
    progType = json['prog_type'];
    remarks = json['remarks'];
    draftStatus = json['draft_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    type = json['type'];
    linkActivityId = json['link_activity_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['checklist_id'] = checklistId;
    data['check_status'] = checkStatus;
    data['trigger_id'] = triggerId;
    data['cm_id'] = cmId;
    data['location_name'] = locationName;
    data['sub_location_name'] = subLocationName;
    data['sub_sub_location_name'] = subSubLocationName;
    data['activity'] = activity;
    data['activity_head'] = activityHead;
    data['uom_name'] = uomName;
    data['daily_id'] = dailyId;
    data['progress_id'] = progressId;
    data['contractor_id'] = contractorId;
    data['cumulative_quantity'] = cumulativeQuantity;
    data['achived_quantity'] = achivedQuantity;
    data['total_quantity'] = totalQuantity;
    data['progress_date'] = progressDate;
    data['progress_percentage'] = progressPercentage;
    data['debet_contactor'] = debetContactor;
    data['prog_type'] = progType;
    data['remarks'] = remarks;
    data['draft_status'] = draftStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['id'] = id;
    data['client_id'] = clientId;
    data['project_id'] = projectId;
    data['type'] = type;
    data['link_activity_id'] = linkActivityId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    return data;
  }
}