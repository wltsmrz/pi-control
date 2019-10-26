type PIControl* = object
  kp: float # proportional gain
  ki: float # integral gain
  kf: float # feedforward gain
  p: float  # proportional
  i: float  # integral
  f: float  # feedforward
  r: float  # control
  di: float # integral rate
  min: float
  max: float

proc init_controller*(rate: float, min: float, max: float): PIControl =
  var control: PIControl
  control.min = min
  control.max = max
  control.di = 1.0 / rate
  result = control

proc set_gain*(control: var PIControl, kp: float, ki: float, kf: float) =
  control.kp = kp
  control.ki = ki
  control.kf = kf

proc clear_gain*(control: var PIControl) =
  control.kp = 0.0
  control.ki = 0.0
  control.kf = 0.0

proc update*(control: var PIControl, s: float, m: float, f: float = 0.0): float =
  let error = s - m
  control.p = control.kp * error
  control.i = control.i + error * control.ki * control.di
  control.f = control.kf * f
  control.r = clamp(control.p + control.i + control.f, control.min, control.max)
  result = control.r

