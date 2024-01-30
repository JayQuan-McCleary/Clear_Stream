// ignore_for_file: avoid_function_literals_in_foreach_calls, use_build_context_synchronously, avoid_print

import 'package:clear_stream/StartUp/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  List<String> docId = [];
  String _firstName = "";
  String _lastName = "";
  int _age = 0;
  String _email = "";

  @override
  void initState() {
    super.initState();
    getDocId();
  }

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              print(element.reference);
              docId.add(element.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    final userId = user.uid;
    final userDocRef = _firestore.collection('Users').doc(userId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: userDocRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Text('User data not found.');
          }

          // Fetch user data from Firestore
          final userData = snapshot.data!.data() as Map<String, dynamic>;

          _firstName = userData['firstName'] ?? '';
          _lastName = userData['lastName'] ?? '';
          _age = userData['age'] ?? 0;
          _email = userData['email'] ?? '';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField('First Name', 'firstName', snapshot.data!),
                  _buildTextField('Last Name', 'lastName', snapshot.data!),
                  _buildTextField('Age', 'age', snapshot.data!,
                      keyboardType: TextInputType.number),
                  _buildTextField('Email', 'email', snapshot.data!,
                      readOnly: true),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        // Save the updated data to Firestore
                        _firestore.collection('Users').doc(userId).update({
                          'firstName': _firstName,
                          'lastName': _lastName,
                          'age': _age,
                        });
                      }
                    },
                    child: const Text('Save Changes'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Implement logout or delete account functionality
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(
                            showRegisterPage: () {},
                          ),
                        ),
                      );
                    },
                    child: const Text('Logout',
                        style: TextStyle(color: Colors.red)),
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.currentUser!.delete();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                LoginPage(showRegisterPage: () {}),
                          ),
                        );
                      } catch (error) {
                        print('Error deleting user: $error');
                      }
                    },
                    child: const Text('Delete Account',
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
      String label, String attribute, DocumentSnapshot snapshot,
      {TextInputType keyboardType = TextInputType.text,
      bool readOnly = false}) {
    return FormBuilderTextField(
      name: attribute,
      initialValue: attribute == 'email'
          ? _email
          : (snapshot.data() as Map<String, dynamic>)[attribute]?.toString() ??
              '',
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      readOnly: readOnly,
      onSaved: (value) {
        switch (attribute) {
          case 'firstName':
            _firstName = value.toString();
            break;
          case 'lastName':
            _lastName = value.toString();
            break;
          case 'age':
            _age = int.parse(value.toString());
            break;
          case 'email':
            // Read-only, so no need to save
            break;
        }
      },
    );
  }
}
