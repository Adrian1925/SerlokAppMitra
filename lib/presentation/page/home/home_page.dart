import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/model/profile_model.dart';
import '../../bloc/add_vhicle/add_vehicle_bloc.dart';
import '../../bloc/add_vhicle/add_vehicle_event.dart';
import '../../bloc/add_vhicle/add_vehicle_state.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_event.dart';
import '../../bloc/profile/profile_state.dart';
import '../../widgets/home/empty_vehicle_section_widget.dart';
import '../../widgets/home/header_home_widget.dart';
import '../../widgets/home/info_banner_widget.dart';
import '../../widgets/home/offer_section_widget.dart';
import '../../widgets/home/saldo_warning_section_widget.dart';
import '../../widgets/home/status_card_widget.dart';
import '../../widgets/home/vehicle_section_widget.dart';
import '../verification/verification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOnline = true;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfile());
    context.read<VehicleBloc>().add(LoadVehicleList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(context),
              const SizedBox(height: 32),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is ProfileLoaded) {
                    return _buildContentByCondition(context, state.profile);
                  }

                  if (state is ProfileError) {
                    return Center(
                      child: Text(
                        'Error: ${state.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  return const Center(child: Text("Gagal memuat profil"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentByCondition(BuildContext context, ProfileModel profile) {
    final status = profile.status.toLowerCase();
    final orderactive = profile.orderActive;
    final state = profile.state.toLowerCase();

    if (status == 'pending') {
      return InfoBanner(
        title: 'Akun anda membutuhkan verifikasi',
        subtitle: 'Kami membutuhkan beberapa dokumen dan data anda',
        buttonLabel: 'Mulai Verifikasi Sekarang',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VerificationPage()),
          );
        },
      );
    } else if (status == 'review') {
      return InfoBanner(
        title: 'Akun anda sedang kami review',
        subtitle: 'Kami akan menghubungi anda jika ada kendala',
      );
    } else if (status == 'balanced') {
      return SaldoWarningSection(onAddVehicle: () {});
    } else if (status == 'active' || status == 'approved') {
      // hapus active waktu production
      return BlocBuilder<VehicleBloc, VehicleState>(
        builder: (context, vehicleState) {
          if (vehicleState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          Widget vehicleContent;
          if (vehicleState.vehicles.isEmpty) {
            vehicleContent = EmptyVehicleSection(
              onAddVehicle: () {
                Navigator.pushNamed(context, '/addVhicleIntro').then(
                    (_) => context.read<VehicleBloc>().add(LoadVehicleList()));
              },
            );
          } else {
            vehicleContent = VehicleSection(vehicles: vehicleState.vehicles);
          }

          if (orderactive > 0) {
            return OfferSection(
              state: state,
              onToggle: (v) =>
                  context.read<ProfileBloc>().add(UpdateOnlineStatus(v)),
            );
          } else {
            return Column(
              children: [
                StatusCard(
                  state: state,
                  onToggle: (v) =>
                      context.read<ProfileBloc>().add(UpdateOnlineStatus(v)),
                ),
                const SizedBox(height: 16),
                vehicleContent,
              ],
            );
          }
        },
      );
    }
    return InfoBanner(
      title: 'Akun anda membutuhkan verifikasi',
      subtitle: 'Kami membutuhkan beberapa dokumen dan data anda',
      buttonLabel: 'Mulai Verifikasi Sekarang',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VerificationPage()),
        );
      },
    );
  }
}