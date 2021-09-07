within AzelioOpenLibrary.Tests;

model Genset_System_Fuel_Table
  extends AzelioOpenLibrary.Icons.ExampleIcon;
  Modelica.Blocks.Tables.CombiTable1Ds Demand(tableOnFile = false, tableName = "Demand", fileName = "dem_rand_25.txt", table = {{0, 17}, {1, 11}, {2, 23}, {3, 22}, {4, 20}, {5, 24}, {6, 2}, {7, 11}, {8, 21}, {9, 23}, {10, 2}, {11, 13}, {12, 20}, {13, 5}, {14, 22}, {15, 22}, {16, 1}, {17, 15}, {18, 20}, {19, 9}, {20, 15}, {21, 4}, {22, 7}, {23, 15}, {24, 20}}) annotation(Placement(visible = true, transformation(origin = {-90, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Hourly_input(y = time / 3600) annotation(Placement(visible = true, transformation(origin = {-130, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AzelioOpenLibrary.Gensets.Fuel_Consumption Fuel_Consumption_(table = {{0, 33.9 / 3600}, {0.25, 33.9 / 3600}, {0.5, 59.9 / 3600}, {0.75, 84.0 / 3600}, {1.0, 106.6 / 3600}}) annotation(Placement(visible = true, transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AzelioOpenLibrary.Gensets.Fuel_Power_Table fuel_Power_Table1(P_Nom = 400) annotation(Placement(visible = true, transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AzelioOpenLibrary.Gensets.Diesel_Generator_Fuel_Table diesel_Generator_Fuel_Table1(min_load = 0.25) annotation(Placement(visible = true, transformation(origin = {50, -5}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
equation
  connect(Hourly_input.y, Demand.u) annotation(Line(visible = true, origin = {-110.5, -20}, points = {{-8.5, 0}, {8.5, 0}}, color = {1, 37, 163}));
  connect(Demand.y[1], diesel_Generator_Fuel_Table1.P_dem) annotation(Line(visible = true, origin = {-28.75, -20}, points = {{-50.25, -0}, {50.25, 0}}, color = {1, 37, 163}));
  connect(Demand.y[1], fuel_Power_Table1.P_dem) annotation(Line(visible = true, origin = {-69.625, -5}, points = {{-9.375, -15}, {-0.375, -15}, {-0.375, 15}, {10.125, 15}}, color = {1, 37, 163}));
  connect(fuel_Power_Table1.pnom, diesel_Generator_Fuel_Table1.P_Nom) annotation(Line(visible = true, origin = {0, 33.5}, points = {{-50, -13}, {-50, 11.5}, {50, 11.5}, {50, -10}}, color = {1, 37, 163}));
  connect(fuel_Power_Table1.k, Fuel_Consumption_.u) annotation(Line(visible = true, origin = {-30.75, 10}, points = {{-8.75, 0}, {8.75, -0}}, color = {1, 37, 163}));
  connect(Fuel_Consumption_.y[1], diesel_Generator_Fuel_Table1.FC_tab) annotation(Line(visible = true, origin = {11.25, 10}, points = {{-10.25, -0}, {10.25, 0}}, color = {1, 37, 163}));
  annotation(Placement(visible = true, transformation(origin = {-10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)), Documentation(info = "<p>This model calculates fuel consumption and power output from a diesel generator. It requires values from fuel consumption table from manufacturer data sheet and hourly power demand.</p>
<p>&nbsp;</p>", revisions = ""), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10})), experiment(StopTime = 31536000, NumberOfIntervals = 8760, __Wolfram_Algorithm = "cvodes", __Wolfram_SynchronizeWithRealTime = false), Diagram(coordinateSystem(extent = {{-160, -60}, {120, 80}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end Genset_System_Fuel_Table;
