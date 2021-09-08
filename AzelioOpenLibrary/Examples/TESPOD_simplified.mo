within AzelioOpenLibrary.Examples;

model TESPOD_simplified "eTES unit with updated Stirling engine"
  //Inputs
  //Parameters
  //parameter Real storageTempThreshold(unit = "K", displayUnit = "degC") = 898.15 "Temperature threshold for storage";
  parameter Real Max_Heater_Power(unit = "W", displayUnit = "kW") = 100000 "Constant output value";
  // Components
  EnergyStorage.ContainerWithStorage containerWithStorage1(Tinit(displayUnit = "degC") = 850.075, Ahtfw = 4.0, thtfw = 0.002, khtfw = 16, krecw = 16, trecw = 0.003, Aambw = 11.5, kambw = 16, tambw = 0.002, Aambis = 11.5, kambis = 0.11, tambis = 0.275, Toffset1 = 0.25, useAmbientLoss = true, Arecw = 1.13, Tm1.displayUnit = "degC", Tref1.displayUnit = "K") annotation(Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PowerCycleModels.StirlingGasChannel8_6_19 stirlingEngineGasChannel(E_Qh.fixed = false, E_wt.fixed = false, Wt.fixed = false, Th.fixed = false, Tc.fixed = false, E_wt.displayUnit = "kWh", E_Qh.displayUnit = "kWh", Wt.displayUnit = "MW") annotation(Placement(visible = true, transformation(origin = {101.747, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  LossModels.GenericLoss mech_fric_and_aux annotation(Placement(visible = true, transformation(origin = {160, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ElectricalModels.GenericGenerator generator annotation(Placement(visible = true, transformation(origin = {220, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ElectricalModels.GenericInverter inverter(usePnomInput = false) annotation(Placement(visible = true, transformation(origin = {277.913, -0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation(Placement(visible = true, transformation(origin = {40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = -360)));
  ThermalModels.genericHeatResistance genericHeatResistance2 annotation(Placement(visible = true, transformation(origin = {40, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermalModels.SimplifiedCooling simplifiedCooling1 annotation(Placement(visible = true, transformation(origin = {100, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Gain heaterControlLoss(k = 1 - 0.0067) annotation(Placement(visible = true, transformation(origin = {-150, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalModels.genericHeatResistance genericHeatResistance1(Ghtf = 3000, HTC = 0) annotation(Placement(visible = true, transformation(origin = {-73.01, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1 annotation(Placement(visible = true, transformation(origin = {-115, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Utilities.StartTime startTime1 annotation(Placement(visible = true, transformation(origin = {-205, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // Sources
  inner Modelica.Fluid.System system(T_ambient = 293.15, p_ambient = 99900) annotation(Placement(transformation(extent = {{-160, 80}, {-140, 100}}, origin = {-20, -20}, rotation = 0), visible = true));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T = 333.15) annotation(Placement(visible = true, transformation(origin = {-42.606, 62.232}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // Conversions
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin annotation(Placement(visible = true, transformation(origin = {2.102, -80}, extent = {{-10, -10}, {10, 10}}, rotation = -360)));
  //Outputs
  Modelica.Blocks.Tables.CombiTable1Ds AmbientTemperatureTable(table = {{0.0, 8.2}, {1.0, 8.0}, {2.0, 7.9}, {3.0, 7.8}, {4.0, 7.7}, {5.0, 7.7}, {6.0, 7.7}, {7.0, 7.9}, {8.0, 10.3}, {9.0, 13}, {10.0, 15.5}, {11.0, 17.6}, {12.0, 19.2}, {13.0, 20.2}, {14.0, 20.6}, {15.0, 20.3}, {16.0, 19.1}, {17.0, 17.4}, {18.0, 16.4}, {19.0, 15.5}, {20.0, 14.6}, {21.0, 13.6}, {22.0, 12.7}, {23.0, 11.7}, {24.0, 10.6}}) annotation(Placement(visible = true, transformation(origin = {-75, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds OperatingTable(table = {{0.0, 0.0, 1950, 125}, {1.0, 0.0, 1950, 125}, {2.0, 0.0, 1950, 125}, {3.0, 0.0, 1950, 125}, {4.0, 0.0, 1950, 125}, {5.0, 0.0, 1950, 125}, {6.0, 0.0, 1950, 125}, {7.0, 471.3612, 0, 50}, {8.0, 40344.85, 0, 50}, {9.0, 91115.47, 0, 50}, {10.0, 116355.7, 0, 50}, {11.0, 130209.3, 0, 50}, {12.0, 133804.0, 0, 50}, {13.0, 128977.9, 0, 50}, {14.0, 114171.2, 0, 50}, {15.0, 88876.23, 0, 50}, {16.0, 39530.93, 0, 50}, {17.0, 445.2878, 0, 50}, {18.0, 0.0, 1950, 125}, {19.0, 0.0, 1950, 125}, {20.0, 0.0, 1950, 125}, {21.0, 0.0, 1950, 125}, {22.0, 0.0, 1950, 125}, {23.0, 0.0, 1950, 125}, {24.0, 0.0, 1950, 125}}) annotation(Placement(visible = true, transformation(origin = {-186.64, 35}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax = Max_Heater_Power, uMin = 0) annotation(Placement(visible = true, transformation(origin = {-180, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(mech_fric_and_aux.Wshaft, generator.Wshaft) annotation(Line(visible = true, origin = {190.274, 0}, points = {{-9.726, 0}, {9.726, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(mech_fric_and_aux.Wt, stirlingEngineGasChannel.Wt) annotation(Line(visible = true, origin = {131.131, 0}, points = {{9.384, -0}, {-9.384, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(fixedTemperature1.port, containerWithStorage1.port_to_ambient) annotation(Line(visible = true, origin = {-24.202, 48.154}, points = {{-8.404, 14.077}, {4.202, 14.077}, {4.202, -28.154}}, color = {191, 0, 0}));
  connect(simplifiedCooling1.gasCooler, stirlingEngineGasChannel.Qc_port) annotation(Line(visible = true, origin = {92.874, -47.5}, points = {{-4.874, -12.5}, {-4.874, -7.5}, {4.874, -7.5}, {4.874, 27.5}}, color = {191, 0, 0}));
  connect(simplifiedCooling1.Cyls, stirlingEngineGasChannel.Q_losses_port) annotation(Line(visible = true, origin = {111.251, -47.5}, points = {{1.251, -12.5}, {1.251, -7.5}, {10.496, -7.5}, {10.496, 27.951}}, color = {191, 0, 0}));
  connect(stirlingEngineGasChannel.HTCc, simplifiedCooling1.HTCc) annotation(Line(visible = true, origin = {100, -40.156}, points = {{7.747, 20.156}, {7.747, -0}, {-0.495, -0}, {0, -20.156}}, color = {1, 37, 163}));
  connect(toKelvin.Kelvin, simplifiedCooling1.Tamb) annotation(Line(visible = true, origin = {10.326, -85}, points = {{2.776, 5}, {29.674, 5}, {29.674, 5}, {69.977, 5}}, color = {1, 37, 163}));
  connect(genericHeatResistance2.HTCc, stirlingEngineGasChannel.HTCh) annotation(Line(visible = true, origin = {68.858, -3.896}, points = {{-7.83, 0.589}, {-2.83, 0.589}, {-2.83, -0.589}, {13.489, -0.589}}, color = {1, 37, 163}));
  connect(genericHeatResistance2.workingGas_port, stirlingEngineGasChannel.Qh_port) annotation(Line(visible = true, origin = {67.668, 4.27}, points = {{-8.326, -0.27}, {-2.668, -0.27}, {-2.668, 0.27}, {13.661, 0.27}}, color = {191, 0, 0}));
  connect(containerWithStorage1.port_to_HTF, genericHeatResistance2.storage_port) annotation(Line(visible = true, origin = {10.812, 0}, points = {{-10.815, 0}, {10.815, 0}}, color = {191, 0, 0}));
  connect(temperatureSensor.port, containerWithStorage1.port_to_HTF) annotation(Line(visible = true, origin = {12.499, 30}, points = {{17.501, 30}, {-2.499, 30}, {-2.499, -30}, {-12.501, -30}}, color = {191, 0, 0}));
  connect(mech_fric_and_aux.nshaft, stirlingEngineGasChannel.nshaft) annotation(Line(visible = true, points = {{23.547, -4.301}, {9.785, -4.301}, {9.785, 4.699}, {-21.559, 4.699}, {-21.559, -0.798}}, color = {1, 37, 163}, origin = {116.962, 20.301}));
  connect(stirlingEngineGasChannel.pme, mech_fric_and_aux.pme) annotation(Line(visible = true, points = {{-14.159, 2.256}, {-14.159, 7.664}, {4.841, 7.664}, {4.841, -8.792}, {18.637, -8.792}}, color = {1, 37, 163}, origin = {121.907, 17.336}));
  connect(prescribedHeatFlow1.port, genericHeatResistance1.storage_port) annotation(Line(visible = true, origin = {-98.192, 0}, points = {{-6.808, 0}, {6.808, 0}}, color = {191, 0, 0}));
  connect(heaterControlLoss.y, prescribedHeatFlow1.Q_flow) annotation(Line(visible = true, origin = {-132, 0}, points = {{-7, 0}, {7, 0}}, color = {1, 37, 163}));
  connect(genericHeatResistance1.workingGas_port, containerWithStorage1.port_from_receiver_cavity) annotation(Line(visible = true, origin = {-47.473, 2}, points = {{-6.196, 2}, {-0.537, 2}, {-0.537, -2}, {7.271, -2}}, color = {191, 0, 0}));
  connect(AmbientTemperatureTable.y[1], toKelvin.Celsius) annotation(Line(visible = true, origin = {-36.949, -80}, points = {{-27.051, 0}, {27.051, 0}}, color = {1, 37, 163}));
  connect(OperatingTable.y[2], stirlingEngineGasChannel.nshaft) annotation(Line(visible = true, origin = {5.055, 29.834}, points = {{-180.695, 5.166}, {90.348, 5.166}, {90.348, -10.332}}, color = {1, 37, 163}));
  connect(OperatingTable.y[3], stirlingEngineGasChannel.pme) annotation(Line(visible = true, origin = {13.285, 29.864}, points = {{-188.925, 5.136}, {94.462, 5.136}, {94.462, -10.272}}, color = {1, 37, 163}));
  connect(startTime1.t_out_h_day, AmbientTemperatureTable.u) annotation(Line(visible = true, origin = {-165.5, -77.5}, points = {{-29.5, 2.5}, {-24.5, 2.5}, {-24.5, -2.5}, {78.5, -2.5}}, color = {1, 37, 163}));
  connect(startTime1.t_out_h_day, OperatingTable.u) annotation(Line(visible = true, origin = {-196.82, -31.667}, points = {{1.82, -43.333}, {6.82, -43.333}, {6.82, -23.333}, {-6.82, -23.333}, {-6.82, 66.667}, {-1.82, 66.667}}, color = {1, 37, 163}));
  connect(OperatingTable.y[1], limiter1.u) annotation(Line(visible = true, origin = {-183.82, 18.333}, points = {{8.18, 16.667}, {13.18, 16.667}, {13.18, 1.667}, {-13.18, 1.667}, {-13.18, -18.333}, {-8.18, -18.333}}, color = {1, 37, 163}));
  connect(limiter1.y, heaterControlLoss.u) annotation(Line(visible = true, origin = {-165.5, 0}, points = {{-3.5, 0}, {3.5, 0}}, color = {1, 37, 163}));
  connect(generator.Pgenerator, inverter.Pin) annotation(Line(visible = true, origin = {249.436, -0}, points = {{-8.477, 0}, {8.477, -0}}, color = {1, 37, 163}));
  annotation(experiment(StartTime = 0, StopTime = 86400, Interval = 600, __Wolfram_Algorithm = "cvodes", Tolerance = 1e-6, __Wolfram_MaxStepSize = 20, __Wolfram_EventHysteresisEpsilon = 1e-10, __Wolfram_AccurateEventDetection = true, __Wolfram_NonlinearSolverTolerance = 1e-6, __Wolfram_MaxInternalStepCount = 0, __Wolfram_CheckMinMax = false, __Wolfram_StopAtSteadyState = false, __Wolfram_SynchronizeWithRealTime = false, __Wolfram_Output_StoreEventPoints = false, __Wolfram_Output_StoreInDoublePrecision = false), Documentation(info = "<p>eTES unit, using linear shaft speed controller (controller number 5) and refrigeration system (version 5).</p>
<p>Required input:</p>
<ul>
<li>Ambient temperature [degC];</li>
<li>Ambient pressure [bar];</li>
<li>Demand signal, between 0 and 1, which then is required to determine the desired shaft speed of the Stirling motor;</li>
<li>Charging input electric (AC) power, which is limited by the heater capacity.</li>
</ul>
<p>The main outputs are:</p>
<ul>
<li>Net electric power output;</li>
<li>TES temperature.</li>
</ul>
<p>&nbsp;</p>", revisions = "", figures = {Figure(title = "InputsAndTES", identifier = "6878b", plots = {Plot(curves = {Curve(y = containerWithStorage1.port_from_receiver_cavity.Q_flow), Curve(y = containerWithStorage1.port_to_HTF.Q_flow)}, x = Axis(unit = "h")), Plot(curves = {Curve(y = containerWithStorage1.GenericLatentStorage.T)})}), Figure(title = "Work_and_power", identifier = "165d6", plots = {Plot(curves = {Curve(y = stirlingEngineGasChannel.Wt), Curve(y = mech_fric_and_aux.Wshaft), Curve(y = generator.Pgenerator), Curve(y = inverter.Pout)})})}), __Wolfram, Diagram(coordinateSystem(extent = {{-220, -160}, {380, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Text(visible = true, origin = {-96.573, -75}, extent = {{-0.927, -0}, {0.927, 0}}, textString = "text"), Text(visible = true, origin = {260, 78.305}, textColor = {149, 23, 41}, extent = {{-108.75, -13.305}, {108.75, 13.305}}, textString = "Simplified TES.POD model", textStyle = {TextStyle.Bold}), Text(visible = true, origin = {77.799, -131.25}, textColor = {149, 23, 41}, extent = {{-205, -8.75}, {205, 8.75}}, textString = "Operating table column1 = time, column 2 = charging power, column 3 = nshaft, column 4 = pme")}), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 25), Text(visible = true, origin = {0, 38.698}, textColor = {149, 23, 41}, extent = {{-88.82, -41.302}, {88.82, 41.302}}, textString = "TES.", textStyle = {TextStyle.Bold}), Text(visible = true, origin = {1.18, -38.698}, textColor = {149, 23, 41}, extent = {{-88.82, -41.302}, {88.82, 41.302}}, textString = "POD", textStyle = {TextStyle.Bold}), Text(visible = true, origin = {-0, -140}, textColor = {149, 23, 41}, extent = {{-160, -37.317}, {160, 37.317}}, textString = "%name")}), Diagram(coordinateSystem(extent = {{-200, -150}, {200, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end TESPOD_simplified;
