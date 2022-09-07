within VehicleInterfaces.Controllers;

model ControllerAT "AT controller with shiffting map based on accelerator pedal position and vehicle speed "
  extends VehicleInterfaces.Icons.Controller;
  extends Interfaces.Base;
  VehicleInterfaces.Interfaces.TransmissionBus transmissionBus annotation(
    Placement(visible = true, transformation(extent = {{-10, -50}, {10, -30}}, rotation = 0), iconTransformation(extent = {{-30, 50}, {-10, 70}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant gearCMD(k = 3)  annotation(
    Placement(visible = true, transformation(origin = {74, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(transmissionBus, controlBus.transmissionBus) annotation(
    Line(points = {{0, -40}, {0, -100}}, thickness = 0.5));
  connect(gearCMD.y, transmissionBus.gearCMD) annotation(
    Line(points = {{64, -40}, {0, -40}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html>
<p>

</p>
</html>"));
end ControllerAT;
