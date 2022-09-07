within VehicleInterfaces.Transmissions;

model MappedTC "Mapped torque converter"
  extends VehicleInterfaces.Icons.Transmission;
  extends Interfaces.BaseAutomaticTransmission(includeMount = world.driveTrainMechanics3D);
  
  parameter Modelica.Units.SI.Inertia pumpInertia = 0.015;
  parameter Modelica.Units.SI.Inertia turbineInertia = 0.015;
  parameter Modelica.Units.SI.Length diameter = 0.43;
  parameter Modelica.Units.SI.Density oilDensity = 860;  
  parameter Real LambdaTable[:,:] = [0, 1.93, 0, 6.23; 0.1, 1.89, 19, 6.34; 0.2, 1.8, 36, 6.42; 0.3, 1.71, 51, 6.48; 0.40, 1.58, 63, 6.5; 0.50, 1.43, 72, 6.395; 0.60, 1.35, 81, 5.636; 0.65, 1.27, 83, 5.401; 0.7, 1.23, 86, 4.951; 0.75, 1.17, 88, 4.547; 0.8, 1.12, 89, 4.117; 0.85, 1.05, 89, 3.686; 0.86, 1.05, 90, 3.616; 0.89, 1, 89, 3.208; 0.9, 1, 90, 3.059; 0.95, 1, 95, 1.733; 1, 1, 100, 0.016] "Table matrix (grid = first column; e.g., table=[0, 0; 1, 1; 2, 4])";
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor turbineSpeed annotation(
    Placement(visible = true, transformation(origin = {28, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Rotational.Components.Inertia pumpShaft(J = pumpInertia) annotation(
    Placement(visible = true, transformation(origin = {-66, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia turbineShaft(J = turbineInertia) annotation(
    Placement(visible = true, transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor turbineTorque annotation(
    Placement(visible = true, transformation(origin = {58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor pumpSpeed annotation(
    Placement(visible = true, transformation(origin = {-36, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor pumpTorque annotation(
    Placement(visible = true, transformation(origin = {-36, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  VehicleInterfaces.Transmissions.TC_lambda tC_lambda(LambdaTable = LambdaTable, diameter = diameter, oilDensity = oilDensity)  annotation(
    Placement(visible = true, transformation(origin = {-6, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  outer Modelica.Mechanics.MultiBody.World world annotation(
    Placement(visible = true, transformation(origin = {-84, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(engineFlange.flange, pumpShaft.flange_a) annotation(
    Line(points = {{-100, 0}, {-76, 0}}));
  connect(turbineShaft.flange_b, turbineTorque.flange_a) annotation(
    Line(points = {{38, 0}, {48, 0}}));
  connect(turbineShaft.flange_b, turbineSpeed.flange) annotation(
    Line(points = {{38, 0}, {38, 36}}));
  connect(pumpTorque.flange_a, pumpShaft.flange_b) annotation(
    Line(points = {{-46, 0}, {-56, 0}}));
  connect(turbineTorque.flange_b, drivelineFlange) annotation(
    Line(points = {{68, 0}, {100, 0}}));
  connect(pumpTorque.flange_b, tC_lambda.flange_a) annotation(
    Line(points = {{-26, 0}, {-16, 0}}));
  connect(tC_lambda.flange_b, turbineShaft.flange_a) annotation(
    Line(points = {{4, 0}, {18, 0}}));
  connect(pumpSpeed.flange, pumpShaft.flange_b) annotation(
    Line(points = {{-46, 34}, {-56, 34}, {-56, 0}}));
end MappedTC;
