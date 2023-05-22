import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/api%20service/models/booking_models/add_bookings_model.dart';
import 'package:proj_site/api%20service/models/booking_models/booking_history_model.dart';
import 'package:proj_site/api%20service/models/shipment_models/request_data_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';


abstract class BookingState {}

class BookingInitial extends BookingState {}

class AddBookingLoading extends BookingState {}
class AddBookingSuccess extends BookingState {}
class AddBookingError extends BookingState {}

class BookingHistoryLoading extends BookingState {}
class BookingHistorySuccess extends BookingState {}
class BookingHistoryError extends BookingState {}

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  List<BookingHistoryModel>? bookingHistoryList;

  void AddBooking(String requestId, String responsiblePerson) async {
    emit(AddBookingLoading());
    AddBookingModel? response = await Repository.postAddBooking(requestId, responsiblePerson);

    if (response != null) {
      if (response.success == true) {
        emit(AddBookingSuccess());
      } else {
        //snackBar("Something Went Wrong", false);
        emit(AddBookingError());
      }
    } else {
      //snackBar("Error to Load Data", false);
      emit(AddBookingError());
    }
  }

  void BookingHistory(String requestId) async {
    emit(BookingHistoryLoading());
    bookingHistoryList = await Repository.postBookingHistory(requestId);

    if (bookingHistoryList != null) {
        emit(BookingHistorySuccess());
    } else {
      snackBar("Error to Load Data", false);
      emit(BookingHistoryError());
    }
  }

}