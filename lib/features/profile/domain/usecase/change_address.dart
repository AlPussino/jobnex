import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/profile/domain/repository/user_repository.dart';

class ChangeAddress implements FutureUseCase<Null, ChangeAddressParams> {
  final UserRepository userRepository;
  const ChangeAddress(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(ChangeAddressParams params) async {
    return await userRepository.changeAddress(
      address: params.address,
    );
  }
}

class ChangeAddressParams {
  final String address;
  const ChangeAddressParams({
    required this.address,
  });
}
