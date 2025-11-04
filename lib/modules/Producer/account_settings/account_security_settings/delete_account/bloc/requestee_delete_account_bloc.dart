import 'package:bloc/bloc.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/delete_account/repository/delete_account_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/repository/requestee_profile_repository.dart';
import 'package:caterbid/core/utils/helpers/secure_storage.dart';

part 'requestee_delete_account_event.dart';
part 'requestee_delete_account_state.dart';

class RequesteeDeleteAccountBloc extends Bloc<RequesteeDeleteAccountEvent, RequesteeDeleteAccountState> {
  final RequesteeDeleteAccountRepository _repository;
  final RequesteeRepository _profileRepo;

  RequesteeDeleteAccountBloc(this._repository, this._profileRepo) 
      : super(RequesteeDeleteAccountInitial()) {
    on<RequesteeDeleteAccountRequested>((event, emit) async {
      emit(RequesteeDeleteAccountLoading());
      try {
        // 1️⃣ Delete account from server
        await _repository.deleteAccount();

        // 2️⃣ Clear auth token
        await SecureStorage.clearToken();

        // 3️⃣ Clear shared preferences / cached profile
        await _profileRepo.clearCache();

        // 4️⃣ Emit success
        emit(const RequesteeDeleteAccountSuccess(
            "Your account, requests, and bids have been deleted successfully"));
      } catch (e) {
        emit(RequesteeDeleteAccountFailure(e.toString()));
      }
    });
  }
}
