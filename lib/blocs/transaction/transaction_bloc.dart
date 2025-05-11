import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:seimbangin_app/models/transaction_model.dart';
import 'package:seimbangin_app/services/transaction_service.dart';
import 'package:seimbangin_app/ui/pages/transactions_page.dart';

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
      final response = await transactionService.addTransaction(
          event.items, event.type, event.description, event.name);
      emit(TransactionSuccess("Transaction successful"));
      emit(TransactionInitial());
      return response;
    } catch (e) {
      emit(TransactionFailure("Failed to add transaction: $e"));
      emit(TransactionInitial());
    }
  }

  Future<Transaction> _getTransaction(
      GetRecentTransactionsEvent event, Emitter<TransactionState> emit) async {
    try {
      emit(TransactionLoading("Loading..."));
      final response = await transactionService.getTransaction(event.limit);
      emit(TransactionGetSuccess(response));
      return response;
    } catch (e) {
      emit(TransactionFailure("Failed to get transaction: $e"));
      throw Exception("Failed to get transaction: $e");
    }
  }
}
