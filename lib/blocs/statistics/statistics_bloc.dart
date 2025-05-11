import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:seimbangin_app/models/statistics_model.dart';
import 'package:seimbangin_app/services/statistics_service.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final StatisticsService statisticsService;
  StatisticsBloc({required this.statisticsService})
      : super(StatisticsInitial()) {
    on<StatisticsMonthlyRetrieveData>(_handleStatisticsMonthlyRetrieveData);
  }

  Future<void> _handleStatisticsMonthlyRetrieveData(
      StatisticsEvent event, Emitter<StatisticsState> emit) async {
    try {
      emit(StatisticsMonthlyLoading('Memuat data...'));
      final response = await statisticsService.getMonthlyStatistics();
      emit(StatisticsMonthlySuccess(response.data));
    } catch (e) {
      emit(StatisticsMonthlyFailure('Gagal memuat data: ${e.toString()}'));
    }
  }
}
