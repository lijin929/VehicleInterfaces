within VehicleInterfaces.Transmissions;

model LossyGearWithInput
  extends Modelica.Mechanics.Rotational.Icons.Gear;
  extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
  Modelica.Blocks.Interfaces.RealInput RealInput[2] annotation(
    Placement(visible = true, transformation(origin = {-50, 120}, extent = {{20, -20}, {-20, 20}}, rotation = 90), iconTransformation(origin = {-90, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  VehicleInterfaces.Transmissions.LossyGear lossyGear(useSupport = true)  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  Real lossTable[:, 5] = [0, RealInput[2], 1, 0, 0];
equation
  connect(flange_a, lossyGear.flange_a) annotation(
    Line(points = {{-100, 0}, {-10, 0}}));
  connect(lossyGear.flange_b, flange_b) annotation(
    Line(points = {{10, 0}, {100, 0}}));
  connect(lossyGear.support, support) annotation(
    Line(points = {{0, -10}, {0, -100}}));
  connect(RealInput[1], lossyGear.ratio) annotation(
    Line(points = {{-50, 120}, {-50, 8}, {-12, 8}}, color = {0, 0, 127}));
  lossyGear.lossTable = lossTable;
annotation(
    Icon(graphics = {Text(origin = {0, -2}, lineColor = {0, 0, 255}, extent = {{-148, 105}, {152, 145}}, textString = "%name")}));
end LossyGearWithInput;
