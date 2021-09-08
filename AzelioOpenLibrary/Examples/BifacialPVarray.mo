within AzelioOpenLibrary.Examples;

model BifacialPVarray
  extends AzelioOpenLibrary.Icons.ExampleIcon;
  Modelica.Blocks.Sources.RealExpression Hourly_input(y = time / 3600) annotation(Placement(visible = true, transformation(origin = {-135, -0}, extent = {{-12.5, -10}, {12.5, 10}}, rotation = 0)));
  AzelioOpenLibrary.ElectricalModels.BifacialPVfront BPV_Front(Lat = 31.03, Tracking = false) annotation(Placement(visible = true, transformation(origin = {20.109, 60.109}, extent = {{-40.109, -40.109}, {40.109, 40.109}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds TMY(tableOnFile = false, tableName = "TMY", fileName = "TMY_2005.txt", columns = 2:9, table = {{0.0, 0.0, 0.0, 0.0, 14.7, 0.0, -179, 989.1, .4}, {1.0, 0.0, 0.0, 0.0, 13.5, 0.0, -157.4, 989.1, .7}, {2.0, 0.0, 0.0, 0.0, 12.3, 0.0, -139.5, 989.1, .6}, {3.0, 0.0, 0.0, 0.0, 11.7, 0.0, -126, 989.1, .9}, {4.0, 0.0, 0.0, 0.0, 11.1, 0.0, -115.2, 989.1, .9}, {5.0, 0.0, 0.0, 0.0, 10.6, 0.0, -106.3, 989.1, .9}, {6.0, 41.0, 41.0, 0.0, 11.3, 6.0, -98.5, 989.1, .4}, {7.0, 319.0, 151.0, 522.0, 13.8, 18.8, -91.2, 989.1, .3}, {8.0, 572.0, 77.0, 944.0, 16.2, 31.6, -83.2, 989.1, 1.3}, {9.0, 797.0, 101.0, 997.0, 18.4, 44.2, -73.3, 989.1, 1.6}, {10.0, 966.0, 119.0, 1021.0, 20.4, 56.0, -59.4, 989.1, 2}, {11.0, 1069.0, 124.0, 1037.0, 22.0, 65.7, -36.2, 989.1, 2.9}, {12.0, 1097.0, 121.0, 1041.0, 23.2, 69.7, 1.5, 989.1, 3.6}, {13.0, 1053.0, 117.0, 1033.0, 23.9, 65.0, 38.5, 989.1, 3.6}, {14.0, 936.0, 104.0, 1015.0, 24.2, 55.1, 61, 989.1, 2.7}, {15.0, 757.0, 82.0, 987.0, 24.1, 43.2, 74.3, 989.1, 2.5}, {16.0, 530.0, 59.0, 927.0, 23.4, 30.5, 84, 989.1, 2}, {17.0, 281.0, 129.0, 500.0, 22.0, 17.7, 91.6, 989.1, 2.3}, {18.0, 24.0, 24.0, 0.0, 20.2, 4.9, 99.3, 989.1, 2}, {19.0, 0.0, 0.0, 0.0, 18.9, 0.0, 107.2, 989.1, 1}, {20.0, 0.0, 0.0, 0.0, 17.6, 0.0, 116.1, 989.1, 1.1}, {21.0, 0.0, 0.0, 0.0, 16.3, 0.0, 127, 989, 1.1}, {22.0, 0.0, 0.0, 0.0, 15.0, 0.0, 141.1, 989, .8}, {23.0, 0.0, 0.0, 0.0, 13.7, 0.0, 159.2, 989, .7}, {24.0, 0.0, 0.0, 0.0, 12.8, 0.0, -178.6, 989, .5}}) annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AzelioOpenLibrary.Utilities.Radians_Conv Angle_converter_1 annotation(Placement(visible = true, transformation(origin = {-50, 42.51}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AzelioOpenLibrary.ElectricalModels.BifacialPVrear BPV_Rear(Tracking = false, D = 4.0, H0 = 0.5, H = 1.022 * 2) annotation(Placement(visible = true, transformation(origin = {20, -60}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  AzelioOpenLibrary.Utilities.Radians_Conv Angle_converter_2 annotation(Placement(visible = true, transformation(origin = {-50, -78.007}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AzelioOpenLibrary.ElectricalModels.BifacialPVassy BPV_Front_and_Rear(P_mod = 345, P_nom = 13110, shad = 0, alpha_SC = 0.00085, NOCT = 44.5 + 273.15, soil = 0, mism = 0, cab = 0) annotation(Placement(visible = true, transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  AzelioOpenLibrary.ElectricalModels.GenericInverter Inverter_ annotation(Placement(visible = true, transformation(origin = {183.347, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(Hourly_input.y, TMY.u) annotation(Line(visible = true, origin = {-116.625, -0}, points = {{-4.625, -0}, {4.625, 0}}, color = {1, 37, 163}));
  connect(TMY.y[1], BPV_Front.G_GHI) annotation(Line(visible = true, origin = {-63.171, 75.88}, points = {{-25.829, -75.88}, {-16.829, -75.88}, {-16.829, -16.098}, {-9.329, -16.098}, {-9.329, 8.294}, {43.171, 8.294}}, color = {1, 37, 163}));
  connect(TMY.y[2], BPV_Front.G_DHI) annotation(Line(visible = true, origin = {-63.171, 69.864}, points = {{-25.829, -69.864}, {-16.829, -69.864}, {-16.829, -9.864}, {-9.329, -10.082}, {-9.329, 2.278}, {43.171, 2.278}}, color = {1, 37, 163}));
  connect(TMY.y[3], BPV_Front.G_DNI) annotation(Line(visible = true, origin = {-63.171, 63.847}, points = {{-25.829, -63.847}, {-16.829, -63.847}, {-16.829, -4.065}, {43.171, -3.738}}, color = {1, 37, 163}));
  connect(TMY.y[5], Angle_converter_1.Sun_Elev_deg) annotation(Line(visible = true, origin = {-71.554, 25.625}, points = {{-17.446, -25.625}, {-8.446, -25.625}, {-8.446, 34.375}, {-1.201, 34.375}, {-1.201, 21.885}, {12.554, 21.885}}, color = {1, 37, 163}));
  connect(Angle_converter_1.Sun_Azim_rad, BPV_Front.Sun_Azim) annotation(Line(visible = true, origin = {-27.939, 28.168}, points = {{-12.061, 9.342}, {-2.061, 9.342}, {-2.061, 7.876}, {7.939, 7.876}}, color = {1, 37, 163}));
  connect(TMY.y[6], Angle_converter_1.Sun_Azim_deg) annotation(Line(visible = true, origin = {-89.054, 25.407}, points = {{0.054, -25.407}, {9.054, -25.407}, {9.054, 34.375}, {16.554, 34.375}, {16.554, 12.103}, {30.054, 12.103}}, color = {1, 37, 163}));
  connect(Angle_converter_1.Sun_Elev_rad, BPV_Front.Sun_Elev) annotation(Line(visible = true, origin = {-27.939, 40.434}, points = {{-12.061, 7.076}, {-2.061, 7.076}, {-2.061, 7.642}, {7.939, 7.642}}, color = {1, 37, 163}));
  connect(TMY.y[1], BPV_Rear.G_GHI) annotation(Line(visible = true, origin = {-67.25, -12}, points = {{-21.75, 12}, {-12.75, 12}, {-12.75, -24}, {47.25, -24}}, color = {1, 37, 163}));
  connect(TMY.y[2], BPV_Rear.G_DHI) annotation(Line(visible = true, origin = {-67.25, -18}, points = {{-21.75, 18}, {-12.75, 18}, {-12.75, -30}, {47.25, -30}}, color = {1, 37, 163}));
  connect(TMY.y[3], BPV_Rear.G_DNI) annotation(Line(visible = true, origin = {-67.25, -24}, points = {{-21.75, 24}, {-12.75, 24}, {-12.75, -36}, {47.25, -36}}, color = {1, 37, 163}));
  connect(TMY.y[5], Angle_converter_2.Sun_Elev_deg) annotation(Line(visible = true, origin = {-77, -36.503}, points = {{-12, 36.503}, {-3, 36.503}, {-3, -36.503}, {18, -36.504}}, color = {1, 37, 163}));
  connect(TMY.y[6], Angle_converter_2.Sun_Azim_deg) annotation(Line(visible = true, origin = {-77, -41.503}, points = {{-12, 41.503}, {-3, 41.503}, {-3, -41.503}, {18, -41.504}}, color = {1, 37, 163}));
  connect(TMY.y[4], BPV_Front_and_Rear.T_Amb) annotation(Line(visible = true, origin = {42.75, 10}, points = {{-131.75, -10}, {37.25, -10}, {37.25, 0}, {57.25, 0}}, color = {1, 37, 163}));
  connect(TMY.y[8], BPV_Front_and_Rear.w) annotation(Line(visible = true, origin = {42.75, -10}, points = {{-131.75, 10}, {37.25, 10}, {37.25, 0}, {57.25, 0}}, color = {1, 37, 163}));
  connect(BPV_Rear.G_R, BPV_Front_and_Rear.G_R) annotation(Line(visible = true, origin = {93.333, -38.667}, points = {{-33.333, -9.333}, {16.667, -9.333}, {16.667, 18.667}}, color = {1, 37, 163}));
  connect(BPV_Rear.G_R_Tot, BPV_Front_and_Rear.G_R_Tot) annotation(Line(visible = true, origin = {106.667, -54.667}, points = {{-46.667, -17.333}, {23.333, -17.333}, {23.333, 34.667}}, color = {1, 37, 163}));
  connect(BPV_Front.G_F, BPV_Front_and_Rear.G_F) annotation(Line(visible = true, origin = {93.406, 38.718}, points = {{-33.188, 9.359}, {16.594, 9.359}, {16.594, -18.718}}, color = {1, 37, 163}));
  connect(BPV_Front.M, BPV_Front_and_Rear.M) annotation(Line(visible = true, origin = {106.739, 54.761}, points = {{-46.521, 17.381}, {23.261, 17.381}, {23.261, -34.761}}, color = {1, 37, 163}));
  connect(BPV_Rear.Sun_Azim, Angle_converter_2.Sun_Azim_rad) annotation(Line(visible = true, origin = {-30, -83.504}, points = {{10, -0.496}, {0, -0.496}, {0, 0.496}, {-10, 0.497}}, color = {1, 37, 163}));
  connect(BPV_Rear.Sun_Elev, Angle_converter_2.Sun_Elev_rad) annotation(Line(visible = true, origin = {-30.724, -72.504}, points = {{9.676, -4.651}, {0.876, 0.099}, {0.398, -0.787}, {-8.401, 3.964}}, color = {1, 37, 163}, rotation = 28.362));
  connect(BPV_Front.G_F_Tot, BPV_Front_and_Rear.G_F_Tot) annotation(Line(visible = true, origin = {100.073, 46.739}, points = {{-39.855, 13.37}, {19.927, 13.37}, {19.927, -26.739}}, color = {1, 37, 163}));
  connect(BPV_Front_and_Rear.P_DC, Inverter_.Pin) annotation(Line(visible = true, origin = {148.337, 5}, points = {{-8.337, 5}, {-3.337, 5}, {15.01, -5}}, color = {1, 37, 163}));
  connect(Inverter_.Pnom1, BPV_Front_and_Rear.P_nom1) annotation(Line(visible = true, origin = {155.01, 0.207}, points = {{8.337, 10.207}, {3.337, 10.207}, {-15.01, -10.207}}, color = {1, 37, 163}));
  annotation(experiment(StopTime = 86400, Interval = 180, __Wolfram_Algorithm = "cvodes", Tolerance = 1e-10, __Wolfram_SynchronizeWithRealTime = false), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10})), Documentation(info = "<p>This model simulates the power output <em>P<sub>AC&nbsp;</sub></em>(W)&nbsp;and energy yield <em>E<sub>AC</sub></em> (J)&nbsp;of a solar farm with bifacial modules, based on a simplified model from master's thesis from TU Delft [1], using the following TMY data for a given location, when latitude and elevation above sea level <em>EASL</em> (m)&nbsp;are known:</p>
<ul>
<li>Global Horizontal Irradiance <em>G<sub>GHI</sub></em> (W/m<sup>2</sup>);</li>
<li>Diffuse Horizontal Irradiance <em>G<sub>DHI</sub></em>&nbsp;(W/m<sup>2</sup>);</li>
<li>Direct Normal Irradiance<em> G<sub>DNI</sub></em>&nbsp;(W/m<sup>2</sup>);</li>
<li>Ambient temperature <em>T<sub>Amb</sub></em> (&deg;C);</li>
<li>Solar azimuth angle <em>Azim<sub>Sun</sub></em> (rad);</li>
<li>Solar elevation angle <em>Elev<sub>Sun</sub></em> (rad);</li>
<li>Wind speed <em>w</em> (m/s).</li>
</ul>
<p>Total incidence irradiance on front and rear side of the module are simulated separetly and combined in a different block to determine the total DC power output.</p>
<p>The inverter block determines the AC power and energy output by mean of inverter efficiency.</p>
<h2>References</h2>
<p>[1] Sundeep Reddy Gali, R., 2017. \"Energy Yield Model for Bifacial PV Systems: A study and analysis of temperature and rear irradiance models\". Delft University of Technology.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>", revisions = ""), Diagram(coordinateSystem(extent = {{-160, -105}, {212.673, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end BifacialPVarray;
