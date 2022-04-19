import 'package:strech_timer/models/queue_elements/end_element.dart';
import 'package:strech_timer/models/queue_element.dart';

class Queue{
  QueueElement _root = EndElement();

  Queue();

  QueueIterator get iterator => QueueIterator(_root);

  void add(QueueElement item){
    if(!_root.add(item)){
      _root = item;
    }
  }
}

class QueueIterator extends Iterator<QueueElement>{
  QueueElement _current;

  @override
  QueueElement get current => _current;

  QueueIterator(this._current);

  @override
  bool moveNext(){
    _current = _current.next;
    return _current is EndElement;
  }
}