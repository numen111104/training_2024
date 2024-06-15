import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:training_2024/data/datasources/auth_local_datasource.dart';
import 'package:training_2024/data/datasources/config.dart';
import 'package:training_2024/data/models/responses/all_notes_response_model.dart';
import 'package:training_2024/data/models/responses/note_response_model.dart';

class NoteRemoteDatasource {
  Future<Either<String, NoteResponseModel>> addNote(
    String title,
    String content,
    bool isPinned,
    XFile? image,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final Map<String, String> headers = {
      "Authorization": "Bearer ${authData.data!.token}",
    };

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("${Config.baseUrl}/api/notes"),
    );

    request.headers.addAll(headers);
    request.fields["title"] = title;
    request.fields["content"] = content;
    request.fields["is_pinned"] = isPinned ? '1' : '0';

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    http.StreamedResponse response = await request.send();

    final String body = await response.stream.bytesToString();

    return response.statusCode == 201
        ? Right(NoteResponseModel.fromJson(body))
        : Left(body);
  }

  Future<Either<String, AllNotesResponseModel>> getAllNotes() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response =
        await http.get(Uri.parse('${Config.baseUrl}/api/notes'), headers: {
      "Authorization": 'Bearer ${authData.data!.token}',
      "Content-Type": "application/json",
    });

    return response.statusCode == 200
        ? Right(AllNotesResponseModel.fromJson(response.body))
        : Left(response.body);
  }

//delete notes
  Future<Either<String, String>> deleteNotes(int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http
        .delete(Uri.parse('${Config.baseUrl}/api/notes/$id'), headers: {
      "Authorization": "Bearer ${authData.data!.token}",
      "Content-Type": "application/json",
    });
    return response.statusCode == 200
        ? const Right("Deleted Succesfully")
        : Left(response.body);
  }

  Future<Either<String, NoteResponseModel>> updateNotes(
      int id, String title, String content, bool isPinned) async {
    final String uri = "${Config.baseUrl}/api/notes/$id";
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.put(
      Uri.parse(uri),
      headers: {
        "Authorization": "Bearer ${authData.data!.token}",
        "Content-Type": 'application/json',
      },
      body: jsonEncode(
        {'title': title, 'content': content, 'is_pinned': isPinned ? 1 : 0},
      ),
    );
    return response.statusCode == 200
        ? Right(
            NoteResponseModel.fromJson(response.body),
          )
        : Left(response.body);
  }
}
