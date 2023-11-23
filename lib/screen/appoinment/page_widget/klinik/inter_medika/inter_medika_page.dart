import 'package:flutter/material.dart';
import 'package:reprohealth_app/component/button_component.dart';
import 'package:reprohealth_app/constant/routes_navigation.dart';
import 'package:reprohealth_app/models/klinik_inter_medika_models.dart';
import 'package:reprohealth_app/theme/theme.dart';

class InterMedikaPage extends StatelessWidget {
  const InterMedikaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: primary4),
            backgroundColor: primary,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                child: Image.asset(
                  'assets/foto_klinik3.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: primary,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                        bottom: 16,
                      ),
                      child: Text(
                        klinikInterMedikaData[0].klinik,
                        style: semiBold20Grey900,
                      ),
                    ),
                    Text(
                      klinikInterMedikaData[0].informasi,
                      style: semiBold14Grey900,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 16,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 19,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(klinikInterMedikaData[0].jalan),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 19,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(klinikInterMedikaData[0].number)
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.email_outlined,
                                size: 19,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(klinikInterMedikaData[0].email)
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Profil',
                      style: semiBold14Grey900,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      klinikInterMedikaData[0].isiProfil,
                      style: regular12Grey900,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    ButtonComponent(
                      labelText: 'Selanjutnya',
                      labelStyle: semiBold12Primary,
                      backgroundColor: primarygreen500,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RoutesNavigation.detailInterMedika);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
