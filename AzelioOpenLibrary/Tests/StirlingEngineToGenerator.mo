within AzelioOpenLibrary.Tests;

model StirlingEngineToGenerator
  extends AzelioOpenLibrary.Icons.ExampleIcon;
  Modelica.Blocks.Sources.Constant HTCC(k = 8000) annotation(Placement(visible = true, transformation(origin = {-10, -60}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant HTCH(k = 18000) annotation(Placement(visible = true, transformation(origin = {-130, -20}, extent = {{10, 10}, {-10, -10}}, rotation = -180)));
  Modelica.Blocks.Sources.Constant pmeInput(k = 125) annotation(Placement(visible = true, transformation(origin = {25, 51.837}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant nshaftInput(k = 1800) annotation(Placement(visible = true, transformation(origin = {-75, 80}, extent = {{-10, -10}, {10, 10}}, rotation = -360)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Qh_temp(T(displayUnit = "K") = 836) annotation(Placement(visible = true, transformation(origin = {-130, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Qc_temp(T(displayUnit = "K") = 305) annotation(Placement(visible = true, transformation(origin = {-70, -60}, extent = {{-10, -10}, {10, 10}}, rotation = -360)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Qloss_temp(T = 305.15) annotation(Placement(visible = true, transformation(origin = {31.686, -60.78}, extent = {{10, -10}, {-10, 10}}, rotation = 720)));
  PowerCycleModels.StirlingGasChannel8_6_19 stirlingGasChannel8_6_19 annotation(Placement(visible = true, transformation(origin = {-39.229, 0}, extent = {{-24.229, -24.229}, {24.229, 24.229}}, rotation = 0)));
  LossModels.GenericLoss genericLoss annotation(Placement(visible = true, transformation(origin = {45, -0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ElectricalModels.GenericGenerator genericGenerator annotation(Placement(visible = true, transformation(origin = {106.923, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(nshaftInput.y, stirlingGasChannel8_6_19.nshaft) annotation(Line(visible = true, origin = {-52.65, 61.41}, points = {{-11.35, 18.59}, {5.675, 18.59}, {5.675, -37.181}}, color = {1, 37, 163}));
  connect(pmeInput.y, stirlingGasChannel8_6_19.pme) annotation(Line(visible = true, origin = {-16.64, 42.509}, points = {{30.64, 9.327}, {-15.32, 9.327}, {-15.32, -18.655}}, color = {1, 37, 163}));
  connect(genericLoss.Wshaft, genericGenerator.Wshaft) annotation(Line(visible = true, origin = {80.806, 0.478}, points = {{-12.353, -0.478}, {3.118, -0.478}, {3.118, 0.478}, {6.118, 0.478}}, color = {1, 37, 163}));
  connect(genericLoss.nshaft, nshaftInput.y) annotation(Line(visible = true, origin = {20.877, 38}, points = {{4.632, -22}, {-20.877, -22}, {-20.877, 42}, {-84.877, 42}}, color = {1, 37, 163}));
  connect(genericLoss.pme, pmeInput.y) annotation(Line(visible = true, origin = {-3.8, 30}, points = {{29.344, -21.456}, {-1.2, -21.456}, {-1.2, 21.837}, {17.8, 21.837}}, color = {1, 37, 163}));
  connect(genericLoss.Wt, stirlingGasChannel8_6_19.Wt) annotation(Line(visible = true, origin = {5.257, -0}, points = {{20.257, -0}, {-20.257, 0}}, color = {1, 37, 163}));
  connect(Qc_temp.port, stirlingGasChannel8_6_19.Qc_port) annotation(Line(visible = true, origin = {-49.383, -48.076}, points = {{-10.617, -11.924}, {5.308, -11.924}, {5.308, 23.847}}, color = {191, 0, 0}));
  connect(Qh_temp.port, stirlingGasChannel8_6_19.Qh_port) annotation(Line(visible = true, origin = {-92.509, 12.749}, points = {{-27.491, 7.251}, {12.509, 7.251}, {12.509, -7.251}, {28.544, -7.251}}, color = {191, 0, 0}));
  connect(HTCC.y, stirlingGasChannel8_6_19.HTCc) annotation(Line(visible = true, origin = {-34.181, -40.903}, points = {{13.181, -19.097}, {1.892, -19.097}, {1.892, 24.097}, {2.22, 19.097}}, color = {1, 37, 163}));
  connect(stirlingGasChannel8_6_19.Q_losses_port, Qloss_temp.port) annotation(Line(visible = true, origin = {11.008, -42.231}, points = {{-26.008, 18.549}, {7.665, 18.549}, {7.665, -18.549}, {10.678, -18.549}}, color = {191, 0, 0}));
  connect(HTCH.y, stirlingGasChannel8_6_19.HTCh) annotation(Line(visible = true, origin = {-92.204, -12.283}, points = {{-26.796, -7.717}, {12.204, -7.283}, {12.204, 7.283}, {29.472, 6.849}}, color = {1, 37, 163}));
  annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end StirlingEngineToGenerator;
