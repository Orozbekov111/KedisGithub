part of 'visit_website_bloc.dart';

abstract class VisitWebsiteState {}

class VisitWebsiteInitial extends VisitWebsiteState {}

class VisitWebsiteLoading extends VisitWebsiteState {}

class VisitWebsiteSuccess extends VisitWebsiteState {}

class VisitWebsiteError extends VisitWebsiteState {
  final String error;

  VisitWebsiteError(this.error);
}