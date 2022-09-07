within VehicleInterfaces.Transmissions;

model abc_AT "Mapped gear ratio, automatic transmission, no torque converter"
  extends VehicleInterfaces.Icons.Transmission;
  extends Interfaces.BaseAutomaticTransmission(includeMount = world.driveTrainMechanics3D);
  parameter Real ratioTable[:, 3] = [-1, 5.1, 0.9; 0, 0, 0; 1, 3.51, 0.92; 2, 1.9, 0.92; 3, 1.44, 0.92; 4, 1.0, 1; 5, 0.74, 0.92; 6, 0.64, 0.92] "[gear, ratio, efficiency;]";
  parameter Modelica.Units.SI.Inertia inputInertia = 0.015;
  parameter Modelica.Units.SI.Inertia outputInertia = 0.015;
  Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D annotation(
    Placement(visible = true, transformation(extent = {{-50, -60}, {-30, -40}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor outputSpeed annotation(
    Placement(visible = true, transformation(origin = {6, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Rotational.Components.Inertia inputShaft(J = inputInertia) annotation(
    Placement(visible = true, transformation(origin = {-66, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia outputShaft(J = outputInertia) annotation(
    Placement(visible = true, transformation(origin = {6, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor outputTorque annotation(
    Placement(visible = true, transformation(origin = {38, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor outputPower annotation(
    Placement(visible = true, transformation(origin = {72, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds RatioTable(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = ratioTable) annotation(
    Placement(visible = true, transformation(origin = {-30, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VehicleInterfaces.Transmissions.IdealGear idealGear annotation(
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput gears annotation(
    Placement(visible = true, transformation(origin = {-83, 45}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {4, 96}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
protected
  VehicleInterfaces.Interfaces.TransmissionBus transmissionBus annotation(
    Placement(visible = true, transformation(extent = {{-66, 78}, {-46, 98}}, rotation = 0), iconTransformation(extent = {{-30, 50}, {-10, 70}}, rotation = 0)));
  outer Modelica.Mechanics.MultiBody.World world;
equation
  connect(mounting1D.frame_a, transmissionMount) annotation(
    Line(points = {{-40, -60}, {-40, -80}, {0, -80}, {0, -100}}, color = {95, 95, 95}, thickness = 0.5));
  connect(controlBus.transmissionBus, transmissionBus) annotation(
    Line(points = {{-100, 60}, {-91.9, 60}, {-91.9, 88}, {-56, 88}}, color = {255, 204, 51}, thickness = 0.5));
  connect(outputSpeed.w, transmissionBus.outputSpeed) annotation(
    Line(points = {{-5, 88}, {-56, 88}}, color = {0, 0, 127}));
  connect(engineFlange.flange, inputShaft.flange_a) annotation(
    Line(points = {{-100, 0}, {-76, 0}}));
  connect(outputPower.flange_a, outputTorque.flange_b) annotation(
    Line(points = {{62, 0}, {48, 0}}));
  connect(outputPower.flange_b, drivelineFlange.flange) annotation(
    Line(points = {{82, 0}, {100, 0}}));
  connect(outputShaft.flange_b, outputTorque.flange_a) annotation(
    Line(points = {{16, 0}, {28, 0}}));
  connect(outputShaft.flange_b, outputSpeed.flange) annotation(
    Line(points = {{16, 0}, {16, 88}}));
  connect(inputShaft.flange_b, idealGear.flange_a) annotation(
    Line(points = {{-56, 0}, {-40, 0}}));
  connect(idealGear.flange_b, outputShaft.flange_a) annotation(
    Line(points = {{-20, 0}, {-4, 0}}));
  connect(RatioTable.y[1], idealGear.ratio) annotation(
    Line(points = {{-19, 48}, {-8, 48}, {-8, 32}, {-49, 32}, {-49, 8}, {-42, 8}}, color = {0, 0, 127}));
  connect(idealGear.support, mounting1D.flange_b) annotation(
    Line(points = {{-30, -10}, {-30, -50}}));
  connect(gears, RatioTable.u) annotation(
    Line(points = {{-82, 46}, {-42, 46}, {-42, 48}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html>
<p>
A&nbsp;single gear transmission without a&nbsp;launch device that is
based on the automatic transmission model interface definition.
</p>
</html>"),
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
end abc_AT;
