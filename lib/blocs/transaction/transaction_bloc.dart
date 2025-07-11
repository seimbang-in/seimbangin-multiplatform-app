import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:seimbangin_app/models/item_model.dart';
import 'package:seimbangin_app/models/transaction_model.dart';
import 'package:seimbangin_app/services/transaction_service.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

const int _HISTORY_LIMIT = 15;

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionService transactionService;

  TransactionBloc({required this.transactionService})
      : super(TransactionInitial()) {
    on<TransactionButtonPressed>(_addTransaction);
    on<GetRecentTransactionsEvent>(_getRecentTransaction);
    on<FetchHistoryTransactions>(_onFetchHistory);
  }

  /// Handler untuk menambahkan transaksi baru.
  Future<void> _addTransaction(
      TransactionButtonPressed event, Emitter<TransactionState> emit) async {
    try {
      emit(TransactionLoading("Loading..."));
      await transactionService.addTransaction(
          event.items, event.type, event.description, event.name);
      emit(TransactionSuccess("Transaction successful"));
    } catch (e) {
      emit(TransactionFailure("Failed to add transaction: $e"));
    }
  }

  /// Handler untuk mengambil data transaksi terkini (untuk homepage).
  Future<void> _getRecentTransaction(
      GetRecentTransactionsEvent event, Emitter<TransactionState> emit) async {
    // Hanya emit loading jika belum ada data sama sekali.
    if (state is! TransactionLoadSuccess) {
      emit(TransactionLoading("Loading recent transactions..."));
    }

    try {
      final response =
          await transactionService.getTransaction(limit: event.limit, page: 1);

      // Ambil state saat ini jika sudah TransactionLoadSuccess, atau buat baru.
      final currentState = state is TransactionLoadSuccess
          ? (state as TransactionLoadSuccess)
          : TransactionLoadSuccess();

      // Emit state baru dengan memperbarui HANYA `recentTransactions`.
      // Data histori yang mungkin sudah ada di state akan tetap aman.
      emit(currentState.copyWith(
        recentTransactions: response.data,
      ));
    } catch (e) {
      emit(TransactionFailure("Failed to get recent transaction: $e"));
    }
  }

  /// Handler untuk mengambil seluruh riwayat transaksi dengan lazy loading (untuk halaman histori).
  Future<void> _onFetchHistory(
      FetchHistoryTransactions event, Emitter<TransactionState> emit) async {
    final currentState = state;

    // Hentikan jika sudah mencapai data terakhir dan bukan proses refresh.
    if (currentState is TransactionLoadSuccess &&
        currentState.hasReachedMax &&
        !event.isRefresh) {
      return;
    }

    try {
      TransactionLoadSuccess baseState;

      // Jika ini adalah proses refresh (pull-to-refresh) atau fetch pertama kali,
      // kita mulai dari state dasar.
      if (event.isRefresh || currentState is! TransactionLoadSuccess) {
        emit(TransactionLoading("Loading history..."));
        // Pertahankan data recentTransactions jika ada, agar tidak hilang saat refresh.
        baseState = TransactionLoadSuccess(
            recentTransactions: currentState is TransactionLoadSuccess
                ? currentState.recentTransactions
                : []);
      } else {
        // Jika tidak, kita lanjutkan dari state yang ada untuk pagination.
        baseState = currentState;
      }

      final nextPage =
          (baseState.historicalTransactions.length ~/ _HISTORY_LIMIT) + 1;

      final response = await transactionService.getTransaction(
          limit: _HISTORY_LIMIT, page: nextPage);

      // Gabungkan data lama dengan data baru jika bukan proses refresh.
      final newTransactions = event.isRefresh
          ? response.data
          : baseState.historicalTransactions + response.data;

      // Emit state baru dengan memperbarui HANYA data histori.
      emit(baseState.copyWith(
        historicalTransactions: newTransactions,
        hasReachedMax: !response.meta.hasNextPage,
      ));
    } catch (e) {
      emit(TransactionFailure("Failed to load history: $e"));
    }
  }
}
