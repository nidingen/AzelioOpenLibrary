within AzelioOpenLibrary.Tests;

model WindFarm
  extends AzelioOpenLibrary.Icons.ExampleIcon;
  AzelioOpenLibrary.WindTurbines.Wind_turbine Wind_turbine_(P_Nom(displayUnit = "kW") = 850000, D = 52, v_cof = 25, v_cin = 4) "Model of a wind turbine based on power coefficient curve" annotation(Placement(visible = true, transformation(origin = {30, 0}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Hourly_input(y = time / 3600) annotation(Placement(visible = true, transformation(origin = {-107.667, -15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds TMY(tableOnFile = true, tableName = "TMY", fileName = "TMY_2014.txt", columns = 2:8) "TMY data at location" annotation(Placement(visible = true, transformation(origin = {-70, -15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AzelioOpenLibrary.WindTurbines.Wind_farm Wind_farm_(turb = 0.05, CWS = 5, N_WT = 5) annotation(Placement(visible = true, transformation(origin = {110, 0}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  AzelioOpenLibrary.WindTurbines.LogWindProfile Wind_shear_(h = 80) annotation(Placement(visible = true, transformation(origin = {-50, 15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AzelioOpenLibrary.WindTurbines.Data.Vestas_V52 vestas_V52_1 annotation(Placement(visible = true, transformation(origin = {-10, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Hourly_input.y, TMY.u) annotation(Line(visible = true, origin = {-89.333, -15}, points = {{-7.333, 0}, {7.333, 0}}, color = {1, 37, 163}));
  connect(TMY.y[3], Wind_turbine_.T_Amb) "Ambient Temperature at location [degC]" annotation(Line(visible = true, origin = {-29.5, -15}, points = {{-29.5, 0}, {9.254, 0}, {9.254, 15}, {29.5, 15}}, color = {1, 37, 163}));
  connect(Wind_turbine_.P_WT, Wind_farm_.P_WT) annotation(Line(visible = true, origin = {70, -15}, points = {{-10, 0}, {10, 0}}, color = {1, 37, 163}));
  connect(Wind_turbine_.E_WT, Wind_farm_.E_WT) annotation(Line(visible = true, origin = {70, 15}, points = {{-10, 0}, {10, 0}}, color = {1, 37, 163}));
  connect(Wind_shear_.hh, Wind_turbine_.h) annotation(Line(visible = true, origin = {17.4, 76.2}, points = {{-67.4, -50.2}, {-67.4, -6.2}, {27.6, -6.2}, {27.6, -49.2}}, color = {1, 37, 163}));
  connect(Wind_shear_.v_h, Wind_turbine_.v_h) annotation(Line(visible = true, origin = {-19.5, 15}, points = {{-19.5, 0}, {19.5, 0}}, color = {1, 37, 163}));
  connect(TMY.y[6], Wind_turbine_.p) annotation(Line(visible = true, origin = {-29.5, -15}, points = {{-29.5, 0}, {29.5, 0}}, color = {1, 37, 163}));
  connect(TMY.y[7], Wind_shear_.v) annotation(Line(visible = true, origin = {-53, -8}, points = {{-6, -7}, {3, -7}, {3, 14}}, color = {1, 37, 163}));
  connect(Wind_shear_.v_h, vestas_V52_1.u) annotation(Line(visible = true, origin = {-30.25, 32.5}, points = {{-8.75, -17.5}, {0.25, -17.5}, {0.25, 17.5}, {8.25, 17.5}}, color = {1, 37, 163}));
  connect(vestas_V52_1.y[1], Wind_turbine_.Cp) annotation(Line(visible = true, origin = {10.333, 42.333}, points = {{-9.333, 7.667}, {4.667, 7.667}, {4.667, -15.333}}, color = {1, 37, 163}));
  annotation(experiment(StopTime = 31536000, NumberOfIntervals = 8760, __Wolfram_Algorithm = "cvodes", __Wolfram_SynchronizeWithRealTime = false), Documentation(info = "<p>This model simulates the power output and energy yield of a wind farm&nbsp;by knowing TMY data and technical specifications of the wind turbine model and wind turbine layout.&nbsp;</p>", revisions = ""), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10})), Diagram(coordinateSystem(extent = {{-140, -50}, {160, 90}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end WindFarm;
