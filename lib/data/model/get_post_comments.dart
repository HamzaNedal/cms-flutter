class GetPostCommets {
  List<DataComment> data;

  GetPostCommets({this.data});

  GetPostCommets.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DataComment>();
      json['data'].forEach((v) {
        data.add(new DataComment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataComment {
  String name;
  String email;
  Null website;
  String comment;
  String status;
  String auther;
  String createDate;

  DataComment(
      {this.name,
      this.email,
      this.website,
      this.comment,
      this.status,
      this.auther,
      this.createDate});

  DataComment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    website = json['website'];
    comment = json['comment'];
    status = json['status'];
    auther = json['auther'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['website'] = this.website;
    data['comment'] = this.comment;
    data['status'] = this.status;
    data['auther'] = this.auther;
    data['create_date'] = this.createDate;
    return data;
  }
}
