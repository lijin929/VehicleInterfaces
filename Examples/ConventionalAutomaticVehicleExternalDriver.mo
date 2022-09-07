within VehicleInterfaces.Examples;
model ConventionalAutomaticVehicleExternalDriver
  "Conventional automatic transmission vehicle using separate driver and driver-interface components"
  extends Modelica.Icons.Example;

  replaceable Engines.MinimalEngine engine
    constrainedby VehicleInterfaces.Engines.Interfaces.Base
    "Engine subsystem" annotation (
      choicesAllMatching=true,
      Dialog(group="Plant Models"),
      Placement(transformation(extent={{-110,-30},{-80,0}})));
  replaceable Transmissions.SingleGearAutomaticTransmission transmission
    constrainedby VehicleInterfaces.Transmissions.Interfaces.BaseAutomaticTransmission
    "Transmission subsystem" annotation (
      choicesAllMatching=true,
      Dialog(group="Plant Models"),
      Placement(transformation(extent={{-60,-30},{-30,0}})));
  replaceable Chassis.MinimalChassis chassis
    constrainedby VehicleInterfaces.Chassis.Interfaces.TwoAxleBase
    "Chassis subsystem"
    annotation (
      choicesAllMatching=true,
      Dialog(group="Plant Models"),
      Placement(transformation(extent={{40,-40},{100,0}})));
  replaceable Drivelines.MinimalDriveline driveline
    constrainedby VehicleInterfaces.Drivelines.Interfaces.TwoAxleBase
    "Driveline subsystem"
    annotation (
      choicesAllMatching=true,
      Dialog(group="Plant Models"),
      Placement(transformation(extent={{-10,-30},{20,0}})));
  replaceable Brakes.MinimalBrakes brakes
    constrainedby VehicleInterfaces.Brakes.Interfaces.TwoAxleBase
    "Brakes subsystem"
    annotation (
      choicesAllMatching=true,
      Dialog(group="Plant Models"),
      Placement(transformation(extent={{120,-30},{150,0}})));
  replaceable Accessories.MinimalAccessories accessories
    constrainedby VehicleInterfaces.Accessories.Interfaces.Base
    "Accessories subsystem"
    annotation (
      choicesAllMatching=true,
      Dialog(group="Plant Models"),
      Placement(transformation(extent={{-145,-25},{-125,-5}})));
  replaceable
    VehicleInterfaces.DriverEnvironments.DriveByWireAutomaticExternalDriver
    driverEnvironment constrainedby VehicleInterfaces.DriverEnvironments.Interfaces.BaseAutomaticTransmissionExternalDriver
    "Driver environment" annotation (
      choicesAllMatching=true,
      Dialog(group="Driver Models"),
      Placement(transformation(extent={{0,50},{30,80}})));
  replaceable Drivers.MinimalDriver driver
    constrainedby Drivers.Interfaces.Base
    "Driver model"
    annotation (
      Dialog(group="Driver Models"),
      choicesAllMatching=true,
      Placement(transformation(extent={{-40,55},{-20,75}})));
  inner replaceable Roads.FlatRoad road
    constrainedby VehicleInterfaces.Roads.Interfaces.Base
    "Road model" annotation (
      choicesAllMatching=true,
      Dialog(group="Conditions"),
      Placement(transformation(extent={{-120,-100},{-80,-80}})));
  inner replaceable Atmospheres.ConstantAtmosphere atmosphere
    constrainedby VehicleInterfaces.Atmospheres.Interfaces.Base
    "Atmospheric model"
    annotation (
      choicesAllMatching=true,
      Dialog(group="Conditions"),
      Placement(transformation(extent={{-70,-100},{-30,-80}})));
  inner replaceable Modelica.Mechanics.MultiBody.World world(
    enableAnimation=false,
    n={0,0,-1},
    driveTrainMechanics3D=false)
    constrainedby Modelica.Mechanics.MultiBody.World
    "Global co-ordinate system" annotation (
      choicesAllMatching=true,
      Dialog(group="Conditions"),
      Placement(transformation(extent={{-150,-100},{-130,-80}})));
protected
  Interfaces.ControlBus controlBus "Control bus connector"
    annotation (Placement(transformation(
        origin={-150,20},
        extent={{-20,-20},{20,20}},
        rotation=90), iconTransformation(
        extent={{0,0},{0,0}},
        rotation=90,
        origin={-100,60})));
equation
  connect(accessories.engineFlange, engine.accessoryFlange) annotation (Line(
        points={{-125,-15},{-110,-15}}));
  connect(engine.transmissionFlange, transmission.engineFlange) annotation (Line(
        points={{-80,-15},{-60,-15}}));
  connect(transmission.drivelineFlange, driveline.transmissionFlange)
    annotation (Line(points={{-30,-15},{-10,-15}}));
  connect(chassis.wheelHub_2, driveline.wheelHub_2) annotation (Line(
      points={{53.125,0},{53.125,15},{-4,15},{-4,0}},
      color={135,135,135},
      thickness=0.5));
  connect(driveline.wheelHub_4, chassis.wheelHub_4) annotation (Line(
      points={{14,0},{14,10},{86.875,10},{86.875,0}},
      color={135,135,135},
      thickness=0.5));
  connect(chassis.wheelHub_4, brakes.wheelHub_4) annotation (Line(
      points={{86.875,0},{86.875,10},{144,10},{144,0}},
      color={135,135,135},
      thickness=0.5));
  connect(brakes.wheelHub_2, chassis.wheelHub_2) annotation (Line(
      points={{126,0},{126,15},{53.125,15},{53.125,0}},
      color={135,135,135},
      thickness=0.5));
  connect(driveline.wheelHub_3, chassis.wheelHub_3) annotation (Line(
      points={{14,-30},{14,-55},{86.875,-55},{86.875,-40}},
      color={135,135,135},
      thickness=0.5));
  connect(chassis.wheelHub_1, driveline.wheelHub_1) annotation (Line(
      points={{53.125,-40},{53.125,-60},{-4,-60},{-4,-30}},
      color={135,135,135},
      thickness=0.5));
  connect(chassis.wheelHub_3, brakes.wheelHub_3) annotation (Line(
      points={{86.875,-40},{86.875,-55},{144,-55},{144,-30}},
      color={135,135,135},
      thickness=0.5));
  connect(chassis.wheelHub_1, brakes.wheelHub_1) annotation (Line(
      points={{53.125,-40},{53.125,-60},{126,-60},{126,-30}},
      color={135,135,135},
      thickness=0.5));
  connect(controlBus, engine.controlBus) annotation (Line(
      points={{-150,20},{-120,20},{-120,-6},{-110,-6}},
      color={255,204,51},
      thickness=0.5));
  connect(controlBus, transmission.controlBus) annotation (Line(
      points={{-150,20},{-70,20},{-70,-6},{-60,-6}},
      color={255,204,51},
      thickness=0.5));
  connect(controlBus, driveline.controlBus) annotation (Line(
      points={{-150,20},{-20,20},{-20,-6},{-10,-6}},
      color={255,204,51},
      thickness=0.5));
  connect(controlBus, chassis.controlBus) annotation (Line(
      points={{-150,20},{34,20},{34,-8},{40.375,-8}},
      color={255,204,51},
      thickness=0.5));
  connect(controlBus, brakes.controlBus) annotation (Line(
      points={{-150,20},{110,20},{110,-6},{120,-6}},
      color={255,204,51},
      thickness=0.5));
  connect(accessories.controlBus, controlBus) annotation (Line(
      points={{-145,-9},{-150,-9},{-150,20}},
      color={255,204,51},
      thickness=0.5));
  connect(controlBus, driverEnvironment.controlBus) annotation (Line(
      points={{-150,20},{80,20},{80,74},{30,74}},
      color={255,204,51},
      thickness=0.5));
  connect(driveline.drivelineMount, chassis.chassisFrame) annotation (Line(
      points={{5,-30},{5,-34},{40,-34}},
      color={95,95,95},
      thickness=0.5));
  connect(transmission.transmissionMount, chassis.chassisFrame) annotation (Line(
      points={{-45,-30},{-45,-34},{40,-34}},
      color={95,95,95},
      thickness=0.5));
  connect(engine.engineMount, chassis.chassisFrame) annotation (Line(
      points={{-95,-30},{-95,-34},{40,-34}},
      color={95,95,95},
      thickness=0.5));
  connect(driverEnvironment.acceleratorPedal, engine.acceleratorPedal)
    annotation (Line(points={{3,50},{3,40},{-95,40},{-95,0}}, color={0,127,0}));
  connect(driverEnvironment.brakePedal, brakes.brakePedal) annotation (Line(
        points={{21,50},{21,40},{135,40},{135,0}}, color={0,127,0}));
  connect(driverEnvironment.steeringWheel, chassis.steeringWheel) annotation (Line(
        points={{30,65},{70,65},{70,0}}));
  connect(driverEnvironment.chassisFrame, chassis.chassisFrame) annotation (Line(
      points={{27,50},{27,-34},{40,-34}},
      color={95,95,95},
      thickness=0.5));

  connect(driverEnvironment.driverInterface, driver.driverInterface)
    annotation (Line(
      points={{0,65},{-20,65}},
      color={85,85,255},
      thickness=0.5));
  annotation (
    experiment(StopTime=10),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-160,-100},{160,100}},
        grid={1,1})),
    Documentation(info="<html>
<p>
Example model architecture of a&nbsp;passenger car with an automatic
transmission and a&nbsp;driver model that is defined separately from
the driverEnvironment. In this architecture variant the PowerTrain
systems are rigidly mounted to the chassis when MultiBody effects
are included.
</p>
</html>"));
end ConventionalAutomaticVehicleExternalDriver;
