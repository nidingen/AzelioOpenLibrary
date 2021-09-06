within AzelioOpenLibrary.Tests;

model Battery_System
  extends AzelioOpenLibrary.Icons.ExampleIcon;
  Modelica.Blocks.Sources.RealExpression Hourly_input(y = time / 3600) annotation(Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds Power_Flow(tableOnFile = true, tableName = "Net", fileName = "Net.txt", columns = 2:2) annotation(Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  AzelioOpenLibrary.ElectricalModels.GenericInverter Inverter_ annotation(Placement(visible = true, transformation(origin = {20, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds TMY(tableOnFile = true, tableName = "TMY", fileName = "TMY_2005.txt", columns = 2:9) annotation(Placement(visible = true, transformation(origin = {-40, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_degC Temperature_Converter annotation(Placement(visible = true, transformation(origin = {20, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AzelioOpenLibrary.ElectricalModels.Battery Battery_ annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(Hourly_input.y, Power_Flow.u) annotation(Line(visible = true, origin = {-71.5, 0}, points = {{-7.5, 0}, {7.5, 0}}, color = {1, 37, 163}));
  connect(Power_Flow.y[1], Inverter_.P_in) annotation(Line(visible = true, origin = {-9, 0}, points = {{-9, 0}, {9, 0}}, color = {1, 37, 163}));
  connect(Hourly_input.y, TMY.u) annotation(Line(visible = true, origin = {-73.25, 30}, points = {{-5.75, -30}, {-1.75, -30}, {-1.75, 30}, {9.25, 30}}, color = {1, 37, 163}));
  connect(TMY.y[4], Temperature_Converter.u) annotation(Line(visible = true, origin = {-5, 60}, points = {{-13, 0}, {13, 0}}, color = {1, 37, 163}));
  connect(Inverter_.P_out, Battery_.P_Net) annotation(Line(visible = true, origin = {50.019, 0}, points = {{-10.019, 0}, {10.019, 0}}, color = {1, 37, 163}));
  connect(Temperature_Converter.y, Battery_.T_Amb) annotation(Line(visible = true, origin = {70.333, 46.667}, points = {{-39.333, 13.333}, {19.667, 13.333}, {19.667, -26.667}}, color = {1, 37, 163}));
  connect(TMY.y[8], Battery_.p) annotation(Line(visible = true, origin = {47, 36.667}, points = {{-65, 23.333}, {-57, 23.333}, {-57, 3.333}, {23, 3.333}, {23, -16.667}}, color = {1, 37, 163}));
  annotation(Documentation(info = "<p>This model simulates a battery system: it calculates the power flow in and out of the storage based on TMY data (temperature and pressure) and power demand and supply.&nbsp;</p>
<p>The battery performance is idealised and the thermal behaviour is simualted as well.</p>
<p>&nbsp;</p>", revisions = ""), experiment(StopTime = 172800, Interval = 1, __Wolfram_Algorithm = "cvodes", Tolerance = 1e-6), Diagram(coordinateSystem(extent = {{-120, -40}, {120, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end Battery_System;
