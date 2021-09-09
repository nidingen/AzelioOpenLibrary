within AzelioOpenLibrary.Examples;

model WindFarm
  extends AzelioOpenLibrary.Icons.ExampleIcon;
  Modelica.Blocks.Sources.RealExpression Hourly_input(y = time / 3600) annotation(Placement(visible = true, transformation(origin = {-107.667, -15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds TMY(tableOnFile = false, tableName = "TMY", fileName = "TMY_2014.txt", columns = 2:8, table = {{0.0, 0.0, 0.0, 7.235, 0.0, -169.5, 988.8, 6.584}, {1.0, 0.0, 0.0, 7.082, 0.0, -143.2, 988.8, 7.167}, {2.0, 0.0, 0.0, 6.8, 0.0, -117.2, 988.8, 7.634}, {3.0, 0.0, 0.0, 6.633, 0.0, -103.2, 988.8, 8.083}, {4.0, 0.0, 0.0, 6.781, 0.0, -93.5, 988.8, 9.102}, {5.0, 0.0, 0.0, 6.335, 0.0, -86.1, 988.8, 10.252}, {6.0, 0.0, 0.0, 4.915, 0.0, -78.5, 988.8, 11.269}, {7.0, 12.0, 0.0, 3.857, 2.5, -71.2, 988.8, 11.863}, {8.0, 101.0, 415.0, 4.424, 14.3, -62.5, 988.8, 12.753}, {9.0, 69.0, 766.0, 5.603, 25.2, -52.4, 988.8, 13.417}, {10.0, 88.0, 827.0, 6.791, 34.5, -39.5, 988.8, 13.642}, {11.0, 102.0, 861.0, 8.356, 41.3, -23.3, 988.8, 13.744}, {12.0, 106.0, 881.0, 9.602, 44.4, -4, 988.8, 13.653}, {13.0, 103.0, 877.0, 10.317, 43.1, 15.6, 988.8, 13.29}, {14.0, 83.0, 880.0, 10.523, 37.6, 33.4, 988.8, 12.745}, {15.0, 62.0, 859.0, 10.028, 29.2, 47.5, 988.8, 11.713}, {16.0, 49.0, 777.0, 8.712999999999999, 18.8, 59, 988.8, 10.604}, {17.0, 40.0, 476.0, 6.437, 7.3, 68.1, 988.8, 8.966}, {18.0, 0.0, 0.0, 4.167, 0.0, 75.6, 988.8, 7.514}, {19.0, 0.0, 0.0, 2.733, 0.0, 83.1, 988.8, 6.909}, {20.0, 0.0, 0.0, 1.787, 0.0, 90.4, 988.8, 6.232}, {21.0, 0.0, 0.0, 1.279, 0.0, 99.2, 988.9, 6.056}, {22.0, 0.0, 0.0, 0.801, 0.0, 110.6, 988.9, 5.905}, {23.0, 0.0, 0.0, 0.449, 0.0, 130.4, 988.9, 5.628}, {24.0, 0.0, 0.0, 0.371, 0.0, -169.6, 988.9, 5.448}}) "TMY data at location" annotation(Placement(visible = true, transformation(origin = {-70, -15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AzelioOpenLibrary.WindTurbines.LogWindProfile Wind_shear_(h = 80) annotation(Placement(visible = true, transformation(origin = {-50, 15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  WindTurbines.Wind_turbine Wind_turbine(P_Nom(displayUnit = "kW") = 850000, D = 52, v_cof = 25, v_cin = 4) "Model of a wind turbine based on power coefficient curve" annotation(Placement(visible = true, transformation(origin = {30, 0}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  WindTurbines.Wind_farm Wind_farm(turb = 0.05, CWS = 5, N_WT = 5) annotation(Placement(visible = true, transformation(origin = {110, 0}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  WindTurbines.Data.Vestas_V52 vestas_V52 annotation(Placement(visible = true, transformation(origin = {-10, 55}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Hourly_input.y, TMY.u) annotation(Line(visible = true, origin = {-89.333, -15}, points = {{-7.333, 0}, {7.333, 0}}, color = {1, 37, 163}));
  connect(TMY.y[7], Wind_shear_.v) annotation(Line(visible = true, origin = {-53, -8}, points = {{-6, -7}, {3, -7}, {3, 14}}, color = {1, 37, 163}));
  connect(TMY.y[3], Wind_turbine.T_Amb) "Ambient Temperature at location [degC]" annotation(Line(visible = true, origin = {-29.5, -15}, points = {{-29.5, 0}, {9.254, 0}, {9.254, 15}, {29.5, 15}}, color = {1, 37, 163}));
  connect(TMY.y[6], Wind_turbine.p) annotation(Line(visible = true, origin = {-29.5, -15}, points = {{-29.5, 0}, {29.5, 0}}, color = {1, 37, 163}));
  connect(Wind_turbine.E_WT, Wind_farm.E_WT) annotation(Line(visible = true, origin = {70, 15}, points = {{-10, 0}, {10, 0}}, color = {1, 37, 163}));
  connect(Wind_shear_.v_h, Wind_turbine.v_h) annotation(Line(visible = true, origin = {-19.5, 15}, points = {{-19.5, 0}, {19.5, 0}}, color = {1, 37, 163}));
  connect(Wind_shear_.hh, Wind_turbine.h) annotation(Line(visible = true, origin = {17.4, 76.2}, points = {{-67.4, -50.2}, {-67.4, -6.2}, {27.6, -6.2}, {27.6, -49.2}}, color = {1, 37, 163}));
  connect(Wind_turbine.P_WT, Wind_farm.P_WT) annotation(Line(visible = true, origin = {70, -15}, points = {{-10, 0}, {10, 0}}, color = {1, 37, 163}));
  connect(Wind_shear_.v_h, vestas_V52.u) annotation(Line(visible = true, origin = {-31.701, 35}, points = {{-7.299, -20}, {-2.299, -20}, {-2.299, 20}, {11.898, 20}}, color = {1, 37, 163}));
  connect(vestas_V52.y, Wind_turbine.Cp) annotation(Line(visible = true, origin = {10.094, 45.667}, points = {{-9.812, 9.333}, {4.906, 9.333}, {4.906, -18.667}}, color = {1, 37, 163}));
  annotation(experiment(StopTime = 86400, Interval = 180, __Wolfram_Algorithm = "cvodes", __Wolfram_SynchronizeWithRealTime = false), Documentation(info = "<p>This model simulates the power output and energy yield of a wind farm&nbsp;by knowing TMY data and technical specifications of the wind turbine model and wind turbine layout.&nbsp;</p>", revisions = ""), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10})), Diagram(coordinateSystem(extent = {{-140, -50}, {160, 90}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end WindFarm;