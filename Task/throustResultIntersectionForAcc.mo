within VehicleInterfaces.Task;
model throustResultIntersectionForAcc

  parameter Integer rows = 9 "input array rows";
  parameter Integer columns = 9 "input array columns";
//  parameter Integer gearStart = 1 "gear at vehicle start up";
  Modelica.Blocks.Interfaces.RealVectorInput velocityIn[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput dynamicFactorIn[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput velocityOut[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput dynamicFactorOut[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
//  Modelica.Blocks.Interfaces.RealVectorOutput velocityOut[rows - gearStart + 1,columns] annotation (
//    Placement(visible = true, transformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
//  Modelica.Blocks.Interfaces.RealVectorOutput dynamicFactorOut[rows - gearStart + 1,columns] annotation (
//    Placement(visible = true, transformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

protected 
  Real x0;
  Real x;
  Real y;
algorithm 
  x0 := velocityIn[1,1];
//  x0 := velocityIn[gearStart,1];
  for i in 1:rows - 1 loop
//  for i in gearStart:rows - 1 loop 
    (x,y) := Blocks.intersectionWithTwoCurves(
      velocityIn[i], dynamicFactorIn[i], velocityIn[i + 1], dynamicFactorIn[i + 1]);
//    velocityOut[i - gearStart + 1,:] := linspace(x0, x, columns);
    for j in 1:columns loop 
      velocityOut[i,j] := x0 + (j-1)*(x-x0)/(columns-1);
      dynamicFactorOut[i,j] := Modelica.Math.Vectors.interpolate(velocityIn[i], dynamicFactorIn[i], velocityOut[i,j]);
//      velocityOut[i - gearStart + 1,j] := x0 + (j-1)*(x-x0)/(columns-1);
//      dynamicFactorOut[i - gearStart + 1,j] := Modelica.Math.Vectors.interpolate(velocityIn[i], dynamicFactorIn[i], velocityOut[i - gearStart + 1,j]);
    end for;
    x0 := x;
  end for;
//  velocityOut[end,:] := linspace(x0, velocityIn[end,end], columns);
  for j in 1:columns loop 
    velocityOut[end,j] := x0+(j-1)*(velocityIn[end,end]-x0)/(columns-1);
    dynamicFactorOut[end,j] := Modelica.Math.Vectors.interpolate(velocityIn[end], dynamicFactorIn[end], velocityOut[end,j]);
  end for;
end throustResultIntersectionForAcc;
