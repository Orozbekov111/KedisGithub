// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:kedisss/features/data/repositories/firebase_user_repository.dart';

// part 'update_user_info_event.dart';
// part 'update_user_info_state.dart';

// class UpdateUserInfoBloc
//     extends Bloc<UpdateUserInfoEvent, UpdateUserInfoState> {
//   final FirebaseUserRepository _firebaseUserRepository;

//   UpdateUserInfoBloc({required FirebaseUserRepository firebaseUserRepository})
//       : _firebaseUserRepository = firebaseUserRepository,
//         super(UpdateUserInfoInitial()) {
//     on<UploadPicture>((event, emit) async{
//       emit(UpdatePictureLoading());
//       try {
//         String userImage = await _firebaseUserRepository.uploadPicture(event.file, event.userId);
//         emit(UpdatePictureSuccess(userImage));
//       } catch (e) {
//         emit(UpdatePictureFailure());
//       }
//     });  
//   }
// }
