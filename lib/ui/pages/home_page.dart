// lib/ui/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/ai_advisor_section.dart';
import 'package:seimbangin_app/ui/sections/homepage/home_recent_transact_section.dart';
import 'package:seimbangin_app/ui/sections/income_outcome_section.dart';
import 'package:seimbangin_app/ui/sections/header_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Panggil event untuk kedua BLoC saat halaman pertama kali dimuat
    context.read<HomepageBloc>().add(HomepageStarted());
    context.read<TransactionBloc>().add(
        GetRecentTransactionsEvent(limit: 5)); // Menyesuaikan limit jika perlu
  }

  // Fungsi getCategoryColor bisa dihapus dari sini jika tidak digunakan di sini
  // dan sudah ada di dalam HomeRecentTransactionsSection

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // -- PERUBAHAN DIMULAI DI SINI --
    // Kita bungkus widget kita dengan BlocListener untuk TransactionBloc
    return BlocListener<TransactionBloc, TransactionState>(
      // listener akan dieksekusi setiap kali ada perubahan state di TransactionBloc
      listener: (context, state) {
        // Kita hanya peduli jika transaksi BERHASIL ditambahkan
        if (state is TransactionSuccess) {
          // Jika berhasil, panggil event untuk me-refresh SEMUA data di homepage

          // 1. Refresh data utama (Balance, Income, Outcome, Advice)
          context.read<HomepageBloc>().add(HomepageStarted());

          // 2. Refresh daftar transaksi terbaru
          context
              .read<TransactionBloc>()
              .add(GetRecentTransactionsEvent(limit: 5));
        }
      },
      // listenWhen adalah optimasi agar listener tidak berjalan untuk setiap state
      // Listener hanya akan aktif jika state nya adalah TransactionSuccess.
      listenWhen: (previous, current) {
        return current is TransactionSuccess;
      },
      // -- AKHIR DARI PERUBAHAN --
      // BlocBuilder untuk HomepageBloc tetap sama, tugasnya membangun UI
      child: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          if (state is HomePageSuccess) {
            final user = state.user;
            return Scaffold(
              backgroundColor: backgroundWhiteColor,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: 220.r,
                    pinned: false,
                    floating: false,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      background: HeaderSection(
                        name: user.data.username ?? "Guest",
                        // Menggunakan data dari state HomePageSuccess yang sudah realtime
                        money: user.data.balance?.toString() ?? '0',
                        imageUrl: "assets/img_mascot-login.png",
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: backgroundWhiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 24.r),
                            // SECTION 1: INCOME & OUTCOME (Sekarang Realtime)
                            IncomeOutcomeSection(
                              incomeAmount: user
                                      .data.financeProfile?.totalIncome
                                      .toString() ??
                                  '0',
                              outcomeAmount: user
                                      .data.financeProfile?.totalOutcome
                                      .toString() ??
                                  '0',
                            ),
                            SizedBox(height: 20.r),
                            // SECTION 2: AI ADVISOR (Sekarang Realtime)
                            Text(
                              "AI Advisor",
                              style: blackTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(height: 10.r),
                            AiAdvisorSection(
                              financialProfileButtonOntap: () =>
                                  routes.pushNamed(RouteNames.financialProfile),
                              advice: state.advice,
                              isAdviceExist:
                                  state.user.data.financeProfile != null,
                            ),
                            SizedBox(height: 20.r),
                            // SECTION 3: RECENT TRANSACTIONS (Sekarang Realtime)
                            HomeRecentTransactionsSection(),
                            SizedBox(height: 100.r),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          // Tambahkan state loading dari HomePageBloc untuk UX yang lebih baik
          if (state is HomePageLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          // Fallback untuk state lainnya
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
