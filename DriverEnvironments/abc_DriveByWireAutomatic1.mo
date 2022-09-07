within VehicleInterfaces.DriverEnvironments;

model abc_DriveByWireAutomatic1 "Minimal Drive-by-wire Driver-Vehicle Interface"
  extends VehicleInterfaces.Icons.DriverEnvironment;
  extends VehicleInterfaces.DriverEnvironments.Interfaces.BaseAutomaticTransmission;
  parameter Real acc_k = 1 "acc pid k";
  parameter Real acc_Ti = 100000000 "acc pid Ti";
  parameter Real acc_Td = 0 "acc pid Td";
  parameter Real brake_k = -1 "brake pid k";
  parameter Real brake_Ti = 100000000 "brake pid Ti";
  parameter Real brake_Td = 0 "brake pid Td";
  //  parameter SI.Time accelTime = 10 "Time of accel apply";
  // parameter SI.Time brakeTime = 10 "Time of brake apply";
  parameter VehicleInterfaces.Types.GearMode.Temp selectedGearboxMode = VehicleInterfaces.Types.GearMode.Drive "Current gearbox mode";
  parameter VehicleInterfaces.Types.Gear manualGearRequest = 0 "Requested gear in manual mode";
  Modelica.Blocks.Sources.IntegerConstant gearSelect(k = manualGearRequest) annotation(
    Placement(visible = true, transformation(extent = {{-28, 20}, {-8, 40}}, rotation = 0)));
  Modelica.Blocks.Sources.IntegerConstant gearMode(k = selectedGearboxMode) annotation(
    Placement(visible = true, transformation(extent = {{-70, 42}, {-50, 62}}, rotation = 0)));
  Modelica.Blocks.Sources.IntegerStep ignition(height = -1, startTime = 0.5, offset = VehicleInterfaces.Types.IgnitionSetting.Start) annotation(
    Placement(visible = true, transformation(extent = {{-28, 60}, {-8, 80}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u annotation(
    Placement(visible = true, transformation(origin = {-146, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-98, -26}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Add delta_v(k1 = 1, k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {-56, -22}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Continuous.PID acc_pid(Td = acc_Td, Ti = acc_Ti, k = acc_k) annotation(
    Placement(visible = true, transformation(origin = {4, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PID brake_pid(Td = brake_Td, Ti = brake_Ti, k = brake_k) annotation(
    Placement(visible = true, transformation(origin = {2, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch acc_padelposition annotation(
    Placement(visible = true, transformation(origin = {66, -12}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch brake_padelposition annotation(
    Placement(visible = true, transformation(origin = {66, -42}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0) annotation(
    Placement(visible = true, transformation(origin = {13, -31}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Gain NEDC(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-75, 3}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Gain v_actual(k = 3.6) annotation(
    Placement(visible = true, transformation(origin = {-123, -37}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 1, uMin = 0) annotation(
    Placement(visible = true, transformation(origin = {34, -66}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax = 1, uMin = 0) annotation(
    Placement(visible = true, transformation(origin = {34, 2}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold = 0)  annotation(
    Placement(visible = true, transformation(origin = {-28, -22}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.ContinuousClock continuousClock annotation(
    Placement(visible = true, transformation(origin = {-130, -56}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1 annotation(
    Placement(visible = true, transformation(origin = {-110, -56}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch annotation(
    Placement(visible = true, transformation(origin = {-76, -48}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-131, -79}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput gear annotation(
    Placement(visible = true, transformation(origin = {-70, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {105, -61}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  VehicleInterfaces.Transmissions.abc_gear abc_gear annotation(
    Placement(visible = true, transformation(origin = {-106, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  VehicleInterfaces.Interfaces.DriverBus driverBus annotation(
    Placement(visible = true, transformation(extent = {{62, 80}, {82, 100}}, rotation = 0), iconTransformation(extent = {{50, 50}, {70, 70}}, rotation = 0)));
equation
  connect(controlBus.driverBus, driverBus) annotation(
    Line(points = {{100.1, 59.9}, {100.1, 90}, {72, 90}}, color = {255, 204, 51}, thickness = 0.5));
  connect(gearSelect.y, driverBus.requestedGear) annotation(
    Line(points = {{-7, 30}, {72, 30}, {72, 90}}, color = {255, 127, 0}));
  connect(gearMode.y, driverBus.gearboxMode) annotation(
    Line(points = {{-49, 52}, {72, 52}, {72, 90}}, color = {255, 127, 0}));
  connect(ignition.y, driverBus.ignition) annotation(
    Line(points = {{-7, 70}, {72, 70}, {72, 90}}, color = {255, 127, 0}));
  connect(brake_pid.u, delta_v.y) annotation(
    Line(points = {{-10, -66}, {-47, -66}, {-47, -22}}, color = {0, 0, 127}));
  connect(acc_pid.u, delta_v.y) annotation(
    Line(points = {{-8, 2}, {-47, 2}, {-47, -22}}, color = {0, 0, 127}));
  connect(acc_padelposition.y, driverBus.acceleratorPedalPosition) annotation(
    Line(points = {{73, -12}, {72, -12}, {72, 90}}, color = {0, 0, 127}));
  connect(brake_padelposition.y, driverBus.brakePedalPosition) annotation(
    Line(points = {{73, -42}, {73, 10}, {72, 10}, {72, 90}}, color = {0, 0, 127}));
  connect(NEDC.y, delta_v.u1) annotation(
    Line(points = {{-67, 3}, {-66.3, 3}, {-66.3, -18}}, color = {0, 0, 127}));
  connect(u, v_actual.u) annotation(
    Line(points = {{-146, -38}, {-124, -38}, {-124, -37}, {-131, -37}}, color = {0, 0, 127}));
  connect(limiter1.u, acc_pid.y) annotation(
    Line(points = {{27, 2}, {15, 2}}, color = {0, 0, 127}));
  connect(brake_pid.y, limiter.u) annotation(
    Line(points = {{13, -66}, {27, -66}}, color = {0, 0, 127}));
  connect(greaterThreshold.u, delta_v.y) annotation(
    Line(points = {{-35, -22}, {-47.2, -22}}, color = {0, 0, 127}));
  connect(greaterThreshold.y, acc_padelposition.u2) annotation(
    Line(points = {{-21, -22}, {58.6, -22}, {58.6, -17}, {59, -17}, {59, -12}}, color = {255, 0, 255}));
  connect(brake_padelposition.u2, greaterThreshold.y) annotation(
    Line(points = {{58.8, -42}, {-21, -42}, {-21, -22}}, color = {255, 0, 255}));
  connect(const.y, brake_padelposition.u1) annotation(
    Line(points = {{18.5, -31}, {58.5, -31}, {58.5, -39}}, color = {0, 0, 127}));
  connect(limiter.y, brake_padelposition.u3) annotation(
    Line(points = {{41, -66}, {50.5, -66}, {50.5, -47}, {58.5, -47}}, color = {0, 0, 127}));
  connect(limiter1.y, acc_padelposition.u1) annotation(
    Line(points = {{41, 2}, {51.75, 2}, {51.75, -7}, {59, -7}}, color = {0, 0, 127}));
  connect(acc_padelposition.u3, const.y) annotation(
    Line(points = {{59, -17}, {18.5, -17}, {18.5, -31}}, color = {0, 0, 127}));
  connect(continuousClock.y, greaterThreshold1.u) annotation(
    Line(points = {{-123.4, -56}, {-117, -56}}, color = {0, 0, 127}));
  connect(greaterThreshold1.y, switch.u2) annotation(
    Line(points = {{-103, -56}, {-94.4, -56}, {-94.4, -48}, {-83, -48}}, color = {255, 0, 255}));
  connect(switch.y, delta_v.u2) annotation(
    Line(points = {{-69, -48}, {-66, -48}, {-66, -26}}, color = {0, 0, 127}));
  connect(const1.y, switch.u3) annotation(
    Line(points = {{-125.5, -79}, {-83, -79}, {-83, -53}}, color = {0, 0, 127}));
  connect(switch.u1, v_actual.y) annotation(
    Line(points = {{-83, -43}, {-115, -43}, {-115, -37}}, color = {0, 0, 127}));
  connect(abc_gear.gear, gear) annotation(
    Line(points = {{-96, 13}, {-89, 13}, {-89, 28}, {-70, 28}}, color = {0, 0, 127}));
  connect(abc_gear.NEDC_velocity, NEDC.u) annotation(
    Line(points = {{-95, 4}, {-83, 4}, {-83, 3}}, color = {0, 0, 127}));
  connect(abc_gear.u, v_actual.y) annotation(
    Line(points = {{-118, 12}, {-134, 12}, {-134, -12}, {-115, -12}, {-115, -37}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html>
<p>
Constant acceleration driver with the capabilitiy to step between two
constant throttle values and to step on/off the brakes.
</p>
</html>"),
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
end abc_DriveByWireAutomatic1;
