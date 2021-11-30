import 'package:flutter_bloc_events/abstracao/bloc_event_state.dart';

// Bloc Event é apenas um classe que extend as funcionalidades
// da classe Object
class AppInitializationEvent extends BlocEvent {
  final AppInitializationEventType type;

  AppInitializationEvent({this.type = AppInitializationEventType.start});
}

enum AppInitializationEventType { start, stop }
