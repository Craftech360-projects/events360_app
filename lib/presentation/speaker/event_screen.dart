// import 'package:events360/presentation/settings/settings_screen.dart';
// import 'package:flutter/material.dart';

// class Event {
//   final String name;
//   final String eventActivity;
//   final String eventDate;
//   final String client;
//   final String eventLocation;
//   final String description;
//   final String rating;

//   Event({
//     required this.name,
//     required this.eventActivity,
//     required this.eventDate,
//     required this.client,
//     required this.eventLocation,
//     required this.description,
//     required this.rating,
//   });
// }

// final List<Event> events = [
//   Event(
//     name: 'Boom Box',
//     eventActivity: 'AR Videobooth',
//     eventDate: '08/02/2025',
//     client: 'DNA',
//     eventLocation: 'Gurgoan',
//     description: '',
//     rating: 'Not available',
//   ),
//   Event(
//     name: 'Glambot',
//     eventActivity: 'Glambot',
//     eventDate: '08/02/2025',
//     client: 'Quebec',
//     eventLocation: 'Taj west end, Bangalore',
//     description: '',
//     rating: 'Not available',
//   ),
//   Event(
//     name: 'PhonePe',
//     eventActivity: 'AI Photobooth',
//     eventDate: '20/02/2025',
//     client: 'PhonePe',
//     eventLocation: 'Salarpuria Softzone, Bellandur',
//     description: '',
//     rating: 'Not available',
//   ),
//   Event(
//     name: 'Delta Aurora - Elecrama',
//     eventActivity: 'Aurora',
//     eventDate: '22/02/2025 to 26/02/2025',
//     client: 'Elecrama',
//     eventLocation: 'India Expo Mart Greater Noida',
//     description: '',
//     rating: 'Not available',
//   ),
//   Event(
//     name: 'NIMHANS',
//     eventActivity: 'Mindwave Car & AI Photobooth',
//     eventDate: '26/02/2025',
//     client: 'Beep',
//     eventLocation: 'Nimhans convention center',
//     description: '',
//     rating: 'Not available',
//   ),
//   Event(
//     name: 'Infosys',
//     eventActivity: 'AI Photobooth',
//     eventDate: '26/02/2025',
//     client: 'Infosys',
//     eventLocation: 'Infosys Campus, Bangalore',
//     description: '',
//     rating: 'Not available',
//   ),
//   Event(
//     name: 'Nielson PR & Launch',
//     eventActivity: 'AI photobooth, Slingshot & 360 Vinebooth',
//     eventDate: '04/03/2025',
//     client: 'Distinct com',
//     eventLocation: 'Mumbai',
//     description: '',
//     rating: 'Not available',
//   ),
//   Event(
//     name: 'Verticular',
//     eventActivity: 'Strip Photobooth',
//     eventDate: '05/03/2025',
//     client: 'BrandAid',
//     eventLocation: 'Coimbatore',
//     description: '',
//     rating: 'Not available',
//   )
// ];

// class EventScreen extends StatefulWidget {
//   const EventScreen({super.key});

//   @override
//   State<EventScreen> createState() => _EventScreenState();
// }

// class _EventScreenState extends State<EventScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Event> _filteredEvents = [];
//   String _searchQuery = '';
//   String _filterType = 'All'; // 'All', 'Name', 'Location', 'Date'

//   @override
//   void initState() {
//     super.initState();
//     _filteredEvents = List.from(events);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _filterEvents() {
//     setState(() {
//       if (_searchQuery.isEmpty) {
//         _filteredEvents = List.from(events);
//         return;
//       }

//       _filteredEvents = events.where((event) {
//         final query = _searchQuery.toLowerCase();

//         if (_filterType == 'Name') {
//           return event.name.toLowerCase().contains(query);
//         } else if (_filterType == 'Location') {
//           return event.eventLocation.toLowerCase().contains(query);
//         } else if (_filterType == 'Date') {
//           return event.eventDate.toLowerCase().contains(query);
//         } else {
//           // 'All' - search in all fields
//           return event.name.toLowerCase().contains(query) ||
//               event.eventLocation.toLowerCase().contains(query) ||
//               event.eventDate.toLowerCase().contains(query) ||
//               event.client.toLowerCase().contains(query) ||
//               event.eventActivity.toLowerCase().contains(query);
//         }
//       }).toList();
//     });
//   }

//   Widget _buildInfoRow(IconData icon, String label, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 20, color: Colors.blue),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey,
//                 ),
//               ),
//               Constants.h4,
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Events', style: Theme.of(context).textTheme.headlineSmall),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings_rounded),
//             onPressed: () => Navigator.push(context,
//                 MaterialPageRoute(builder: (_) => const SettingsScreen())),
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                     hintText: 'Search events...',
//                     prefixIcon: const Icon(Icons.search),
//                     suffixIcon: _searchQuery.isNotEmpty
//                         ? IconButton(
//                             icon: const Icon(Icons.clear),
//                             onPressed: () {
//                               _searchController.clear();
//                               setState(() {
//                                 _searchQuery = '';
//                               });
//                               _filterEvents();
//                             },
//                           )
//                         : null,
//                     border: OutlineInputBorder(
//                       borderRadius: Constants.br12,
//                     ),
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       _searchQuery = value;
//                     });
//                     _filterEvents();
//                   },
//                 ),
//                 
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       _buildFilterChip('All'),
//                       Constants.w8,
//                       _buildFilterChip('Name'),
//                       Constants.w8,
//                       _buildFilterChip('Location'),
//                       Constants.w8,
//                       _buildFilterChip('Date'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: _filteredEvents.isEmpty
//                 ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(Icons.search_off, size: 64),
//                         Constants.h16,
//                         Text(
//                           'No events found',
//                           style: Theme.of(context).textTheme.titleLarge,
//                         ),
//                         
//                         Text(
//                           'Try changing your search criteria',
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                       ],
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: _filteredEvents.length,
//                     itemBuilder: (context, index) {
//                       final event = _filteredEvents[index];
//                       return Card(
//                         margin: const EdgeInsets.all(10),
//                         child: ListTile(
//                           title: Text(
//                             event.name,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Text('${event.client}\n${event.eventDate}'),
//                           onTap: () => showDialog(
//                             context: context,
//                             builder: (context) => Dialog(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: SingleChildScrollView(
//                                 child: Container(
//                                   padding: const EdgeInsets.all(20),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Expanded(
//                                             child: Text(
//                                               event.name,
//                                               style: const TextStyle(
//                                                 fontSize: 24,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ),
//                                           IconButton(
//                                             icon: const Icon(Icons.close),
//                                             onPressed: () => Navigator.pop(context),
//                                           ),
//                                         ],
//                                       ),
//                                       const Divider(thickness: 1),
//                                       Constants.h16,
//                                       _buildInfoRow(Icons.business, 'Client', event.client),
//                                       Constants.h16,
//                                       _buildInfoRow(
//                                           Icons.event, 'Activity', event.eventActivity),
//                                       Constants.h16,
//                                       _buildInfoRow(
//                                           Icons.calendar_today, 'Date', event.eventDate),
//                                       Constants.h16,
//                                       _buildInfoRow(Icons.location_on, 'Location',
//                                           event.eventLocation),
//                                       if (event.description.isNotEmpty) ...[
//                                         Constants.h16,
//                                         _buildInfoRow(Icons.description, 'Description',
//                                             event.description),
//                                       ],
//                                       Constants.h16,
//                                       _buildInfoRow(Icons.star, 'Rating', event.rating),
//                                       
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ) ,
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterChip(String filterName) {
//     return FilterChip(
//       label: Text(filterName),
//       selected: _filterType == filterName,
//       onSelected: (selected) {
//         setState(() {
//           _filterType = filterName;
//         });
//         _filterEvents();
//       },
//     );
//   }
// }
