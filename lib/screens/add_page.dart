import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddContactPage extends StatefulWidget {
  final Map? contact;
  const AddContactPage({super.key, this.contact});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final contact = widget.contact;
    if (contact != null) {
      isEdit = true;
      final name = contact['title'];
      final description = contact['description'];
      nameController.text = name;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Catatan' : 'Add Catatan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Judul'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Catatan'),
            keyboardType: TextInputType.multiline,
            minLines: 10,
            maxLines: 20,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(isEdit ? 'update' : 'Submit'),
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateData() async {
    final contact = widget.contact;
    if (contact == null) {
      showErrorMessage('ada kesalahan edit');
      return;
    }
    final id = contact['_id'];
    final name = nameController.text;
    final description = descriptionController.text;
    final body = {
      "title": name,
      "description": description,
      "is_completed": false,
    };

    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);

    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      showSuccessMessage('update catatan berhasil');
    } else {
      showErrorMessage('update catatan gagal');
    }
  }

  Future<void> submitData() async {
    final name = nameController.text;
    final description = descriptionController.text;
    final body = {
      "title": name,
      "description": description,
      "is_completed": false,
    };

    const url = 'https://api.nstack.in/v1/todos/';
    final uri = Uri.parse(url);

    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      showSuccessMessage('create catatan berhasil');
    } else {
      print(response.body);
      showErrorMessage('create catatan gagal');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
