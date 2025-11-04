import 'package:bloc/bloc.dart';
import 'package:caterbid/core/utils/helpers/secure_storage.dart';
import 'package:caterbid/modules/Restaurant/account_settings/account_security_settings/delete_account/repository/providor_delete_account.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/repository/provider_profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'provider_delete_account_event.dart';
part 'provider_delete_account_state.dart';

class ProviderDeleteAccountBloc extends Bloc<ProviderDeleteAccountEvent, ProviderDeleteAccountState> {

  final ProvidorDeleteAccount _repository;
  final ProviderRepository _profileRepo;

  ProviderDeleteAccountBloc(this._repository, this._profileRepo) : super(ProviderDeleteAccountInitial()) {
    on<ProviderDeleteAccountEvent>((event, emit) async {
            emit(ProvidorDeleteAccountLoading());

      try {
        // 1️⃣ Delete account from server
        await _repository.deleteAccount();

        // 2️⃣ Clear auth token
        await SecureStorage.clearToken();

        // 3️⃣ Clear shared preferences / cached profile
        await _profileRepo.clearCache();

        // 4️⃣ Emit success
        emit(const ProvidorDeleteAccountSuccess(
            "Your account, requests, and bids have been deleted successfully"));
      } catch (e) {
        emit(ProvidorDeleteAccountFailure(e.toString()));
      }

    });
  }
}

