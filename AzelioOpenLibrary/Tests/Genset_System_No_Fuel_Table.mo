within AzelioOpenLibrary.Tests;

model Genset_System_No_Fuel_Table "Genset model with unknown fuel consumption as function of load"
  extends AzelioOpenLibrary.Icons.ExampleIcon;
  Modelica.Blocks.Tables.CombiTable1Ds Demand(tableOnFile = true, tableName = "Demand", fileName = "dem_rand_25.txt") annotation(Placement(visible = true, transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Hourly_input(y = time / 3600) annotation(Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AzelioOpenLibrary.Gensets.Diesel_Generator_No_Fuel_Table Diesel_Generator_No_Fuel_Table_(P_Nom = 25, min_load = 0.2) annotation(Placement(visible = true, transformation(origin = {0, 10}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(Hourly_input.y, Demand.u) annotation(Line(visible = true, origin = {-70.5, 10}, points = {{-8.5, 0}, {8.5, 0}}, color = {1, 37, 163}));
  connect(Demand.y[1], Diesel_Generator_No_Fuel_Table_.P_dem) annotation(Line(visible = true, origin = {-28.5, 10}, points = {{-10.5, 0}, {10.5, 0}}, color = {1, 37, 163}));
  annotation(Documentation(info = "<p>Model of the power output of a diesel generator as function of the demand. It calculates efficiency and fuel consumption, with generic formule.</p>
<p>&nbsp;</p>", revisions = ""), experiment(StopTime = 31536000, NumberOfIntervals = 8760, __Wolfram_Algorithm = "cvodes", __Wolfram_SynchronizeWithRealTime = false), Diagram(coordinateSystem(extent = {{-120, -40}, {60, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end Genset_System_No_Fuel_Table;
