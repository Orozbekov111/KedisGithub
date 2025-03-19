import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/firebase_user_repository.dart';
import '../../bloc/authentication/sign_in_bloc/sign_in_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../widgets/button_widget.dart';
import 'components/ChangePasswordScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _imageUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final firebaseUserRepository = FirebaseUserRepository();
    UserModel? user = await firebaseUserRepository.getCurrentUser();

    setState(() {
      _imageUrl = user?.picture; // Use the picture URL from Firestore
      _isLoading = false;
    });
  }

  Future<void> _uploadImage(File imageFile, String userId) async {
    String fileName = '$userId.jpg'; // Unique filename based on user ID
    Reference ref = FirebaseStorage.instance.ref().child('profile_pictures/$fileName');

    await ref.putFile(imageFile);
    String downloadUrl = await ref.getDownloadURL(); // Get download URL

    final firebaseUserRepository = FirebaseUserRepository();
    UserModel? user = await firebaseUserRepository.getCurrentUser();

    if (user != null) {
      user = user.copyWith(picture: downloadUrl);
      await firebaseUserRepository.setUserData(user);

      setState(() {
        _imageUrl = downloadUrl; // Update state with new image URL
      });
    }
  }

  Future<void> _deleteImage(String? fileName) async {
    if (fileName == null || fileName.isEmpty) return;

    try {
      // Delete the image from Firebase Storage
      Reference ref = FirebaseStorage.instance.ref().child('profile_pictures/$fileName');
      await ref.delete();

      final firebaseUserRepository = FirebaseUserRepository();
      UserModel? user = await firebaseUserRepository.getCurrentUser();

      if (user != null) {
        user = user.copyWith(picture: null);
        await firebaseUserRepository.setUserData(user); // Save updated user data in Firestore

        setState(() => _imageUrl = null); // Clear the image URL after deletion
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Изображение успешно удалено')),
      );
    } catch (e) {
      print('Не удалось удалить изображение: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ошибка при удалении изображения')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: StreamBuilder<UserModel?>(
        stream: FirebaseUserRepository().user,
        builder: (context, snapshot) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Пользователь не найден'));
          }

          UserModel user = snapshot.data!;
          return Stack(
            children: [
              _buildBackgroundContainer(screenHeight),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 150),
                    _buildProfilePicture(user),
                    const SizedBox(height: 25),
                    _buildUserInfo(user),
                   const  SizedBox(height: 20),
                    _buildDetailsCard(user, screenWidth),
                   const  SizedBox(height: 20),
                    _buildActionButtons(),
                   const  SizedBox(height: 150),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBackgroundContainer(double height) {
    return Container(
      height: height * 0.5,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00796B), Color(0xFF004D40)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildProfilePicture(UserModel user) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 64,
          foregroundImage:
              _imageUrl != null ? NetworkImage(_imageUrl!) : null,
          backgroundColor: Colors.white,
          child: _imageUrl == null
              ? const Icon(Icons.person, size: 80, color: Color(0xFF004D40))
              : null,
        ),
        
        Positioned(
          bottom: -13,
          left: 90,
          child: IconButton(
            onPressed: () async {
              final files =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (files != null) {
                final croppedFile =
                    await ImageCropper().cropImage(sourcePath: files.path);
                if (croppedFile != null) {
                  File selectedImage = File(croppedFile.path);
                  await _uploadImage(selectedImage, user.id);
                }
              }
            },
            icon: const Icon(Icons.add_a_photo, color: Colors.white),
          ),
        ),
        Positioned(
          bottom: -13,
          left: -10,
          child: IconButton(
            onPressed: () => _deleteImage('${user.id}.jpg'), // Pass the correct filename
            icon: const Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(UserModel user) {
    return Column(
      children: [
        Text('${user.fullName}',
            style:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(user.role,
            style:
                const TextStyle(fontSize: 16, color: Colors.white70)),
      ],
    );
  }

  Widget _buildDetailsCard(UserModel user, double screenWidth) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Данные о Студенте"),
          _buildInfoRow("ФИО:", "${user.fullName}"),
          _buildInfoRow("Группа:", "${user.group}"),
          _buildInfoRow("Профессия:", "${user.profession}"),
          const SizedBox(height: 20),
          _buildSectionTitle("Персональные данные"),
          _buildInfoRow("Email:", "${user.emailUser}"),
          _buildInfoRow("Телефон:", "${user.phone}"),
          const SizedBox(height: 20),
          _buildSectionTitle("Личные данные"),
          _buildInfoRow("Логин:", "${user.email}"),
          _buildInfoRow("Пароль:", "${user.password}"),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding : const EdgeInsets.only(bottom :8.0),
      child : Text(title ,style :const TextStyle(fontSize :18 ,fontWeight :FontWeight.bold)),
    );
  }

  Widget _buildInfoRow(String label ,String value) {
    return Padding(
      padding : const EdgeInsets.symmetric(vertical :8), // Vertical spacing between rows
      child : Row(mainAxisAlignment :MainAxisAlignment.spaceBetween ,children :[
        Text(label ,style :const TextStyle(fontWeight :FontWeight.w500)),
        Flexible(child :Text(value ,style :const TextStyle(color :Colors.black54))),
      ]),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children:[
        Padding(
          padding : const EdgeInsets.symmetric(horizontal :20),
          child:
            ButtonWidget(text:'Выйти из учетной записи', pressed:( ) => context.read<SignInBloc>().add(const SignOutRequired()),),
        ),
        const SizedBox(height :10),
        Padding(
          padding : const EdgeInsets.symmetric(horizontal :20),
          child :
            ButtonWidget(text:'Изменить пароль', pressed:( ) => Navigator.push(context ,MaterialPageRoute(builder:(context ) => ChangePasswordScreen())),),
        ),
      ],
    );
  }
}
