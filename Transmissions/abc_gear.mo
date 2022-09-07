within VehicleInterfaces.Transmissions;

model abc_gear
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(fileName = "D:/Program Files/OpenModelica1.16.2-64bit/lib/omlibrary/VehicleInterfaces 2.0.0/Drivers/NEDC.txt", tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {92, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {34, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {1, 57}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold = 0) annotation(
    Placement(visible = true, transformation(origin = {4, 80}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.MinMax minMax(nu = 5) annotation(
    Placement(visible = true, transformation(origin = {91, -5}, extent = {{-19, -23}, {19, 23}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch annotation(
    Placement(visible = true, transformation(origin = {34, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold = 0) annotation(
    Placement(visible = true, transformation(origin = {0, 30}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch2 annotation(
    Placement(visible = true, transformation(origin = {34, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold2(threshold = 0) annotation(
    Placement(visible = true, transformation(origin = {0, -10}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch3 annotation(
    Placement(visible = true, transformation(origin = {34, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant4(k = 5) annotation(
    Placement(visible = true, transformation(origin = {-16, -36}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold3(threshold = 0) annotation(
    Placement(visible = true, transformation(origin = {0, -50}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch4 annotation(
    Placement(visible = true, transformation(origin = {34, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant5(k = 6) annotation(
    Placement(visible = true, transformation(origin = {-16, -76}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold4(threshold = 0) annotation(
    Placement(visible = true, transformation(origin = {0, -90}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
Modelica.Blocks.Sources.Constant constant3(k = 4) annotation(
    Placement(visible = true, transformation(origin = {-16, 4}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
Modelica.Blocks.Sources.Constant constant1(k = 2) annotation(
    Placement(visible = true, transformation(origin = {-16, 90}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
Modelica.Blocks.Sources.Constant constant2(k = 3) annotation(
    Placement(visible = true, transformation(origin = {-16, 44}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
Modelica.Blocks.Sources.Constant const1(k = 0.5)  annotation(
    Placement(visible = true, transformation(origin = {-134, 82}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table = [0.1, 8.7341; 0.2, 10.3703; 0.3, 11.99; 0.4, 13.59; 0.5, 15.18; 0.6, 16.76; 0.7, 18.32; 0.8, 19.95; 0.9, 21.56; 1, 22.87])  annotation(
    Placement(visible = true, transformation(origin = {-66, 82}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
Modelica.Blocks.Math.Add add(k1 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-35, 79}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
Modelica.Blocks.Math.Add add1(k1 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-33, 29}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
Modelica.Blocks.Math.Add add2(k1 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-33, -51}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
Modelica.Blocks.Math.Add add3(k1 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-33, -11}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
Modelica.Blocks.Math.Add add4(k1 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-33, -91}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds1(table = [0.1, 14.007; 0.2, 16.586; 0.3, 19.12; 0.4, 21.61; 0.5, 30; 0.6, 34; 0.7, 39.23; 0.8, 42; 0.9, 42.37; 1, 46])  annotation(
    Placement(visible = true, transformation(origin = {-66, 32}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds2(table = [0.1, 21; 0.2, 23; 0.3, 30.69; 0.4, 34.89; 0.5, 38.88; 0.6, 43.03; 0.7, 47.4; 0.8, 55.46; 0.9, 56.29; 1, 61.06])  annotation(
    Placement(visible = true, transformation(origin = {-66, -8}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds3(table = [0.1, 30; 0.2, 37.78; 0.3, 43.78; 0.4, 49.65; 0.5, 55.30; 0.6, 61.48; 0.7, 67.89; 0.8, 74.55; 0.9, 80.73; 1, 87.62])  annotation(
    Placement(visible = true, transformation(origin = {-66, -48}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds4(table = [0.1, 40.5; 0.2, 49.52; 0.3, 57.17; 0.4, 64.53; 0.5, 72.43; 0.6, 81.43; 0.7, 90.49; 0.8, 99.42; 0.9, 108.13; 1, 111.46])  annotation(
    Placement(visible = true, transformation(origin = {-66, -88}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealOutput NEDC_velocity annotation(
    Placement(visible = true, transformation(origin = {126, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u annotation(
    Placement(visible = true, transformation(origin = {-139, 5}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-120, 16}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-109, 5}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-107, 81}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput gear annotation(
    Placement(visible = true, transformation(origin = {134, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {104, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const.y, switch1.u3) annotation(
    Line(points = {{8.7, 57}, {21.7, 57}, {21.7, 74}}, color = {0, 0, 127}));
  connect(greaterThreshold.y, switch1.u2) annotation(
    Line(points = {{10.6, 80}, {16.1, 80}, {16.1, 82}, {21.6, 82}}, color = {255, 0, 255}));
  connect(greaterThreshold1.y, switch.u2) annotation(
    Line(points = {{6.6, 30}, {6.1, 30}, {6.1, 36}, {21.6, 36}}, color = {255, 0, 255}));
  connect(switch.u3, const.y) annotation(
    Line(points = {{22, 28}, {9, 28}, {9, 57}}, color = {0, 0, 127}));
  connect(switch3.u1, constant4.y) annotation(
    Line(points = {{22, -36}, {-10, -36}}, color = {0, 0, 127}));
  connect(constant5.y, switch4.u1) annotation(
    Line(points = {{-9.4, -76}, {22.6, -76}}, color = {0, 0, 127}));
  connect(greaterThreshold2.y, switch2.u2) annotation(
    Line(points = {{7, -10}, {5.6, -10}, {5.6, -5}, {21.6, -5}, {21.6, -4}}, color = {255, 0, 255}));
  connect(greaterThreshold3.y, switch3.u2) annotation(
    Line(points = {{6.6, -50}, {6.6, -44}, {21.6, -44}}, color = {255, 0, 255}));
  connect(greaterThreshold4.y, switch4.u2) annotation(
    Line(points = {{6.6, -90}, {6.6, -84}, {19.6, -84}, {19.6, -83}, {21.6, -83}, {21.6, -84}}, color = {255, 0, 255}));
  connect(switch2.u3, const.y) annotation(
    Line(points = {{22, -12}, {9, -12}, {9, 57}}, color = {0, 0, 127}));
  connect(switch3.u3, const.y) annotation(
    Line(points = {{22, -52}, {9, -52}, {9, 57}}, color = {0, 0, 127}));
  connect(switch4.u3, const.y) annotation(
    Line(points = {{22, -92}, {9, -92}, {9, 57}}, color = {0, 0, 127}));
  connect(switch1.y, minMax.u[1]) annotation(
    Line(points = {{45, 82}, {71, 82}, {71, -5}}, color = {0, 0, 127}));
  connect(switch.y, minMax.u[2]) annotation(
    Line(points = {{45, 36}, {71, 36}, {71, -5}}, color = {0, 0, 127}));
  connect(switch2.y, minMax.u[3]) annotation(
    Line(points = {{45, -4}, {71, -4}}, color = {0, 0, 127}));
  connect(switch3.y, minMax.u[4]) annotation(
    Line(points = {{45, -44}, {71, -44}, {71, -4}}, color = {0, 0, 127}));
  connect(switch4.y, minMax.u[5]) annotation(
    Line(points = {{45, -84}, {71, -84}, {71, -4}}, color = {0, 0, 127}));
  connect(constant3.y, switch2.u1) annotation(
    Line(points = {{-9.4, 4}, {21.6, 4}}, color = {0, 0, 127}));
  connect(constant1.y, switch1.u1) annotation(
    Line(points = {{-9.4, 90}, {21.6, 90}}, color = {0, 0, 127}));
  connect(constant2.y, switch.u1) annotation(
    Line(points = {{-9.4, 44}, {21.6, 44}}, color = {0, 0, 127}));
  connect(greaterThreshold.u, add.y) annotation(
    Line(points = {{-3.2, 80}, {-29.5, 80}, {-29.5, 79}}, color = {0, 0, 127}));
  connect(combiTable1Ds.y[1], add.u1) annotation(
    Line(points = {{-59, 82}, {-41, 82}}, color = {0, 0, 127}));
  connect(add1.y, greaterThreshold1.u) annotation(
    Line(points = {{-28, 30}, {-8, 30}}, color = {0, 0, 127}));
  connect(add3.y, greaterThreshold2.u) annotation(
    Line(points = {{-28, -10}, {-8, -10}}, color = {0, 0, 127}));
  connect(add2.y, greaterThreshold3.u) annotation(
    Line(points = {{-28, -50}, {-8, -50}}, color = {0, 0, 127}));
  connect(add4.y, greaterThreshold4.u) annotation(
    Line(points = {{-28, -90}, {-8, -90}}, color = {0, 0, 127}));
  connect(combiTable1Ds1.y[1], add1.u1) annotation(
    Line(points = {{-60, 32}, {-38, 32}}, color = {0, 0, 127}));
  connect(combiTable1Ds2.y[1], add3.u1) annotation(
    Line(points = {{-60, -8}, {-38, -8}}, color = {0, 0, 127}));
  connect(combiTable1Ds3.y[1], add2.u1) annotation(
    Line(points = {{-60, -48}, {-38, -48}}, color = {0, 0, 127}));
  connect(combiTable1Ds4.y[1], add4.u1) annotation(
    Line(points = {{-60, -88}, {-38, -88}}, color = {0, 0, 127}));
  connect(combiTimeTable.y[1], NEDC_velocity) annotation(
    Line(points = {{103, -76}, {125, -76}}, color = {0, 0, 127}));
  connect(u, gain.u) annotation(
    Line(points = {{-139, 5}, {-115, 5}}, color = {0, 0, 127}));
  connect(gain.y, add.u2) annotation(
    Line(points = {{-103.5, 5}, {-50, 5}, {-50, 76}, {-40, 76}}, color = {0, 0, 127}));
  connect(gain.y, add4.u2) annotation(
    Line(points = {{-103.5, 5}, {-50, 5}, {-50, -94}, {-38, -94}}, color = {0, 0, 127}));
  connect(gain.y, add2.u2) annotation(
    Line(points = {{-103.5, 5}, {-50, 5}, {-50, -54}, {-38, -54}}, color = {0, 0, 127}));
  connect(gain.y, add3.u2) annotation(
    Line(points = {{-103.5, 5}, {-50, 5}, {-50, -14}, {-38, -14}}, color = {0, 0, 127}));
  connect(gain.y, add1.u2) annotation(
    Line(points = {{-103.5, 5}, {-50, 5}, {-50, 26}, {-38, 26}}, color = {0, 0, 127}));
  connect(const1.y, gain1.u) annotation(
    Line(points = {{-127, 82}, {-121, 82}, {-121, 81}, {-113, 81}}, color = {0, 0, 127}));
  connect(gain1.y, combiTable1Ds.u) annotation(
    Line(points = {{-101.5, 81}, {-88, 81}, {-88, 82}, {-74, 82}}, color = {0, 0, 127}));
  connect(combiTable1Ds1.u, gain1.y) annotation(
    Line(points = {{-74, 32}, {-88, 32}, {-88, 81}, {-101.5, 81}}, color = {0, 0, 127}));
  connect(combiTable1Ds2.u, gain1.y) annotation(
    Line(points = {{-74, -8}, {-88, -8}, {-88, 81}, {-101.5, 81}}, color = {0, 0, 127}));
  connect(combiTable1Ds3.u, gain1.y) annotation(
    Line(points = {{-74, -48}, {-88, -48}, {-88, 81}, {-101.5, 81}}, color = {0, 0, 127}));
  connect(combiTable1Ds4.u, gain1.y) annotation(
    Line(points = {{-74, -88}, {-88, -88}, {-88, 81}, {-101.5, 81}}, color = {0, 0, 127}));
  connect(minMax.yMax, gear) annotation(
    Line(points = {{112, 8}, {134, 8}}, color = {0, 0, 127}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
end abc_gear;
