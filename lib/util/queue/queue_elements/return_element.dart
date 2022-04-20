import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/util/queue/queue_elements/end_element.dart';

class ReturnElement extends EndElement{
  final QueueElement _returnElement;

  @override
  QueueElement get next => _returnElement;

  ReturnElement(this._returnElement);
}