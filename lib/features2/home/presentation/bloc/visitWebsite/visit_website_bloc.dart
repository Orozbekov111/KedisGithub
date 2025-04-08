import 'package:bloc/bloc.dart';
import 'package:url_launcher/url_launcher.dart';

part 'visit_website_event.dart';
part 'visit_website_state.dart';

class VisitWebsiteBloc extends Bloc<VisitWebsiteEvent, VisitWebsiteState> {
  VisitWebsiteBloc() : super(VisitWebsiteInitial()) {
    on<LaunchWebsiteEvent>((event, emit) async {
      emit(VisitWebsiteLoading());
      try {
        final Uri uri = Uri.parse(event.url);
        if (!await launchUrl(uri)) {
          emit(VisitWebsiteError('Could not launch ${event.url}'));
        } else {
          emit(VisitWebsiteSuccess());
        }
      } catch (e) {
        emit(VisitWebsiteError(e.toString()));
      }
    });
  }
}
