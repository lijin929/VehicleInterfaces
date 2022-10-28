within VehicleInterfaces.Task;
model throustResultWithTC

  parameter Integer sizeAT[2] = {9, 9} "AT input array size";
  parameter Integer sizeMT[2] = {9, 9} "MT input array size";
  parameter Integer gearTC = 1 "max gear at torque converter work";
  Modelica.Blocks.Interfaces.RealVectorInput velocityAT[sizeAT[1],sizeAT[2]] annotation (
    Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput dynamicFactorAT[sizeAT[1],sizeAT[2]] annotation (
    Placement(visible = true, transformation(origin = {-100, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput velocityMT[sizeMT[1],sizeMT[2]] annotation (
    Placement(visible = true, transformation(origin = {-100, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput dynamicFactorMT[sizeMT[1],sizeMT[2]] annotation (
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput velocityOut[sizeMT[1],sizeMT[2]] annotation (
    Placement(visible = true, transformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput dynamicFactorOut[sizeMT[1],sizeMT[2]] annotation (
    Placement(visible = true, transformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));


algorithm   
  if gearTC == 1 then 
    //velocityOut[1] := linspace(velocityAT[1,1], velocityAT[1,end], size(velocityMT,2));
    for j in 1:size(velocityMT,2) loop 
      velocityOut[1,j] := velocityAT[1,1]+(j-1)*(velocityAT[1,end]-velocityAT[1,1])/(size(velocityMT,2)-1);
      dynamicFactorOut[1,j] := Modelica.Math.Vectors.interpolate(velocityAT[1], dynamicFactorAT[1], velocityOut[1,j]);
    end for;
  else
    for i in 1:gearTC loop 
      //velocityOut[i] := linspace(velocityAT[i,1], velocityAT[i,end], size(velocityMT,2));
      for j in 1:size(velocityMT,2) loop 
        velocityOut[i,j] := velocityAT[i,1]+(j-1)*(velocityAT[i,end]-velocityAT[i,1])/(size(velocityMT,2)-1);
        dynamicFactorOut[i,j] := Modelica.Math.Vectors.interpolate(velocityAT[i], dynamicFactorAT[i], velocityOut[i,j]);
      end for;
    end for;
  end if;


  for i in gearTC + 1:size(velocityMT,1) loop 
    for j in 1:size(velocityMT,2) loop 
      velocityOut[i,j] := velocityMT[i,j];
      dynamicFactorOut[i,j] := dynamicFactorMT[i,j];
    end for;
  end for;

end throustResultWithTC;
