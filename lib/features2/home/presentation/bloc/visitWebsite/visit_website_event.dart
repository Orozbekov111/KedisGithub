part of 'visit_website_bloc.dart';

abstract class VisitWebsiteEvent {}

class LaunchWebsiteEvent extends VisitWebsiteEvent {
  final String url;

  LaunchWebsiteEvent(this.url);
}