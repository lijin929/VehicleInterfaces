within VehicleInterfaces.Chassis;

model abc_Chassis01 "Basic chassis model with rigid connection between all 4 wheels"
  extends VehicleInterfaces.Icons.Chassis;
  extends VehicleInterfaces.Chassis.Interfaces.TwoAxleBase;
  parameter SI.Mass vehicleMass = 1200 "Vehicle mass";
  parameter SI.Radius tyreRadius = 0.34 "Tyre rolling radius";
  parameter Real resistance_A = 4.8 "Windward area of vehicles";
  parameter Real resistance_CD = 0.6 "coefficient of air resistance";
  parameter Real resistance_roll = 0.012 "rolling resistance coefficient";
  parameter SI.TranslationalDampingConstant drag = 1 "Drag force (force = drag*vehicle_speed)";
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel tyres(radius = tyreRadius, useSupportT = true, useSupportR = true) annotation(
    Placement(transformation(extent = {{-40, -10}, {-20, 10}})));
  Modelica.Mechanics.Translational.Components.Mass body(m = vehicleMass, s(stateSelect = StateSelect.always, start = 0, fixed = true)) annotation(
    Placement(transformation(extent = {{0, -10}, {20, 10}})));
  Modelica.Mechanics.Translational.Components.Damper dragForces(d = drag) annotation(
    Placement(transformation(extent = {{40, -10}, {60, 10}})));
  Modelica.Mechanics.Translational.Components.Fixed ground annotation(
    Placement(transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor longitudinalVelocity annotation(
    Placement(visible = true, transformation(extent = {{1, 30}, {-19, 50}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(
    Placement(transformation(extent = {{-50, -26}, {-30, -6}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation(
    Placement(visible = true, transformation(origin = {-70, -16}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant rolling_resistance(k = 5100 * 9.8 * resistance_roll) annotation(
    Placement(visible = true, transformation(origin = {-153, -22}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant air_resist(k = resistance_A * resistance_CD / 21.15) annotation(
    Placement(visible = true, transformation(origin = {-152, 5}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {-120, 26}, extent = {{5, 5}, {-5, -5}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 3.6) annotation(
    Placement(visible = true, transformation(origin = {-67.5, 27.5}, extent = {{5.5, -5.5}, {-5.5, 5.5}}, rotation = 0)));
  Modelica.Blocks.Math.Product air_resistance annotation(
    Placement(visible = true, transformation(origin = {-135, 8}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add resistance(k1 = -1, k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {-114, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput u annotation(
    Placement(visible = true, transformation(origin = {59, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-167, 1}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = 0.452)  annotation(
    Placement(visible = true, transformation(origin = {-93, -17}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
protected
  VehicleInterfaces.Interfaces.ChassisBus chassisBus annotation(
    Placement(transformation(extent = {{-130, 30}, {-110, 50}})));
equation
  connect(tyres.flangeT, body.flange_a) annotation(
    Line(points = {{-20, 0}, {0, 0}}, color = {0, 127, 0}));
  connect(body.flange_b, dragForces.flange_a) annotation(
    Line(points = {{20, 0}, {40, 0}}, color = {0, 127, 0}));
  connect(dragForces.flange_b, ground.flange) annotation(
    Line(points = {{60, 0}, {80, 0}}, color = {0, 127, 0}));
  connect(body.flange_b, longitudinalVelocity.flange) annotation(
    Line(points = {{20, 0}, {20, 40}, {1, 40}}, color = {0, 127, 0}));
  connect(tyres.flangeR, wheelHub_1.flange) annotation(
    Line(points = {{-40, 0}, {-90, 0}, {-90, -100}}));
  connect(tyres.flangeR, wheelHub_2.flange) annotation(
    Line(points = {{-40, 0}, {-90, 0}, {-90, 100}}));
  connect(tyres.flangeR, wheelHub_3.flange) annotation(
    Line(points = {{-40, 0}, {-90, 0}, {-90, -80}, {90, -80}, {90, -100}}));
  connect(tyres.flangeR, wheelHub_4.flange) annotation(
    Line(points = {{-40, 0}, {-90, 0}, {-90, 80}, {90, 80}, {90, 100}}));
  connect(controlBus.chassisBus, chassisBus) annotation(
    Line(points = {{-158, 60}, {-120, 60}, {-120, 40}}, color = {255, 204, 51}, thickness = 0.5));
  connect(ground.flange, tyres.supportT) annotation(
    Line(points = {{80, 0}, {80, -20}, {-20, -20}, {-20, -10}}, color = {0, 127, 0}));
  connect(fixed.flange, tyres.supportR) annotation(
    Line(points = {{-40, -16}, {-40, -10}}));
  connect(chassisBus.longitudinalVelocity, longitudinalVelocity.v) annotation(
    Line(points = {{-120, 40}, {-20, 40}}, color = {0, 0, 127}));
  connect(gain.u, longitudinalVelocity.v) annotation(
    Line(points = {{-61, 28}, {-20, 28}, {-20, 40}}, color = {0, 0, 127}));
  connect(product.u2, gain.y) annotation(
    Line(points = {{-114, 29}, {-66, 29}, {-66, 28}, {-74, 28}}, color = {0, 0, 127}));
  connect(product.u1, gain.y) annotation(
    Line(points = {{-114, 23}, {-74, 23}, {-74, 28}}, color = {0, 0, 127}));
  connect(air_resist.y, air_resistance.u2) annotation(
    Line(points = {{-146.5, 5}, {-141, 5}}, color = {0, 0, 127}));
  connect(product.y, air_resistance.u1) annotation(
    Line(points = {{-125.5, 26}, {-141, 26}, {-141, 11}}, color = {0, 0, 127}));
  connect(resistance.u1, air_resistance.y) annotation(
    Line(points = {{-126, -10}, {-129, -10}, {-129, 8}}, color = {0, 0, 127}));
  connect(rolling_resistance.y, resistance.u2) annotation(
    Line(points = {{-147.5, -22}, {-126, -22}}, color = {0, 0, 127}));
  connect(torque.flange, tyres.flangeR) annotation(
    Line(points = {{-63, -16}, {-40, -16}, {-40, 0}}));
  connect(u, longitudinalVelocity.v) annotation(
    Line(points = {{59, 60}, {-31, 60}, {-31, 40}, {-20, 40}}, color = {0, 0, 127}));
  connect(gain1.u, resistance.y) annotation(
    Line(points = {{-99, -17}, {-103, -17}, {-103, -16}}, color = {0, 0, 127}));
  connect(gain1.y, torque.tau) annotation(
    Line(points = {{-87, -17}, {-78, -17}, {-78, -16}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html>
<p>
Single degree-of-freedom chassis model with mass and speed dependant drag model.
</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-200, -100}, {160, 100}})));
end abc_Chassis01;
