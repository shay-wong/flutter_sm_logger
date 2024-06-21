import 'package:sm_logger/sm_logger.dart';

int calculate() {
  return 6 * 7;
}

void main(List<String> args) {
  logger.d(calculate());
  logger.p(calculate());
}
