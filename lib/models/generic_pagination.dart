class GenericPagination<T> {
  int code;
  Meta meta;
  List<T> data;

  GenericPagination({this.code, this.meta, this.data});

  GenericPagination.fromJson(Map<String, dynamic> json, Function fromJson) {
    code = json['code'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      final items = json['data'].cast<Map<String, dynamic>>();
      data = new List<T>.from(items.map((itemsJson) => fromJson(itemsJson)));
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['code'] = this.code;
  //   if (this.meta != null) {
  //     data['meta'] = this.meta.toJson();
  //   }
  //   if (this.data != null) {
  //     data['data'] = this.data.map((v) => T.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Meta {
  Pagination pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    return data;
  }
}

class Pagination {
  int total;
  int pages;
  int page;
  int limit;

  Pagination({this.total, this.pages, this.page, this.limit});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pages = json['pages'];
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['pages'] = this.pages;
    data['page'] = this.page;
    data['limit'] = this.limit;
    return data;
  }
}
