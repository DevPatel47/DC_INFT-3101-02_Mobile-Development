import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/appointment_provider.dart';
import '../../widgets/appointment_card.dart';

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({super.key});

  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadAppointments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadAppointments() async {
    await context.read<AppointmentProvider>().fetchAppointments();
  }

  Future<void> _handleRefresh() async {
    await _loadAppointments();
  }

  Future<void> _handleCancel(String appointmentId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: const Text(
          'Are you sure you want to cancel this appointment?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final appointmentProvider = context.read<AppointmentProvider>();
      final success =
          await appointmentProvider.cancelAppointment(appointmentId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'Appointment cancelled successfully'
                  : appointmentProvider.error ?? 'Failed to cancel appointment',
            ),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = context.watch<AppointmentProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
          ],
        ),
      ),
      body: appointmentProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: appointmentProvider.upcomingAppointments.isEmpty
                      ? _buildEmptyState(
                          icon: Icons.event_available,
                          message: 'No upcoming appointments',
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount:
                              appointmentProvider.upcomingAppointments.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final appointment =
                                appointmentProvider.upcomingAppointments[index];
                            return AppointmentCard(
                              appointment: appointment,
                              onCancel: () => _handleCancel(appointment.id),
                            );
                          },
                        ),
                ),
                RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: appointmentProvider.pastAppointments.isEmpty
                      ? _buildEmptyState(
                          icon: Icons.history,
                          message: 'No past appointments',
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount:
                              appointmentProvider.pastAppointments.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final appointment =
                                appointmentProvider.pastAppointments[index];
                            return AppointmentCard(
                              appointment: appointment,
                              onCancel: null, // Can't cancel past appointments
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyState({required IconData icon, required String message}) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
