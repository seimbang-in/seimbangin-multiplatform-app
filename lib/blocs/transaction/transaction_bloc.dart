import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:seimbangin_app/models/item_model.dart';
import 'package:seimbangin_app/models/transaction_model.dart';
import 'package:seimbangin_app/services/transaction_service.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

// Konstanta untuk jumlah data yang dimuat per halaman
const int _TRANSACTION_LIMIT = 15;

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionService transactionService;

  TransactionBloc({required this.transactionService})
      : super(TransactionInitial()) {
    on<TransactionButtonPressed>(_addTransaction);
    on<GetRecentTransactionsEvent>(_getRecentTransaction);
    // Daftarkan handler untuk event baru lazy load
    on<FetchHistoryTransactions>(_onFetchHistory);
  }

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

  // Handler ini tetap ada untuk kebutuhan homepage (recent transactions)
  Future<void> _getRecentTransaction(
      GetRecentTransactionsEvent event, Emitter<TransactionState> emit) async {
    try {
      emit(TransactionLoading("Loading..."));
      // Selalu ambil halaman pertama untuk recent
      final response =
          await transactionService.getTransaction(limit: event.limit, page: 1);
      emit(TransactionGetSuccess(response));
    } catch (e) {
      emit(TransactionFailure("Failed to get transaction: $e"));
    }
  }

  // Handler baru khusus untuk lazy load di halaman histori
  Future<void> _onFetchHistory(
      FetchHistoryTransactions event, Emitter<TransactionState> emit) async {
    final currentState = state;

    // Jika state saat ini adalah HistoryLoadSuccess dan sudah mencapai data maksimal,
    // maka hentikan proses untuk menghindari pemanggilan API yang tidak perlu.
    if (currentState is HistoryLoadSuccess && currentState.hasReachedMax) {
      return;
    }

    try {
      // Jika ini adalah pemanggilan pertama kali (state bukan HistoryLoadSuccess)
      if (currentState is! HistoryLoadSuccess) {
        emit(TransactionLoading(
            "Loading...")); // Tampilkan loading besar di tengah layar
        final response = await transactionService.getTransaction(
            limit: _TRANSACTION_LIMIT, page: 1);
        // Emit state sukses dengan data halaman pertama
        return emit(HistoryLoadSuccess(
          transactions: response.data,
          hasReachedMax: !response.meta.hasNextPage,
        ));
      }

      // Jika ini adalah pemanggilan berikutnya (saat user scroll ke bawah)
      // Hitung halaman berikutnya berdasarkan jumlah data yang sudah ada
      final nextPage =
          (currentState.transactions.length ~/ _TRANSACTION_LIMIT) + 1;

      final response = await transactionService.getTransaction(
          limit: _TRANSACTION_LIMIT, page: nextPage);

      // Emit state sukses baru dengan menggabungkan data lama dan data baru
      emit(HistoryLoadSuccess(
        transactions: currentState.transactions + response.data,
        hasReachedMax: !response.meta.hasNextPage,
      ));
    } catch (e) {
      emit(TransactionFailure("Failed to load history: $e"));
    }
  }
}
