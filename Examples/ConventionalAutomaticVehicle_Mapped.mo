within VehicleInterfaces.Examples;

model ConventionalAutomaticVehicle_Mapped "Conventional automatic transmission vehicle"
  extends Modelica.Icons.Example;
  replaceable VehicleInterfaces.Engines.MappedEngine engine(engineSpeed_start = 800) annotation(
    Placement(visible = true, transformation(extent = {{-110, -15}, {-80, 15}}, rotation = 0)))constrainedby VehicleInterfaces.Engines.Interfaces.Base "Engine subsystem" annotation(
     choicesAllMatching = true,
     Dialog(group = "Plant Models"),
     Placement(transformation(extent = {{-110, -30}, {-80, 0}})));
  replaceable VehicleInterfaces.Chassis.MinimalChassis chassis annotation(
    Placement(visible = true, transformation(extent = {{40, -25}, {100, 15}}, rotation = 0))) constrainedby VehicleInterfaces.Chassis.Interfaces.TwoAxleBase "Chassis subsystem" annotation(
     choicesAllMatching = true,
     Dialog(group = "Plant Models"),
     Placement(transformation(extent = {{40, -40}, {100, 0}})));
  replaceable VehicleInterfaces.Drivelines.MinimalDriveline driveline annotation(
    Placement(visible = true, transformation(extent = {{-10, -15}, {20, 15}}, rotation = 0))) constrainedby VehicleInterfaces.Drivelines.Interfaces.TwoAxleBase "Driveline subsystem" annotation(
     choicesAllMatching = true,
     Dialog(group = "Plant Models"),
     Placement(transformation(extent = {{-10, -30}, {20, 0}})));
  replaceable VehicleInterfaces.Brakes.MinimalBrakes brakes annotation(
    Placement(visible = true, transformation(extent = {{120, -15}, {150, 15}}, rotation = 0))) constrainedby VehicleInterfaces.Brakes.Interfaces.TwoAxleBase "Brakes subsystem" annotation(
     choicesAllMatching = true,
     Dialog(group = "Plant Models"),
     Placement(transformation(extent = {{120, -30}, {150, 0}})));
  replaceable VehicleInterfaces.Accessories.MinimalAccessories accessories annotation(
    Placement(visible = true, transformation(extent = {{-146, -10}, {-126, 10}}, rotation = 0))) constrainedby VehicleInterfaces.Accessories.Interfaces.Base "Accessories subsystem" annotation(
     choicesAllMatching = true,
     Dialog(group = "Plant Models"),
     Placement(transformation(extent = {{-145, -25}, {-125, -5}})));
  replaceable VehicleInterfaces.DriverEnvironments.DriveByWireAutomatic driverEnvironment annotation(
    Placement(visible = true, transformation(extent = {{0, 65}, {30, 95}}, rotation = 0))) constrainedby VehicleInterfaces.DriverEnvironments.Interfaces.BaseAutomaticTransmission "Driver environment" annotation(
     choicesAllMatching = true,
     Dialog(group = "Driver Models"),
     Placement(transformation(extent = {{0, 50}, {30, 80}})));
  inner replaceable Roads.FlatRoad road constrainedby VehicleInterfaces.Roads.Interfaces.Base "Road model" annotation(
     choicesAllMatching = true,
     Dialog(group = "Conditions"),
     Placement(transformation(extent = {{-120, -100}, {-80, -80}})));
  inner replaceable Atmospheres.ConstantAtmosphere atmosphere constrainedby VehicleInterfaces.Atmospheres.Interfaces.Base "Atmospheric model" annotation(
     choicesAllMatching = true,
     Dialog(group = "Conditions"),
     Placement(transformation(extent = {{-70, -100}, {-30, -80}})));
  inner replaceable Modelica.Mechanics.MultiBody.World world(enableAnimation = false, n = {0, 0, -1}, driveTrainMechanics3D = false) constrainedby Modelica.Mechanics.MultiBody.World "Global co-ordinate system" annotation(
     choicesAllMatching = true,
     Dialog(group = "Conditions"),
     Placement(transformation(extent = {{-150, -100}, {-130, -80}})));
  VehicleInterfaces.Transmissions.MappedAT transmission annotation(
    Placement(visible = true, transformation(extent = {{-60, -15}, {-30, 15}}, rotation = 0)));
  VehicleInterfaces.Controllers.ControllerAT controllerAT annotation(
    Placement(visible = true, transformation(origin = {-93.5, -42.5}, extent = {{-13.5, -13.5}, {13.5, 13.5}}, rotation = -90)));
protected
  VehicleInterfaces.Interfaces.ControlBus controlBus "Control bus connector" annotation(
    Placement(visible = true,transformation(origin = {-150, 35}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation( origin = {-100, 60},extent = {{0, 0}, {0, 0}}, rotation = 90)));
equation
  connect(accessories.engineFlange, engine.accessoryFlange) annotation(
    Line(points = {{-126, 0}, {-110, 0}}));
  connect(engine.transmissionFlange, transmission.engineFlange) annotation(
    Line(points = {{-80, 0}, {-60, 0}}));
  connect(transmission.drivelineFlange, driveline.transmissionFlange) annotation(
    Line(points = {{-30, 0}, {-10, 0}}));
  connect(chassis.wheelHub_2, driveline.wheelHub_2) annotation(
    Line(points = {{53.125, 15}, {53.125, 30}, {-4, 30}, {-4, 15}}, color = {135, 135, 135}, thickness = 0.5));
  connect(driveline.wheelHub_4, chassis.wheelHub_4) annotation(
    Line(points = {{14, 15}, {14, 25}, {86.875, 25}, {86.875, 15}}, color = {135, 135, 135}, thickness = 0.5));
  connect(chassis.wheelHub_4, brakes.wheelHub_4) annotation(
    Line(points = {{86.875, 15}, {86.875, 25}, {144, 25}, {144, 15}}, color = {135, 135, 135}, thickness = 0.5));
  connect(brakes.wheelHub_2, chassis.wheelHub_2) annotation(
    Line(points = {{126, 15}, {126, 30}, {53.125, 30}, {53.125, 15}}, color = {135, 135, 135}, thickness = 0.5));
  connect(driveline.wheelHub_3, chassis.wheelHub_3) annotation(
    Line(points = {{14, -15}, {14, -35}, {86.875, -35}, {86.875, -25}}, color = {135, 135, 135}, thickness = 0.5));
  connect(chassis.wheelHub_1, driveline.wheelHub_1) annotation(
    Line(points = {{53.125, -25}, {53.125, -40}, {-4, -40}, {-4, -15}}, color = {135, 135, 135}, thickness = 0.5));
  connect(chassis.wheelHub_3, brakes.wheelHub_3) annotation(
    Line(points = {{86.875, -25}, {86.875, -35}, {144, -35}, {144, -15}}, color = {135, 135, 135}, thickness = 0.5));
  connect(chassis.wheelHub_1, brakes.wheelHub_1) annotation(
    Line(points = {{53.125, -25}, {53.125, -40}, {126, -40}, {126, -15}}, color = {135, 135, 135}, thickness = 0.5));
  connect(controlBus, engine.controlBus) annotation(
    Line(points = {{-150, 35}, {-120, 35}, {-120, 9}, {-110, 9}}, color = {255, 204, 51}, thickness = 0.5));
  connect(controlBus, transmission.controlBus) annotation(
    Line(points = {{-150, 35}, {-70, 35}, {-70, 9}, {-60, 9}}, color = {255, 204, 51}, thickness = 0.5));
  connect(controlBus, driveline.controlBus) annotation(
    Line(points = {{-150, 35}, {-20, 35}, {-20, 9}, {-10, 9}}, color = {255, 204, 51}, thickness = 0.5));
  connect(controlBus, chassis.controlBus) annotation(
    Line(points = {{-150, 35}, {34, 35}, {34, 7}, {40.375, 7}}, color = {255, 204, 51}, thickness = 0.5));
  connect(controlBus, brakes.controlBus) annotation(
    Line(points = {{-150, 35}, {110, 35}, {110, 9}, {120, 9}}, color = {255, 204, 51}, thickness = 0.5));
//connect(controlBus, controllerAT.controlBus) annotation(
//Line(points = {{-150, 20}, {110, 20}, {110, -6}, {120, -6}}, color = {255, 204, 51}, thickness = 0.5));
  connect(accessories.controlBus, controlBus) annotation(
    Line(points = {{-146, 6}, {-150, 6}, {-150, 35}}, color = {255, 204, 51}, thickness = 0.5));
  connect(controlBus, driverEnvironment.controlBus) annotation(
    Line(points = {{-150, 35}, {80, 35}, {80, 89}, {30, 89}}, color = {255, 204, 51}, thickness = 0.5));
  connect(driveline.drivelineMount, chassis.chassisFrame) annotation(
    Line(points = {{5, -15}, {5, -19}, {40, -19}}, color = {95, 95, 95}, thickness = 0.5));
  connect(transmission.transmissionMount, chassis.chassisFrame) annotation(
    Line(points = {{-45, -15}, {-45, -19}, {40, -19}}, color = {95, 95, 95}, thickness = 0.5));
  connect(engine.engineMount, chassis.chassisFrame) annotation(
    Line(points = {{-95, -15}, {-95, -19}, {40, -19}}, color = {95, 95, 95}, thickness = 0.5));
  connect(driverEnvironment.acceleratorPedal, engine.acceleratorPedal) annotation(
    Line(points = {{3, 65}, {3, 55}, {-95, 55}, {-95, 15}}, color = {0, 127, 0}));
  connect(driverEnvironment.brakePedal, brakes.brakePedal) annotation(
    Line(points = {{21, 65}, {21, 55}, {135, 55}, {135, 15}}, color = {0, 127, 0}));
  connect(driverEnvironment.steeringWheel, chassis.steeringWheel) annotation(
    Line(points = {{30, 80}, {70, 80}, {70, 15}}));
  connect(driverEnvironment.chassisFrame, chassis.chassisFrame) annotation(
    Line(points = {{27, 65}, {27, -19}, {40, -19}}, color = {95, 95, 95}, thickness = 0.5));
  connect(controllerAT.transmissionBus, controlBus.transmissionBus) annotation(
    Line(points = {{-107, -42.5}, {-70, -42.5}, {-70, 35}, {-150, 35}}, color = {255, 204, 51}, thickness = 0.5));
  annotation(
    experiment(StopTime = 10),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-160, -100}, {160, 100}}, grid = {1, 1})),
    Documentation(info = "<html>
<p>
Example model architecture of a passenger car with an automatic transmission.
In this architecture variant the PowerTrain systems are rigidly mounted
to the chassis when MultiBody effects are included.
</p>
</html>"));
end ConventionalAutomaticVehicle_Mapped;
