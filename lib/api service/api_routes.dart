
class ApiRoutes{
  ApiRoutes._();

  static const String _BASE_URL = 'https://dev.projsite.com/delivery_management_api/public';  // live
  static const String BASE_URL = '$_BASE_URL/api';
  static const String Image_URL = '$_BASE_URL/rental_images/';
  static const String ShipmentImage_URL = 'https://dev.projsite.com/patterns/';

  static const String postSignIn = '/validate_user_login';
  static const String postProfileDetails = '/get_user';
  static const String postEditProfile = '/edit_profile';
  static const String postForgotPassword = '/forgot_password';
  static const String postUpdatePassword = '/update_password';
  static const String updateOrganisation = '/update_organization_id';

  /// Unloading Zone
  static const String createUnloadingZone = '/create_unloading_zone';
  static const String updateUnloadingZone = '/update_unloading_zone';
  static const String unloadingZoneNameExists = '/unloading_zone_name_exists';
  static const String unloadingZoneDetails = '/unloading_zone_details';
  static const String deleteUnloadingZone = '/delete_zone';

  /// APdPlan
  static const String postApdPlan = '/apd_plan';
  static const String deleteApdPlan = '/delete_plan';
  static const String postUploadApdPlan = '/upload_apd_plan';

  /// Rental List
  static const String postRental = '/rentals';
  static const String postDeleteRental = '/delete_rental';
  static const String postUpdateRental = '/update_rental_status';
  static const String postAddRental = '/add_rental';

  /// Logistic List
  static const String postTerminalList = '/terminals/list';
  static const String postAddLogistics = '/add_logistic';
  static const String postLogisticList = '/logistics';
  static const String postLogisticDetails = '/logistic_data';
  static const String postNotTransportCheckouts = '/not_transported_checkouts';
  static const String postOrganizations = '/companies';
  static const String postUserSubProjectList = '/user_sub_projects';
  static const String postEditLogistic = '/update_logistic_info';
  static const String postDeleteLogistic = '/delete_logistic';
  static const String postCheckoutLogistic = '/add_check_out';
  static const String postCreateShipmentSupplier = '/create-shipment-supplier';
  static const String postShipmentSupplierList = '/get-shipment-supplier';
  static const String postLogisticRequestData='/checkout_request_data';

  /// Transport Request (Terminal from)
  static const String postAddTransportRequest='/add_bulk_checkout_transport_request';
  static const String postGetTransportRequest='/checkout_request_data';
  static const String postUpdateTransportRequest='/update_checkout_request';
  static const String postUpdateTransportRequestStatus='/update_checkout_status';
  static const String postCloseTransportRequest='/close_checkout_request';

  /// Profile Setting
  static const String postNotification = '/user-current-account';
  static const String postEditNotification = '/update-user-current-account';

  /// shipment
  static const String postAddShipmentRequest = '/add_request';
  static const String postUpdateShipmentRequest = '/update_request';
  static const String postCloseShipmentRequest = '/close_request';
  static const String postRequestData = '/request_data';
  static const String postEventList = '/requests';

  ///dashboard
  static const String postMonthlyShipment = '/monthly_shipments';
  static const String postPendingShipmentList = '/get_requests_for_mobile';

  /// terminal
  static const String postAddTerminal = '/add_terminal_request';
  static const String postUpdateTerminal = '/update_terminal_request';
  static const String postCloseTerminal = '/close_terminal_request';
  //static const String postTerminalRequestData = '/request_data';

  /// request status
  static const String postUpdateApprovalStatus = '/update_status';
  static const String postUpdateTransportStatus = '/update_transport_status';
  static const String postUpdateTerminalStatus = '/update_terminal_status';

  /// booking form notification

  static const String postBookingFormNotification = '/get_project_by_id';
  static const String postSaveBookingFormNotification = '/update-project-settings';

  /// project list

  static const String postProjectList = '/get_users_projects_list';
  static const String postProjectDetails = '/fetch_project_details';

  /// enviromental dropdown

  static const String postEuroclass = '/get-euroclass';
  static const String postVehicle = '/get-vehicle';
  static const String postFuel = '/get-fuel';

  /// calender dropdown
  static const String postResourcesList= '/resource_list';
  static const String postZoneList= '/unloading_zone_list';
  static const String postUser= '/get_users';
  static const String postTerminalsItems= '/terminals/items';
  static const String postFilterStatus= '/get-filter-by-status';
  static const String postFilterTransportType= '/get-filter-by-transport-type';

  /// packageInformation
  static const String postPackageInfo= '/get-package-type';

  ///bookings
  static const String postAddBooking= '/add_booking';
  static const String postBookingHistory= '/booking_history';

  ///waste disposal
  static const String postWasteContainerList= '/fetch_containers';
  static const String postWasteFractionList= '/fetch_fractions';
  static const String postBookWasteDisposal= '/save_waste_disposal';

  ///subProjectList
  static const String subProjectList = '/sub_project_list';
  static const String subProjectUserList = '/sub_project_users';
  static const String removeUser = '/unassign_sub_project_user';
  static const String userListDropDown = '/get_users';
  static const String assignUser = '/assign_sub_project_user';
  static const String updateSubProject = '/update_sub_project';
  static const String createSubProject = '/create_sub_project';

  /// wast statistic
  static const String wasteContainerDropDown = '/fetch_containers';
  static const String wasteFractionsDropDown = '/fetch_fractions';
  static const String addToWasteList = '/generate_waste_list';
  static const String saveToWasteList = '/save_waste_list';
  static const String containerDetails = '/fetch_container';
  static const String fractionDetails = '/fetch_fraction';
}
