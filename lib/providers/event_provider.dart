import 'package:events360/data/models/agenda_item.dart';
import 'package:events360/data/models/event.dart';
import 'package:events360/data/models/speaker.dart';
import 'package:events360/data/models/sponsor.dart';
import 'package:events360/data/models/user.dart' as app_user;
import 'package:events360/infrastructure/supabase_service.dart';
import 'package:flutter/foundation.dart';

class EventProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  Event? _event;
  List<AgendaItem> _agendaItems = [];
  List<Speaker> _speakers = [];
  List<app_user.User> _attendees = [];
  List<Sponsor> _sponsors = [];
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  // Getters
  Event? get event => _event;
  List<AgendaItem> get agendaItems => _agendaItems;
  List<Speaker> get speakers => _speakers;
  List<app_user.User> get attendees => _attendees;
  List<Sponsor> get sponsors => _sponsors;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  // Initialize and load all data
  Future<void> loadEventData() async {
    // Fix: Don't check and return early during the first build
    if (_event != null && !_isLoading && !_hasError) {
      return;
    }

    // Only set loading state if we're not already loading
    if (!_isLoading) {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
      notifyListeners();
    }

    try {
      // Get the first event (we're only using one for now)
      final events = await _supabaseService.getEvents();
      if (events.isNotEmpty) {
        final event = events.first;

        // Load all related data for this event in parallel
        final results = await Future.wait([
          _supabaseService.getAgendaItems(event.id),
          _supabaseService.getEventSpeakers(event.id),
          _supabaseService.getEventAttendees(
              event.id), // This now works with the new schema
          _supabaseService.getEventSponsors(event.id),
        ]);

        _event = event;
        _agendaItems = results[0] as List<AgendaItem>;
        _speakers = results[1] as List<Speaker>;
        _attendees = results[2] as List<app_user.User>;
        _sponsors = results[3] as List<Sponsor>;
      } else {
        _hasError = true;
        _errorMessage = 'No event data available';
      }
    } on Exception catch (e) {
      _hasError = true;
      _errorMessage = 'Error loading event data: $e';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Force refresh data
  Future<void> refreshEventData() async {
    _isLoading = true;
    notifyListeners();

    await loadEventData();
  }

  // Find agenda item for a specific speaker
  AgendaItem? findAgendaItemForSpeaker(int speakerId) {
    try {
      return _agendaItems.firstWhere(
        (item) => item.speaker?.id == speakerId,
      );
    } on Exception {
      return null;
    }
  }
}
