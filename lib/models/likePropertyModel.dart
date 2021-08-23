class LikePropertyModel {
  late String likeProprtyId;
  LikePropertyModel();
  LikePropertyModel.getData(this.likeProprtyId);

  Map<String, dynamic> toMap() {
    return {
      'p_id': likeProprtyId,
    };
  }
}
