import 'dart:convert';

class NoteResponseModel {
    final String? message;
    final Note? data;

    NoteResponseModel({
        this.message,
        this.data,
    });

    factory NoteResponseModel.fromJson(String str) => NoteResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory NoteResponseModel.fromMap(Map<String, dynamic> json) => NoteResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : Note.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "data": data?.toMap(),
    };
}

class Note {
    final int? id;
    final String? title;
    final String? content;
    final String? image;
    final int? isPinned;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Note({
        this.id,
        this.title,
        this.content,
        this.image,
        this.isPinned,
        this.createdAt,
        this.updatedAt,
    });

    factory Note.fromJson(String str) => Note.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Note.fromMap(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        image: json["image"],
        isPinned: json["is_pinned"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "content": content,
        "image": image,
        "is_pinned": isPinned,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
