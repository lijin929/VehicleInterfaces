within VehicleInterfaces.Examples;

model abc_vehicle03
  inner Roads.FlatRoad road annotation(
    Placement(visible = true, transformation(extent = {{-120, -100}, {-80, -80}}, rotation = 0)));
  inner Modelica.Mechanics.MultiBody.World world(driveTrainMechanics3D = false, enableAnimation = false, n = {0, 0, -1}) annotation(
    Placement(visible = true, transformation(extent = {{-150, -100}, {-130, -80}}, rotation = 0)));
  VehicleInterfaces.Interfaces.ControlBus controlBus annotation(
    Placement(visible = true, transformation(origin = {-138, 56}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {-100, 60}, extent = {{0, 0}, {0, 0}}, rotation = 90)));
  inner Atmospheres.ConstantAtmosphere atmosphere annotation(
    Placement(visible = true, transformation(extent = {{-70, -100}, {-30, -80}}, rotation = 0)));
VehicleInterfaces.Accessories.abc_Accessories abc_Accessories(accessoriesLoad = 0)  annotation(
    Placement(visible = true, transformation(origin = {-110, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
VehicleInterfaces.Drivelines.abc_Driveline abc_Driveline(finalDriveRatio = 2.56 * 1.92)  annotation(
    Placement(visible = true, transformation(origin = {24, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
VehicleInterfaces.Engines.abc_Engine abc_Engine(engineSpeed_start = 0, flywheelInertia = 0.25)  annotation(
    Placement(visible = true, transformation(origin = {-65, 20}, extent = {{-11, -14}, {11, 14}}, rotation = 0)));
VehicleInterfaces.Transmissions.abc_AT abc_AT annotation(
    Placement(visible = true, transformation(origin = {-22, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
VehicleInterfaces.Brakes.abc_Brakes abc_Brakes(maxTorque = 10000)  annotation(
    Placement(visible = true, transformation(origin = {128, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
VehicleInterfaces.DriverEnvironments.abc_DriveByWireAutomatic1 abc_DriveByWireAutomatic1 annotation(
    Placement(visible = true, transformation(origin = {-10, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
VehicleInterfaces.Chassis.abc_Chassis01 abc_Chassis01(tyreRadius = 0.452, vehicleMass = 5100)  annotation(
    Placement(visible = true, transformation(origin = {72, 18}, extent = {{-16, -10}, {16, 10}}, rotation = 0)));
equation
  connect(abc_Engine.transmissionFlange, abc_AT.engineFlange) annotation(
    Line(points = {{-54, 20}, {-32, 20}}, color = {135, 135, 135}));
  connect(abc_AT.drivelineFlange, abc_Driveline.transmissionFlange) annotation(
    Line(points = {{-12, 20}, {14, 20}}, color = {135, 135, 135}));
  connect(abc_Engine.driverBus, controlBus.driverBus) annotation(
    Line(points = {{-74, 26}, {-138, 26}, {-138, 56}}, color = {255, 204, 51}, thickness = 0.5));
  connect(abc_Engine.engineBus, controlBus.engineBus) annotation(
    Line(points = {{-72, 28}, {-138, 28}, {-138, 56}}, color = {255, 204, 51}, thickness = 0.5));
  connect(abc_AT.transmissionBus, controlBus.transmissionBus) annotation(
    Line(points = {{-24, 26}, {-44, 26}, {-44, 56}, {-138, 56}}, color = {255, 204, 51}, thickness = 0.5));
  connect(abc_Brakes.brakesBus, controlBus.brakesBus) annotation(
    Line(points = {{118, 24}, {118, 56}, {-138, 56}}, color = {255, 204, 51}, thickness = 0.5));
  connect(abc_Accessories.engineFlange, abc_Engine.accessoryFlange) annotation(
    Line(points = {{-100, 10}, {-87, 10}, {-87, 20}, {-76, 20}}, color = {135, 135, 135}));
  connect(abc_Brakes.driverBus, controlBus.driverBus) annotation(
    Line(points = {{118, 24}, {110, 24}, {110, 56}, {-138, 56}}, color = {255, 204, 51}, thickness = 0.5));
  connect(abc_DriveByWireAutomatic1.acceleratorPedal, abc_Engine.acceleratorPedal) annotation(
    Line(points = {{-18, 68}, {-18, 64}, {-65, 64}, {-65, 34}}, color = {0, 127, 0}));
connect(abc_DriveByWireAutomatic1.brakePedal, abc_Brakes.brakePedal) annotation(
    Line(points = {{-6, 68}, {128, 68}, {128, 28}}, color = {0, 127, 0}));
connect(abc_DriveByWireAutomatic1.driverBus, controlBus.driverBus) annotation(
    Line(points = {{-4, 84}, {12, 84}, {12, 94}, {-138, 94}, {-138, 56}}, color = {255, 204, 51}, thickness = 0.5));
  connect(abc_Driveline.wheelHub_2, abc_Chassis01.wheelHub_2) annotation(
    Line(points = {{18, 30}, {43.5, 30}, {43.5, 28}, {63, 28}}, color = {135, 135, 135}));
  connect(abc_Driveline.wheelHub_4, abc_Chassis01.wheelHub_4) annotation(
    Line(points = {{30, 30}, {30, 46}, {81, 46}, {81, 28}}, color = {135, 135, 135}));
  connect(abc_Driveline.wheelHub_1, abc_Chassis01.wheelHub_1) annotation(
    Line(points = {{18, 10}, {43.5, 10}, {43.5, 8}, {63, 8}}, color = {135, 135, 135}));
  connect(abc_Driveline.wheelHub_3, abc_Chassis01.wheelHub_3) annotation(
    Line(points = {{30, 10}, {30, -6}, {81, -6}, {81, 8}}, color = {135, 135, 135}));
  connect(abc_Chassis01.wheelHub_2, abc_Brakes.wheelHub_2) annotation(
    Line(points = {{63, 28}, {64, 28}, {64, 48}, {122, 48}, {122, 28}}, color = {135, 135, 135}));
  connect(abc_Chassis01.wheelHub_4, abc_Brakes.wheelHub_4) annotation(
    Line(points = {{81, 28}, {134, 28}}, color = {135, 135, 135}));
  connect(abc_Chassis01.wheelHub_1, abc_Brakes.wheelHub_1) annotation(
    Line(points = {{63, 8}, {122, 8}}, color = {135, 135, 135}));
  connect(abc_Chassis01.wheelHub_3, abc_Brakes.wheelHub_3) annotation(
    Line(points = {{81, 8}, {134, 8}}, color = {135, 135, 135}));
  connect(abc_Engine.engineMount, abc_Chassis01.chassisFrame) annotation(
    Line(points = {{-65, 6}, {-72, 6}, {-72, -12}, {56, -12}, {56, 11}}));
  connect(abc_AT.transmissionMount, abc_Chassis01.chassisFrame) annotation(
    Line(points = {{-22, 10}, {-22, -8}, {56, -8}, {56, 11}}));
  connect(abc_DriveByWireAutomatic1.steeringWheel, abc_Chassis01.steeringWheel) annotation(
    Line(points = {{0, 78}, {72, 78}, {72, 28}}));
  connect(abc_Driveline.drivelineMount, abc_Chassis01.chassisFrame) annotation(
    Line(points = {{24, 10}, {24, -4}, {56, -4}, {56, 11}}));
  connect(abc_Chassis01.chassisBus, controlBus.chassisBus) annotation(
    Line(points = {{60, 22}, {60, 56}, {-138, 56}}, color = {255, 204, 51}, thickness = 0.5));
  connect(abc_Chassis01.u, abc_DriveByWireAutomatic1.u) annotation(
    Line(points = {{55, 18}, {42, 18}, {42, 52}, {-34, 52}, {-34, 76}, {-20, 76}}, color = {0, 0, 127}));
  connect(abc_DriveByWireAutomatic1.chassisFrame, abc_Chassis01.chassisFrame) annotation(
    Line(points = {{-2, 68}, {56, 68}, {56, 11}}));
  connect(abc_DriveByWireAutomatic1.gear, abc_AT.gears) annotation(
    Line(points = {{0, 72}, {6, 72}, {6, 38}, {-22, 38}, {-22, 30}}, color = {0, 0, 127}));
protected
end abc_vehicle03;
