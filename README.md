### PI controller with feedforward component

* `init_controller(rate: float, min: float, max: float): PIControl`
* `set_gain(control: var PIControl, kp: float, ki: float, kf: float): void`
* `clear_gain(control: var PIControl): void`
* `pause_i(control: var PIControl): void`
* `resume_i(control: var PIControl): void`
* `update(control: var PIControl, sp: float, pv: float, f: float = 0.0): float`

![](./graph.png)
