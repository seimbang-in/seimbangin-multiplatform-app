import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:seimbangin_app/models/item_model.dart';
import 'package:seimbangin_app/models/transaction_model.dart';
import 'package:seimbangin_app/services/transaction_service.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionService transactionService;
  TransactionBloc({required this.transactionService})
      : super(TransactionInitial()) {
    on<TransactionButtonPressed>(_addTransaction);
    on<GetRecentTransactionsEvent>(_getTransaction);
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

  Future<void> _getTransaction(
      GetRecentTransactionsEvent event, Emitter<TransactionState> emit) async {
    try {
      emit(TransactionLoading("Loading..."));
      // --- LOGGING POINT 3 ---
      print(
          '[TransactionBloc] Memanggil transactionService.getTransaction()...');
      final response = await transactionService.getTransaction(event.limit);
      print(
          '[TransactionBloc] Selesai memanggil transactionService.getTransaction().');
      // ------------------------

      emit(TransactionGetSuccess(response));
      print('[TransactionBloc] Berhasil emit TransactionGetSuccess.');
    } catch (e) {
      print('[TransactionBloc] Terjadi error saat get transaction: $e');
      emit(TransactionFailure("Failed to get transaction: $e"));
      // JANGAN throw Exception di sini, biarkan BLoC menangani error dengan state
    }
  }
}
