import 'package:flutter/material.dart';

class StateManager {

  static final StateManager _instance = StateManager._internal();

  factory StateManager() {
    return _instance;
  }

  StateManager._internal();

  final _state = <String, dynamic>{};
  final _callback = <String, List<VoidCallback>>{};

  bool addState(String key, dynamic value){
    if(_state.containsKey(key)){
      return false;
    }
    _state[key] = value;
    _callback[key] = <VoidCallback>[];
    return true;
  }

  bool addCallback(String key, VoidCallback callback){
    if(_callback.containsKey(key)){
      _callback[key]!.add(callback);
      return true;
    }
    return false;
  }

  dynamic getState(String key){
    if(!_state.containsKey(key)){
      return null;
    }
    _callback[key]?.forEach((e) {e();});
    return _state[key];
  }
}