within AzelioOpenLibrary.Examples;

model Genset_System_Fuel_Table
  extends AzelioOpenLibrary.Icons.ExampleIcon;
  Modelica.Blocks.Tables.CombiTable1Ds Demand(tableOnFile = false, tableName = "Demand", fileName = "dem_rand_25.txt", table = {{0, 17}, {1, 11}, {2, 23}, {3, 22}, {4, 20}, {5, 24}, {6, 2}, {7, 11}, {8, 21}, {9, 23}, {10, 2}, {11, 13}, {12, 20}, {13, 5}, {14, 22}, {15, 22}, {16, 1}, {17, 15}, {18, 20}, {19, 9}, {20, 15}, {21, 4}, {22, 7}, {23, 15}, {24, 20}}) annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Hourly_input(y = time / 3600) annotation(Placement(visible = true, transformation(origin = {-35, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AzelioOpenLibrary.Gensets.Diesel_Generator_Fuel_Table diesel_Generator_Fuel_Table1(min_load = 0.25, P_Nom = 400) annotation(Placement(visible = true, transformation(origin = {45.471, 7.406}, extent = {{-14.529, -14.529}, {14.529, 14.529}}, rotation = 0)));
equation
  connect(Hourly_input.y, Demand.u) annotation(Line(visible = true, origin = {-18, 0}, points = {{-6, 0}, {6, 0}}, color = {1, 37, 163}));
  connect(Demand.y[1], diesel_Generator_Fuel_Table1.P_dem) annotation(Line(visible = true, origin = {18.667, 0.07}, points = {{-7.667, -0.07}, {-2.667, -0.07}, {-2.667, 0.07}, {13.001, 0.07}}, color = {1, 37, 163}));
  annotation(experiment(StopTime = 86400, Interval = 180, __Wolfram_Algorithm = "cvodes", __Wolfram_SynchronizeWithRealTime = false), Placement(visible = true, transformation(origin = {-10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)), Documentation(info = "<p>This model calculates fuel consumption and power output from a diesel generator. It requires values from fuel consumption table from manufacturer data sheet and hourly power demand.</p>
<p>&nbsp;</p>", revisions = ""), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10})), Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end Genset_System_Fuel_Table;
