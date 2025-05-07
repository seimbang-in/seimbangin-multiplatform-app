import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:seimbangin_app/services/transaction_service.dart';
import 'package:seimbangin_app/ui/pages/transactions_page.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionService transactionService;
  TransactionBloc({required this.transactionService})
      : super(TransactionInitial()) {
    on<TransactionButtonPressed>(_addTransaction);
  }
  Future<void> _addTransaction(
      TransactionButtonPressed event, Emitter<TransactionState> emit) async {
    try {
      emit(TransactionLoading("Loading..."));
      final response = await transactionService.addTransaction(
        event.items,
        event.type,
        event.description,
        event.name
      );
      emit(TransactionSuccess("Transaction successful"));
      emit(TransactionInitial());
      return response;
    } catch (e) {
      emit(TransactionFailure("Failed to add transaction: $e"));
      emit(TransactionInitial());
    }
  }
}
