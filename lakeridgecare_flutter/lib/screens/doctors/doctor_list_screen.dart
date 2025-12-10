import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/doctor_provider.dart';
import '../../core/app_router.dart';
import '../../widgets/doctor_card.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final doctorProvider = context.read<DoctorProvider>();
    if (doctorProvider.doctors.isEmpty) {
      doctorProvider.fetchDoctors();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    await context.read<DoctorProvider>().fetchDoctors();
  }

  void _showFilterDialog() {
    final doctorProvider = context.read<DoctorProvider>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter by Department'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('All Departments'),
                leading: Radio<String?>(
                  value: null,
                  groupValue: doctorProvider.selectedDepartment,
                  onChanged: (value) {
                    doctorProvider.filterByDepartment(null);
                    Navigator.pop(context);
                  },
                ),
                onTap: () {
                  doctorProvider.filterByDepartment(null);
                  Navigator.pop(context);
                },
              ),
              ...doctorProvider.departments.map((dept) {
                return ListTile(
                  title: Text(dept),
                  leading: Radio<String?>(
                    value: dept,
                    groupValue: doctorProvider.selectedDepartment,
                    onChanged: (value) {
                      doctorProvider.filterByDepartment(value);
                      Navigator.pop(context);
                    },
                  ),
                  onTap: () {
                    doctorProvider.filterByDepartment(dept);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final doctorProvider = context.watch<DoctorProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Doctors'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search doctors...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          doctorProvider.searchDoctors('');
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                doctorProvider.searchDoctors(value);
              },
            ),
          ),
          if (doctorProvider.selectedDepartment != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Chip(
                label: Text(doctorProvider.selectedDepartment!),
                onDeleted: () {
                  doctorProvider.filterByDepartment(null);
                },
              ),
            ),
          Expanded(
            child: doctorProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : doctorProvider.error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline,
                                size: 64, color: Colors.red),
                            const SizedBox(height: 16),
                            Text(doctorProvider.error!),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _handleRefresh,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : doctorProvider.doctors.isEmpty
                        ? const Center(
                            child: Text('No doctors found'),
                          )
                        : RefreshIndicator(
                            onRefresh: _handleRefresh,
                            child: ListView.separated(
                              padding: const EdgeInsets.all(16),
                              itemCount: doctorProvider.doctors.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final doctor = doctorProvider.doctors[index];
                                return DoctorCard(
                                  doctor: doctor,
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRouter.doctorDetails,
                                      arguments: doctor,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}
