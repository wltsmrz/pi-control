
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
  integrate: bool

proc init_controller*(rate: float, min: float, max: float): PIControl =
  var control: PIControl
  control.min = min
  control.max = max
  control.di = 1.0 / rate
  control.integrate = true
  result = control

proc set_gain*(control: var PIControl, kp: float, ki: float, kf: float) =
  control.kp = kp
  control.ki = ki
  control.kf = kf

proc clear_gain*(control: var PIControl) =
  set_gain(control, 0.0, 0.0, 0.0)

proc pause_i*(control: var PIControl) =
  control.integrate = false

proc resume_i*(control: var PIControl) =
  control.integrate = true

proc update*(control: var PIControl, sp: float, pv: float, f: float = 0.0): float =
  let error = sp - pv
  control.p = control.kp * error
  if control.integrate:
    control.i = control.i + error * control.ki * control.di
  control.f = control.kf * f
  control.r = clamp(control.p + control.i + control.f, control.min, control.max)
  result = control.r

