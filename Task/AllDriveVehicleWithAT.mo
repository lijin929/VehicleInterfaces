within VehicleInterfaces.Task;
model AllDriveVehicleWithAT
  parameter Real engineTable[:,2] = [900, 1903; 1000, 2138; 1100, 2281; 1200, 2282; 1300, 2281; 1500, 2282; 1700, 2041; 1900, 1826; 2050, 0] "Pump speed, rpm";
  parameter Real diameter = 0.43 "TC diameter, m";
  parameter Real oilDensity = 860 "Oil density, kg/m3";
  parameter Real lambdaTable[:,4] = [0, 1.93, 0, 6.23; 0.1, 1.89, 19, 6.34; 0.2, 1.8, 36, 6.42; 0.3, 1.71, 51, 6.48; 0.40, 1.58, 63, 6.5; 0.50, 1.43, 72, 6.395; 0.60, 1.35, 81, 5.636; 0.65, 1.27, 83, 5.401; 0.7, 1.23, 86, 4.951; 0.75, 1.17, 88, 4.547; 0.8, 1.12, 89, 4.117; 0.85, 1.05, 89, 3.686; 0.86, 1.05, 90, 3.616; 0.89, 1, 89, 3.208; 0.9, 1, 90, 3.059; 0.95, 1, 95, 1.733; 1, 1, 100, 0.016] "torque converter λ parameters";
  parameter Real gearboxTable[:,2] = [4.630, 0.9; 3.400, 0.9; 2.190, 0.9; 1.520, 0.9; 1.000, 0.9; 0.760, 0.9; 0.670, 0.9] "gearbox ratio and effience";
  parameter Real finalDriveTable[2] = {20.14, 0.85} "Front drive ratio and effience";
  parameter Real tyreRadius = 0.34 "Tyre rolling radius, m";
  parameter Real vehicleMass = 120000 "Vehicle mass, kg";
  parameter Real dragCoeffience = 0.8 "Drag force coefficeint";
  parameter Real frontalArea = 4.8 "frontal area, m^2";
  parameter Real airDensity = 1.225 "air density, kg/m^3";
  parameter Real theta = 0 "grade, °";
  parameter Integer gearStart = 1 "gear at vehicle start up";
  parameter Real phi = 0.7 "";
  parameter Real rollingCoeffience = 0.016 "";
  parameter Real d[:,:] = [
    0.0310, 0.0310, 0.0310, 0.0310, 0.0310, 0.0360, 0.0440; 
    0.4000, 0.4000, 0.4000, 0.4000, 0.4000, 0.4000, 0.4000; 
    1.2000, 1.2000, 1.2000, 1.2000, 1.2000, 1.1000, 1.0800] "";
  parameter Integer gearTC = 2 "max gear at torque converter work";

  VehicleInterfaces.Task.TCmatching TC(diameter = diameter, lambdaTable = lambdaTable, oilDensity = oilDensity, columns = size(engine.no, 1))
    annotation (
      Placement(transformation(origin = {-20.0, 0.0}, 
        extent = {{-10.0, -10.0}, {10.0, 10.0}})));
  VehicleInterfaces.Task.gearboxMatchingSIMO AT(gearboxTable = gearboxTable, columns = size(TC.no, 1))
    annotation (
      Placement(transformation(origin = {8.0, 0.0}, 
        extent = {{-10.0, -10.0}, {10.0, 10.0}})));
  inputTable engine(array = engineTable) annotation (
    Placement(transformation(origin = {-66.00000000000001, 0.0}, 
      extent = {{-10.0, -10.0}, {10.0, 10.0}})));
  VehicleInterfaces.Task.gearboxMatchingMIMO finalDrive(columns = size(AT.no, 2), gearboxTable = finalDriveTable, rows = size(AT.no, 1)) annotation (
    Placement(transformation(origin = {36.0, 0.0}, 
      extent = {{-10.0, -10.0}, {10.0, 10.0}})));
  VehicleInterfaces.Task.chassis vehicleChassis(columns = size(finalDrive.no, 2), rows = size(finalDrive.no, 1), tyreRadius = tyreRadius) annotation (
    Placement(transformation(origin = {64.0, 0.0}, 
      extent = {{-10.0, -10.0}, {10.0, 10.0}})));
  throustCharacteristics thrustCal(columns = size(vehicleChassis.velocity, 2), rows = size(vehicleChassis.velocity, 1), vehicleMass = vehicleMass, tyreRadius = tyreRadius, dragCoeffience = dragCoeffience, frontalArea = frontalArea, airDensity = airDensity, theta = theta) annotation (
    Placement(transformation(origin = {92.0, 0.0}, 
      extent = {{-10.0, -10.0}, {10.0, 10.0}})));



  accelerationCharacteristics accelerationCal(rows = size(Intersection.velocityOut, 1), columns = size(Intersection.velocityOut, 2), phi = phi, rollingCoeffience = rollingCoeffience, d = d)
    annotation (Placement(transformation(origin = {192.0, -17.999999999999993}, 
      extent = {{-10.0, -10.0}, {10.0, 10.0}})));
  gearboxMatchingSIMO MT(gearboxTable = gearboxTable, columns = size(engine.no, 1))
    annotation (
      Placement(transformation(origin = {8.0, -30.000000000000004}, 
        extent = {{-10.0, -10.0}, {10.0, 10.0}})));
  gearboxMatchingMIMO finalDrive1(columns = size(MT.no, 2), gearboxTable = finalDriveTable, rows = size(MT.no, 1)) annotation (
    Placement(transformation(origin = {36.0, -30.000000000000004}, 
      extent = {{-10.0, -10.0}, {10.0, 10.0}})));
  chassis vehicleChassis1(columns = size(finalDrive1.no, 2), rows = size(finalDrive1.no, 1), tyreRadius = tyreRadius) annotation (
    Placement(transformation(origin = {64.0, -30.000000000000004}, 
      extent = {{-10.0, -10.0}, {10.0, 10.0}})));
  throustCharacteristics thrustCal1(columns = size(vehicleChassis1.velocity, 2), rows = size(vehicleChassis1.velocity, 1), vehicleMass = vehicleMass, tyreRadius = tyreRadius, dragCoeffience = dragCoeffience, frontalArea = frontalArea, airDensity = airDensity, theta = theta) annotation (
    Placement(transformation(origin = {92.0, -29.999999999999993}, 
      extent = {{-10.0, -10.0}, {10.0, 10.0}})));
  throustResultIntersectionForAcc Intersection(rows = size(thrustWithTC.velocityOut, 1), columns = size(thrustWithTC.velocityOut, 2)) annotation (Placement(transformation(origin = {161.0, -17.999999999999993}, 
      extent = {{-10.0, -10.0}, {10.0, 10.0}})));
  throustResultWithTC thrustWithTC( gearTC = gearTC,sizeAT = size(thrustCal.velocity1), sizeMT = size(thrustCal1.velocity1))
    annotation (Placement(transformation(origin = {130.0, -17.999999999999993}, 
      extent = {{-10.0, -10.0}, {10.0, 10.0}})));
equation 
  connect(TC.no, AT.ni) annotation (
    Line(origin = {-6.0, 6.0}, 
      points = {{-4.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}, 
      thickness = 0.5));
  connect(engine.no, TC.ni) annotation (
    Line(origin = {-34.0, 6.0}, 
      points = {{-22.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}, 
      thickness = 0.5));
  connect(TC.To, AT.Ti) annotation (
    Line(origin = {-6.0, -6.0}, 
      points = {{-4.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}, 
      thickness = 0.5));
  connect(AT.To, finalDrive.Ti) annotation (
    Line(origin = {22.0, -6.0}, 
      points = {{-4.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}, 
      thickness = 0.5));
  connect(engine.To, TC.Ti) annotation (
    Line(origin = {-34.0, -6.0}, 
      points = {{-22.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}, 
      thickness = 0.5));
  connect(AT.no, finalDrive.ni) annotation (
    Line(origin = {22.0, 6.0}, 
      points = {{-4.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}, 
      thickness = 0.5));
  connect(finalDrive.no, vehicleChassis.ni) annotation (
    Line(origin = {50.0, 6.0}, 
      points = {{-4.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}, 
      thickness = 0.5));
  connect(finalDrive.To, vehicleChassis.Ti) annotation (
    Line(origin = {50.0, -6.0}, 
      points = {{-4.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}, 
      thickness = 0.5));
  connect(vehicleChassis.velocity, thrustCal.velocity) annotation (
    Line(origin = {78.0, 6.0}, 
      points = {{-4.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}, 
      thickness = 0.5));
  connect(vehicleChassis.drivingForce, thrustCal.drivingForce) annotation (
    Line(origin = {78.0, -6.0}, 
      points = {{-4.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}, 
      thickness = 0.5));
  connect(MT.To, finalDrive1.Ti)
    annotation (Line(origin = {22.0, -36.0}, 
      points = {{-4.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}, 
      thickness = 0.5));
  connect(MT.no, finalDrive1.ni)
    annotation (Line(origin = {22.0, -24.0}, 
      points = {{-4.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}, 
      thickness = 0.5));
  connect(finalDrive1.no, vehicleChassis1.ni)
    annotation (Line(origin = {50.0, -24.0}, 
      points = {{-4.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}, 
      thickness = 0.5));
  connect(finalDrive1.To, vehicleChassis1.Ti)
    annotation (Line(origin = {50.0, -36.0}, 
      points = {{-4.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}, 
      thickness = 0.5));
  connect(MT.ni, engine.no)
    annotation (Line(origin = {-29.0, -9.0}, 
      points = {{27.0, -15.0}, {-12.0, -15.0}, {-12.0, 15.0}, {-27.0, 15.0}}, 
      color = {0, 0, 127}));
  connect(MT.Ti, engine.To)
    annotation (Line(origin = {-29.0, -21.0}, 
      points = {{27.0, -15.0}, {-20.0, -15.0}, {-20.0, 15.0}, {-27.0, 15.0}}, 
      color = {0, 0, 127}));
  connect(vehicleChassis1.velocity, thrustCal1.velocity)
    annotation (Line(origin = {78.0, -24.0}, 
      points = {{-4.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}));
  connect(vehicleChassis1.drivingForce, thrustCal1.drivingForce)
    annotation (Line(origin = {78.0, -36.0}, 
      points = {{-4.0, 0.0}, {4.0, 0.0}}, 
      color = {0, 0, 127}));
  connect(accelerationCal.velocity, Intersection.velocityOut)
    annotation (Line(origin = {168.0, -11.999999999999993}, 
      points = {{14.0, 0.0}, {3.0, 0.0}}, 
      color = {0, 0, 127}));
  connect(Intersection.dynamicFactorOut, accelerationCal.dynamicFactor)
    annotation (Line(origin = {168.0, -23.999999999999993}, 
      points = {{3.0, 0.0}, {14.0, 0.0}}, 
      color = {0, 0, 127}));
  connect(Intersection.velocityIn, thrustWithTC.velocityOut)
    annotation (Line(origin = {146.0, -11.999999999999995}, 
      points = {{5.0, 0.0}, {-6.0, 0.0}}, 
      color = {0, 0, 127}));
  connect(Intersection.dynamicFactorIn, thrustWithTC.dynamicFactorOut)
    annotation (Line(origin = {146.0, -23.999999999999993}, 
      points = {{5.0, 0.0}, {-6.0, 0.0}}, 
      color = {0, 0, 127}));
  connect(thrustCal.velocity1, thrustWithTC.velocityAT)
    annotation (Line(origin = {102.0, 0.0}, 
      points = {{0.0, 6.0}, {10.0, 6.0}, {10.0, -12.0}, {18.0, -12.0}}, 
      color = {0, 0, 127}));
  connect(thrustCal.dynamicFactor, thrustWithTC.dynamicFactorAT)
    annotation (Line(origin = {94.0, -7.0}, 
      points = {{8.0, 1.0}, {14.0, 1.0}, {14.0, -8.0}, {26.0, -8.0}}, 
      color = {0, 0, 127}));
  connect(thrustCal1.velocity1, thrustWithTC.velocityMT)
    annotation (Line(origin = {102.0, -19.0}, 
      points = {{0.0, -5.0}, {6.0, -5.0}, {6.0, -2.0}, {18.0, -2.0}}, 
      color = {0, 0, 127}));
  connect(thrustCal1.dynamicFactor, thrustWithTC.dynamicFactorMT)
    annotation (Line(origin = {102.0, -27.0}, 
      points = {{0.0, -9.0}, {12.0, -9.0}, {12.0, 3.0}, {18.0, 3.0}}, 
      color = {0, 0, 127}));
end AllDriveVehicleWithAT;
