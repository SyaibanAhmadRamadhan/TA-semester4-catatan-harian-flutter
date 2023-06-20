import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewContactPage extends StatefulWidget {
  final Map? contact;
  const ViewContactPage({super.key, this.contact});

  @override
  State<ViewContactPage> createState() => _ViewContactPageState();
}

class _ViewContactPageState extends State<ViewContactPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final contact = widget.contact;
    if (contact != null) {
      final name = contact['title'];
      final description = contact['description'];
      var createdString = contact['created_at'] as String;
      var newCreatedString =
          '${createdString.substring(0, 10)} ${createdString.substring(11, 23)}';
      DateTime dt = DateTime.parse(newCreatedString);
      var created = DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt);
      var updatedString = contact['updated_at'] as String;
      var newUpdatedString =
          '${updatedString.substring(0, 10)} ${updatedString.substring(11, 23)}';
      DateTime updatedDt = DateTime.parse(newUpdatedString);
      var updated = DateFormat("EEE, d MMM yyyy HH:mm:ss").format(updatedDt);
      nameController.text = '$name \n\ndibuat $created \nupdate $updated';
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Judul',
              border: OutlineInputBorder(),
              labelText: 'Judul',
            ),
            readOnly: true,
            maxLines: 4,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: 'Catatan',
              labelText: 'Catatan',
            ),
            keyboardType: TextInputType.multiline,
            minLines: 10,
            maxLines: 20,
            readOnly: true,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
