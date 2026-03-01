import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OwnerDormitories extends StatefulWidget {
  const OwnerDormitories({Key? key}) : super(key: key);

  @override
  State<OwnerDormitories> createState() => _OwnerDormitoriesState();
}

class _OwnerDormitoriesState extends State<OwnerDormitories> {
  List<Map<String, dynamic>> _dorms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDorms();
  }

  // API: Fetch dormitories from database
  Future<void> _fetchDorms() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/lcozy_api/get_dorms.php'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          setState(() {
            _dorms = List<Map<String, dynamic>>.from(data['dormitories']);
            _isLoading = false;
          });
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Failed to load dormitories');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading dorms: $e')),
      );
    }
  }

  // API: Add new dormitory to database
  Future<void> _addDormToDatabase(Map<String, dynamic> dormData) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/lcozy_api/add_dorm.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dormData),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] != false) {
          _fetchDorms(); // Refresh the list
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Dormitory added successfully!')),
          );
        } else {
          throw Exception('Failed to add dormitory');
        }
      } else {
        throw Exception('Failed to add dormitory');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Show Add Room Dialog
  void _showAddRoomDialog() {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final totalSlotsController = TextEditingController();
    final availableSlotsController = TextEditingController();
    final locationController = TextEditingController();
    final roomTypeController = TextEditingController(text: 'Standard');
    final overviewController = TextEditingController();
    final contactController = TextEditingController();
    final imageUrlController = TextEditingController();
    bool _isSubmitting = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add New Dormitory'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Room Name'),
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(labelText: 'Price per Month'),
                    keyboardType: TextInputType.number,
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: totalSlotsController,
                    decoration: const InputDecoration(labelText: 'Total Slots'),
                    keyboardType: TextInputType.number,
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: availableSlotsController,
                    decoration: const InputDecoration(labelText: 'Available Slots'),
                    keyboardType: TextInputType.number,
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: locationController,
                    decoration: const InputDecoration(labelText: 'Location'),
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: roomTypeController,
                    decoration: const InputDecoration(labelText: 'Room Type'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: overviewController,
                    decoration: const InputDecoration(labelText: 'Overview'),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: contactController,
                    decoration: const InputDecoration(labelText: 'Contact'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: imageUrlController,
                    decoration: const InputDecoration(labelText: 'Image URL'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _isSubmitting
                  ? null
                  : () async {
                      if (formKey.currentState!.validate()) {
                        setDialogState(() {
                          _isSubmitting = true;
                        });

                        try {
                          final dormData = {
                            'name': nameController.text,
                            'price_per_month': double.parse(priceController.text),
                            'total_slots': int.parse(totalSlotsController.text),
                            'available_slots': int.parse(availableSlotsController.text),
                            'location': locationController.text,
                            'room_type': roomTypeController.text,
                            'overview': overviewController.text,
                            'contact': contactController.text,
                            'image_url': imageUrlController.text,
                          };

                          await _addDormToDatabase(dormData);
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        } finally {
                          setDialogState(() {
                            _isSubmitting = false;
                          });
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00BCD4),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- TOP ACTION BAR ---
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Manage Rooms",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF34495E),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _showAddRoomDialog,
                icon: const Icon(Icons.add, color: Colors.white, size: 18),
                label: const Text(
                  "Add Room",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BCD4), // L'COZY Cyan
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ),

        // --- DORMITORY LIST ---
        Expanded(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00BCD4)),
                  ),
                )
              : _dorms.isEmpty
                  ? const Center(
                      child: Text('No dormitories added yet'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      itemCount: _dorms.length,
                      itemBuilder: (context, index) {
                        final dorm = _dorms[index];
                        return _buildDormCard(dorm);
                      },
                    ),
        ),
      ],
    );
  }

  // HELPER: Builds individual Dormitory Cards
  Widget _buildDormCard(Map<String, dynamic> dorm) {
    final isAvailable = int.parse(dorm['available_slots'].toString()) > 0;
    final status = isAvailable ? 'Available' : 'Full';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room Icon / Image Placeholder
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6F8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.bed, color: Color(0xFF7F8C8D), size: 30),
          ),
          const SizedBox(width: 16),
          
          // Room Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dorm['name'] ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF34495E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${dorm['price_per_month']} / month',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF00BCD4), // Cyan accent for price
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.people_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      "Capacity: ${dorm['available_slots']}/${dorm['total_slots']}",
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Status Badge & Action Menu
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 3-dot menu for editing/deleting
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.more_vert, color: Colors.grey),
                onPressed: () {
                  // TODO: Show edit/delete bottom sheet
                },
              ),
              const SizedBox(height: 12),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isAvailable 
                      ? const Color(0xFF2ECC71).withOpacity(0.1) // Light Green
                      : const Color(0xFFE74C3C).withOpacity(0.1), // Light Red
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isAvailable 
                        ? const Color(0xFF2ECC71) 
                        : const Color(0xFFE74C3C),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}