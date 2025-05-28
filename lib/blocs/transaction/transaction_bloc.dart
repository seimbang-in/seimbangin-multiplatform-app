import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:seimbangin_app/models/item_model.dart';
import 'package:seimbangin_app/models/transaction_model.dart';
import 'package:seimbangin_app/services/transaction_service.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

const int _TRANSACTION_LIMIT = 15;

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionService transactionService;

  TransactionBloc({required this.transactionService})
      : super(TransactionInitial()) {
    on<TransactionButtonPressed>(_addTransaction);
    on<GetRecentTransactionsEvent>(_getRecentTransaction);
    on<FetchHistoryTransactions>(_onFetchHistory);
  }

  Future<void> _addTransaction(
      TransactionButtonPressed event, Emitter<TransactionState> emit) async {
    try {
      print(
          '[TransactionBloc] _addTransaction: Event received. Emitting TransactionLoading.');
      emit(TransactionLoading("Loading..."));

      print(
          '[TransactionBloc] _addTransaction: Calling transactionService.addTransaction...');
      await transactionService.addTransaction(
          event.items, event.type, event.description, event.name);
      print(
          '[TransactionBloc] _addTransaction: transactionService.addTransaction successful. Emitting TransactionSuccess.');
      emit(TransactionSuccess("Transaction successful"));
    } catch (e) {
      print(
          '[TransactionBloc] _addTransaction: Error caught: $e. Emitting TransactionFailure.');
      emit(TransactionFailure("Failed to add transaction: $e"));
    }
  }

  Future<void> _getRecentTransaction(
      GetRecentTransactionsEvent event, Emitter<TransactionState> emit) async {
    try {
      // print('[TransactionBloc] _getRecentTransaction: Emitting TransactionLoading.');
      emit(TransactionLoading("Loading..."));
      final response =
          await transactionService.getTransaction(limit: event.limit, page: 1);
      // print('[TransactionBloc] _getRecentTransaction: Data received. Emitting TransactionGetSuccess.');
      emit(TransactionGetSuccess(response));
    } catch (e) {
      // print('[TransactionBloc] _getRecentTransaction: Error caught: $e. Emitting TransactionFailure.');
      emit(TransactionFailure("Failed to get transaction: $e"));
    }
  }

  Future<void> _onFetchHistory(
      FetchHistoryTransactions event, Emitter<TransactionState> emit) async {
    final currentState = state;

    if (currentState is HistoryLoadSuccess && currentState.hasReachedMax) {
      return;
    }

    try {
      if (currentState is! HistoryLoadSuccess) {
        // print('[TransactionBloc] _onFetchHistory: Initial fetch. Emitting TransactionLoading.');
        emit(TransactionLoading("Loading..."));
        final response = await transactionService.getTransaction(
            limit: _TRANSACTION_LIMIT, page: 1);
        // print('[TransactionBloc] _onFetchHistory: Initial data received. Emitting HistoryLoadSuccess.');
        return emit(HistoryLoadSuccess(
          transactions: response.data,
          hasReachedMax: !response.meta.hasNextPage,
        ));
      }

      final nextPage =
          (currentState.transactions.length ~/ _TRANSACTION_LIMIT) + 1;
      // print('[TransactionBloc] _onFetchHistory: Fetching next page ($nextPage).');

      final response = await transactionService.getTransaction(
          limit: _TRANSACTION_LIMIT, page: nextPage);
      // print('[TransactionBloc] _onFetchHistory: Next page data received. Emitting HistoryLoadSuccess.');

      emit(HistoryLoadSuccess(
        transactions: currentState.transactions + response.data,
        hasReachedMax: !response.meta.hasNextPage,
      ));
    } catch (e) {
      // print('[TransactionBloc] _onFetchHistory: Error caught: $e. Emitting TransactionFailure.');
      emit(TransactionFailure("Failed to load history: $e"));
    }
  }
}
