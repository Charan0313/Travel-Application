import 'package:app/app/models/travel.dart';
import 'package:app/app/modules/bookings/views/booking_view.dart';
import 'package:app/app/modules/home/bindings/home_binding.dart';
import 'package:app/app/modules/home/views/home_view.dart';
import 'package:app/app/modules/search/bindings/search_binding.dart';
import 'package:app/app/modules/search/views/search_result_view.dart';
import 'package:app/app/modules/seat_selection/bindings/boarding_point_binding.dart';
import 'package:app/app/modules/seat_selection/bindings/seat_selection_binding.dart';
import 'package:app/app/modules/seat_selection/views/boarding_point_selection_view.dart';
import 'package:app/app/modules/seat_selection/views/seat_selection_view.dart';
import 'package:app/app/modules/stop_selector/bindings/stop_selector_binding.dart';
import 'package:app/app/modules/stop_selector/views/stop_selector_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const HOME = Routes.HOME;
  static const SEARCHRESULT = Routes.SEARCHRESULT;
  static const STOPSELECTOR = Routes.STOPSELECTOR;
  static const SEATSELECTOR = Routes.SEATSELECTOR;
  static const BOARDINGPOINTSELECTOR = Routes.BOARDINGPOINTSELECTOR;
  static const BOOKING = Routes.BOOKING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(name: _Paths.BOOKING, page: ()=> const BookingView()),
    GetPage(
      name: _Paths.SEARCHRESULT,
      page: () => const SearchResultView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.STOPSELECTOR,
      page: () => const StopSelectorView(),
      binding: StopSelectorBinding(),
    ),
    GetPage(
      arguments: Travel(),
      name: _Paths.SEATSELECTOR,
      page: () => SeatSelectionView(),
      binding: SeatSelectionBinding(),
    ),
    GetPage(
      arguments: Travel(),
      name: _Paths.BOARDINGPOINTSELECTOR,
      page: () => const BoardingPointSelectorView(),
      binding: BoardingPointBinding(),
    ),
  ];
}
