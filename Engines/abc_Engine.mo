within VehicleInterfaces.Engines;

model abc_Engine "Mapped engine model with torque look table of accelerator pedal position and engine speed"
  extends VehicleInterfaces.Icons.Engine;
  extends Interfaces.Base(includeMount = world.driveTrainMechanics3D, includeAccessoriesBearing = world.driveTrainMechanics3D);
  parameter SI.AngularVelocity engineSpeed_start(displayUnit = "r/min") = 104.7197551196598 "Initial engine speed";
  parameter SI.Inertia flywheelInertia = 0.08 "Flywheel inertia";
  parameter Modelica.Mechanics.MultiBody.Types.Axis axisOfRotation = {1, 0, 0} "Axis of rotation of engine resolved in engineMount";
  Modelica.Mechanics.MultiBody.Parts.Rotor1D flywheel(J = flywheelInertia, a(fixed = false), n = axisOfRotation, phi(displayUnit = "rad", fixed = false), w(fixed = true, start = engineSpeed_start)) annotation(
    Placement(visible = true, transformation(extent = {{6, -10}, {26, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.Torque engine(useSupport = true) annotation(
    Placement(visible = true, transformation(extent = {{-24, -30}, {-4, -10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor engineSpeed annotation(
    Placement(visible = true, transformation(origin = {26, 60}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor engineTorque annotation(
    Placement(visible = true, transformation(extent = {{40, -10}, {60, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor enginePower annotation(
    Placement(visible = true, transformation(extent = {{68, -10}, {88, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D(n = axisOfRotation) annotation(
    Placement(visible = true, transformation(extent = {{-24, -52}, {-4, -32}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable2Ds exhause(fileName = "D:/Program Files/OpenModelica1.16.2-64bit/lib/omlibrary/VehicleInterfaces 2.0.0/Engines/exhause.txt", tableName = "exhause", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-44, 32}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds power(fileName = "D:/Program Files/OpenModelica1.16.2-64bit/lib/omlibrary/VehicleInterfaces 2.0.0/Engines/engine.txt", tableName = "power", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-32, 46}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {-6, 42}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable2Ds torque(fileName = "D:/Program Files/OpenModelica1.16.2-64bit/lib/omlibrary/VehicleInterfaces 2.0.0/Engines/engine.txt", tableName = "torque", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-65, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 30 / 3.1415926) annotation(
    Placement(visible = true, transformation(origin = {-14, 70}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
  Modelica.Blocks.Nonlinear.Limiter enginespeed_actual(uMax = 10000, uMin = 800) annotation(
    Placement(visible = true, transformation(origin = {-36, 70}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
protected
  VehicleInterfaces.Interfaces.EngineBus engineBus annotation(
    Placement(visible = true, transformation(extent = {{-90, 50}, {-70, 70}}, rotation = 0), iconTransformation(extent = {{-70, 50}, {-50, 70}}, rotation = 0)));
  VehicleInterfaces.Interfaces.DriverBus driverBus annotation(
    Placement(visible = true, transformation(extent = {{-92, 24}, {-72, 44}}, rotation = 0), iconTransformation(extent = {{-90, 30}, {-70, 50}}, rotation = 0)));
  outer Modelica.Mechanics.MultiBody.World world;
equation
  connect(engine.flange, flywheel.flange_a) annotation(
    Line(points = {{-4, -20}, {-4, 0}, {6, 0}}));
  connect(flywheel.flange_b, engineTorque.flange_a) annotation(
    Line(points = {{26, 0}, {40, 0}}));
  connect(engineTorque.flange_b, enginePower.flange_a) annotation(
    Line(points = {{60, 0}, {68, 0}}));
  connect(controlBus.engineBus, engineBus) annotation(
    Line(points = {{-100, 60}, {-80, 60}}, color = {255, 204, 51}, thickness = 0.5));
  connect(controlBus.driverBus, driverBus) annotation(
    Line(points = {{-100, 60}, {-82, 60}, {-82, 34}}, color = {255, 204, 51}, thickness = 0.5));
  connect(flywheel.frame_a, engineMount) annotation(
    Line(points = {{16, -10}, {16, -61}, {0, -61}, {0, -100}}, color = {95, 95, 95}, thickness = 0.5));
  connect(mounting1D.flange_b, engine.support) annotation(
    Line(points = {{-4, -42}, {-4, -36}, {-14, -36}, {-14, -30}}));
  connect(mounting1D.frame_a, engineMount) annotation(
    Line(points = {{-14, -52}, {-14, -60}, {0, -60}, {0, -100}}, color = {95, 95, 95}, thickness = 0.5));
  connect(enginePower.flange_b, transmissionFlange.flange) annotation(
    Line(points = {{88, 0}, {100, 0}}));
  connect(flywheel.flange_a, accessoryFlange.flange) annotation(
    Line(points = {{6, 0}, {-100, 0}}));
  connect(accessoryFlange.bearingFrame, mounting1D.frame_a) annotation(
    Line(points = {{-100, 0}, {-100, -60}, {-14, -60}, {-14, -52}}, color = {95, 95, 95}, thickness = 0.5));
  connect(engineSpeed.w, engineBus.speed) annotation(
    Line(points = {{15, 60}, {-80, 60}}, color = {0, 0, 127}));
  connect(exhause.u1, driverBus.acceleratorPedalPosition) annotation(
    Line(points = {{-51, 36}, {-64.5, 36}, {-64.5, 34}, {-82, 34}}, color = {0, 0, 127}));
  connect(power.y[1], product.u1) annotation(
    Line(points = {{-26, 46}, {-13, 46}}, color = {0, 0, 127}));
  connect(exhause.y, product.u2) annotation(
    Line(points = {{-37, 32}, {-13, 32}, {-13, 38}}, color = {0, 0, 127}));
  connect(engineSpeed.flange, flywheel.flange_b) annotation(
    Line(points = {{36, 60}, {26, 60}, {26, 0}}));
  connect(gain.u, engineSpeed.w) annotation(
    Line(points = {{-6, 70}, {16, 70}, {16, 60}}, color = {0, 0, 127}));
  connect(torque.u1, driverBus.acceleratorPedalPosition) annotation(
    Line(points = {{-73, -11}, {-82, -11}, {-82, 34}}, color = {0, 0, 127}));
  connect(enginespeed_actual.u, gain.y) annotation(
    Line(points = {{-32, 70}, {-20, 70}}, color = {0, 0, 127}));
  connect(enginespeed_actual.y, power.u) annotation(
    Line(points = {{-40, 70}, {-40, 46}}, color = {0, 0, 127}));
  connect(enginespeed_actual.y, exhause.u2) annotation(
    Line(points = {{-40, 70}, {-52, 70}, {-52, 28}}, color = {0, 0, 127}));
  connect(enginespeed_actual.y, torque.u2) annotation(
    Line(points = {{-40, 70}, {-73, 70}, {-73, -19}}, color = {0, 0, 127}));
  connect(torque.y, engine.tau) annotation(
    Line(points = {{-57, -15}, {-26, -15}, {-26, -20}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html>
<p>
A mapped engine model with flywheel and where the torque output is
 looked table of the accelerator pedal position and engine speed. This engine model uses
a&nbsp;drive-by-wire accelerator, i.e. the accelerator pedal position
is read from the control bus.
</p>
</html>"),
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
end abc_Engine;
