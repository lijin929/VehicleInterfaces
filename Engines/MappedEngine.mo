within VehicleInterfaces.Engines;

model MappedEngine "Mapped engine model with torque look table of accelerator pedal position and engine speed"
  extends VehicleInterfaces.Icons.Engine;
  extends Interfaces.Base(includeMount = world.driveTrainMechanics3D, includeAccessoriesBearing = world.driveTrainMechanics3D);
  parameter SI.AngularVelocity engineSpeed_start(displayUnit = "r/min") = 104.7197551196598 "Initial engine speed";
  parameter String FileName = "D:/Program Files/OpenModelica1.16.2-64bit/lib/omlibrary/VehicleInterfaces 2.0.0/Examples/MappedEngine.txt";
  parameter SI.Inertia flywheelInertia = 0.08 "Flywheel inertia";
  parameter Modelica.Mechanics.MultiBody.Types.Axis axisOfRotation = {1, 0, 0} "Axis of rotation of engine resolved in engineMount";
  Modelica.Mechanics.MultiBody.Parts.Rotor1D flywheel(J = flywheelInertia, n = axisOfRotation, a(fixed = false), phi(fixed = false), w(fixed = true, start = engineSpeed_start)) annotation(
    Placement(visible = true, transformation(extent = {{12, -10}, {32, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.Torque engine(useSupport = true) annotation(
    Placement(visible = true, transformation(extent = {{-14, -30}, {6, -10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor engineSpeed annotation(
    Placement(visible = true, transformation(origin = {26, 60}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor engineTorque annotation(
    Placement(visible = true, transformation(extent = {{40, -10}, {60, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor enginePower annotation(
    Placement(visible = true, transformation(extent = {{68, -10}, {88, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D(n = axisOfRotation) annotation(
    Placement(visible = true, transformation(extent = {{-24, -52}, {-4, -32}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable2Ds EngineMap(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, fileName = FileName, tableName = "MappedEngine", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-42, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  VehicleInterfaces.Interfaces.EngineBus engineBus annotation(
    Placement(visible = true, transformation(extent = {{-90, 50}, {-70, 70}}, rotation = 0), iconTransformation(extent = {{-70, 50}, {-50, 70}}, rotation = 0)));
  VehicleInterfaces.Interfaces.DriverBus driverBus annotation(
    Placement(visible = true, transformation(extent = {{-100, 30}, {-80, 50}}, rotation = 0), iconTransformation(extent = {{-90, 30}, {-70, 50}}, rotation = 0)));
  outer Modelica.Mechanics.MultiBody.World world;
equation
  connect(engine.flange, flywheel.flange_a) annotation(
    Line(points = {{6, -20}, {6, 0}, {12, 0}}));
  connect(flywheel.flange_b, engineSpeed.flange) annotation(
    Line(points = {{32, 0}, {36, 0}, {36, 60}}));
  connect(flywheel.flange_b, engineTorque.flange_a) annotation(
    Line(points = {{32, 0}, {40, 0}}));
  connect(engineTorque.flange_b, enginePower.flange_a) annotation(
    Line(points = {{60, 0}, {68, 0}}));
  connect(controlBus.engineBus, engineBus) annotation(
    Line(points = {{-100, 60}, {-80, 60}}, color = {255, 204, 51}, thickness = 0.5));
  connect(controlBus.driverBus, driverBus) annotation(
    Line(points = {{-100, 60}, {-90, 60}, {-90, 40}}, color = {255, 204, 51}, thickness = 0.5));
  connect(flywheel.frame_a, engineMount) annotation(
    Line(points = {{22, -10}, {22, -59}, {0, -59}, {0, -100}}, color = {95, 95, 95}, thickness = 0.5));
  connect(mounting1D.flange_b, engine.support) annotation(
    Line(points = {{-4, -42}, {-4, -30}}));
  connect(mounting1D.frame_a, engineMount) annotation(
    Line(points = {{-14, -52}, {-14, -60}, {0, -60}, {0, -100}}, color = {95, 95, 95}, thickness = 0.5));
  connect(enginePower.flange_b, transmissionFlange.flange) annotation(
    Line(points = {{88, 0}, {100, 0}}));
  connect(flywheel.flange_a, accessoryFlange.flange) annotation(
    Line(points = {{12, 0}, {-100, 0}}));
  connect(accessoryFlange.bearingFrame, mounting1D.frame_a) annotation(
    Line(points = {{-100, 0}, {-100, -60}, {-14, -60}, {-14, -52}}, color = {95, 95, 95}, thickness = 0.5));
  connect(engineSpeed.w, engineBus.speed) annotation(
    Line(points = {{15, 60}, {-80, 60}}, color = {0, 0, 127}));
  connect(EngineMap.y, engine.tau) annotation(
    Line(points = {{-31, -20}, {-16, -20}}, color = {0, 0, 127}));
  connect(EngineMap.u1, engineSpeed.w) annotation(
    Line(points = {{-54, -14}, {-64, -14}, {-64, 60}, {16, 60}}, color = {0, 0, 127}));
  connect(EngineMap.u2, driverBus.acceleratorPedalPosition) annotation(
    Line(points = {{-54, -26}, {-90, -26}, {-90, 40}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html>
<p>
A mapped engine model with flywheel and where the torque output is
 looked table of the accelerator pedal position and engine speed. This engine model uses
a&nbsp;drive-by-wire accelerator, i.e. the accelerator pedal position
is read from the control bus.
</p>
</html>"));
end MappedEngine;
