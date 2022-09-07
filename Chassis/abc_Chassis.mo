within VehicleInterfaces.Chassis;

model abc_Chassis "Basic chassis model with rigid connection between all 4 wheels"
  extends VehicleInterfaces.Icons.Chassis;
  extends VehicleInterfaces.Chassis.Interfaces.TwoAxleBase;
  parameter SI.Mass vehicleMass = 1200 "Vehicle mass";
  parameter SI.Radius tyreRadius = 0.34 "Tyre rolling radius";
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
  Modelica.Blocks.Interfaces.RealOutput u annotation(
    Placement(visible = true, transformation(origin = {-152, 12}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-169, 21}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
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
  connect(longitudinalVelocity.v, u) annotation(
    Line(points = {{-20, 40}, {-152, 40}, {-152, 12}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html>
<p>
Single degree-of-freedom chassis model with mass and speed dependant drag model.
</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-160, -100}, {160, 100}})));
end abc_Chassis;
