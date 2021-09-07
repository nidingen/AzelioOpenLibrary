within AzelioOpenLibrary.Gensets;

model Diesel_Generator_Fuel_Table "Diesel Generator model"
  Modelica.Blocks.Interfaces.RealInput P_dem(unit = "W") "Power demand" annotation(Placement(visible = true, transformation(origin = {-151.696, 33.545}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-95, -50}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  //Modelica.Blocks.Interfaces.RealInput FC_tab(unit = "l/h") "Fuel consumption from table" annotation(Placement(visible = true, transformation(origin = {117.14, 89.866}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-95, 50}, extent = {{-25, -25}, {25, 25}}, rotation = -720)));
  //Modelica.Blocks.Interfaces.RealInput P_Nom(unit = "W") "Diesel generator nominal power" annotation(Placement(visible = true, transformation(origin = {-122.411, 80.341}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 95}, extent = {{-25, -25}, {25, 25}}, rotation = -810)));
  parameter Real P_Nom(unit = "W") "Nominal genset power" annotation(Placement(visible = true, transformation(origin = {-155, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98.908, -15.426}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter Real min_load "Minimum disel generator load as fraction of nominal capacity";
  parameter Real rho_D(unit = "kg/m3", nominal = 832.0) = 832.0 "Diesel density";
  parameter Real LHV_D(unit = "MJ/kg", nominal = 43.1) = 43.1 "Diesel Lower Heating Value";
  Real k(unit = "1") "Power coefficient to determine fuel consumption";
  Real FC(unit = "l/s") "Fuel consumption";
  Real FC_tot(unit = "l") "Annual fuel consumption";
  Real P_out(unit = "kW") "Power output";
  Real E_out(unit = "kJ") "Yearly energy output";
  Real P_min(unit = "kW") "Minimum allowed power";
  Real spec_cons(unit = "l/J") "Specific consumption";
  Real eta_DG "Diesel generator efficiency";
  Modelica.Blocks.Tables.CombiTable1Ds FC_tab(table = {{0, 33.9 / 3600}, {0.25, 33.9 / 3600}, {0.5, 59.9 / 3600}, {0.75, 84.0 / 3600}, {1.0, 106.6 / 3600}}) annotation(Placement(visible = true, transformation(origin = {1.491, -1.491}, extent = {{-21.491, -21.491}, {21.491, 21.491}}, rotation = 0)));
equation
  P_dem / P_Nom = k;
  k = FC_tab.u;
  FC_tab.y[1] = FC;
  P_min = min_load * P_Nom;
  if noEvent(P_dem <= P_min) then
    P_out = P_min;
  else
    P_out = P_dem;
  end if;
  //FC = FC_tab;
  spec_cons = FC / P_out;
  FC = der(FC_tot);
  P_out = der(E_out);
  eta_DG = (0.001 * spec_cons * rho_D * LHV_D * 1E6) ^ (-1);
  annotation(Documentation(info = "<p>This block simulates the electric power outoput (<em>P<sub>out</sub></em>, [kW]) of a diesel generator and its fuel consumption (<em>FC</em>, [l/h]) at each time step, as function of the fule consumption table given by the diesel generator manufaturer.</p>
<p>The fuel consumption is an input from the block \"Power table\", calculated through linear interpolation between the given points.</p>
<p>In this block, it is assumed that the diesel generator follows the power demand (<em>P<sub>dem</sub></em>, [kW]) at any time step. For reliability and improved lifetime, the minimum power output (<em>P<sub>min</sub></em>, [kW]) from the diesel generator is fixed. An if code checks this issue:</p>
<ul>
<li>if <em>P<sub>dem</sub>&nbsp;&le; P<sub>min</sub></em>, then <em>P<sub>out</sub> = P<sub>min</sub></em>;&nbsp;</li>
<li>otherwise, <em>P<sub>out</sub> = P<sub>dem.</sub></em></li>
</ul>
<p>&nbsp;The minimum power output is deteremined as fraction of the nominal power, by introducing the minimum load coefficient&nbsp;&epsilon;<sub><em>min</em></sub></p>
<p style=\"text-align: center;\"><em>P<sub>min</sub> =&nbsp;&epsilon;<sub>min</sub>&nbsp;&middot; P<sub>nom</sub></em></p>
<p style=\"text-align: left;\">The specific hourly fuel consumption (<em>&xi;</em>, [l/kWh]) is also determined:</p>
<p style=\"text-align: center;\"><em>&xi; = FC/P<sub>out</sub></em></p>
<p style=\"text-align: left;\">At each timestep, the energy output is determined as integral of the power otput. This block also calculates the hourly efficiency <em>&eta;<sub>D</sub></em>, by dividing the electric output by the energy input through the fuel.</p>
<p style=\"text-align: center;\"><em>&eta;<sub>D</sub> = 1 / (0.001&nbsp;&middot;&nbsp;&xi;&nbsp;&middot;&nbsp;<span style=\"font-family: symbol;\">r</span><sub>D</sub> &middot; LHV<sub>D</sub>)</em></p>
<p style=\"text-align: left;\">Where</p>
<ul>
<li style=\"text-align: left;\"><em><span style=\"font-family: symbol;\">r</span><sub>D&nbsp;</sub></em>is diesel density [kg/m<sup>3</sup>]; and</li>
<li style=\"text-align: left;\"><em>LHV<sub>D&nbsp;</sub></em>is diesel lower heating value [kWh/m<sup>3</sup>].</li>
</ul>
<p>&nbsp;This model requires 4 inputs as parameter, and one as hourly data:</p>
<ul>
<li><em>P<sub>nom</sub></em>, as input from the block \"Power table\"</li>
<li><em>&epsilon;<sub>min</sub></em>, which should be the same as given in \"Power table\".</li>
<li><em><span style=\"font-family: symbol;\">r</span><sub>D&nbsp;</sub></em>(default value = 840 kg/m<sup>3</sup>)</li>
<li><em>LHV<sub>D&nbsp;</sub></em>(default value = 12.1 kWh/m<sup>3</sup>)</li>
<li><em>P<sub>dem&nbsp;</sub></em>as hourly input.</li>
</ul>
<p>&nbsp;</p>
<h2>Reference</h2>
<p>[1]&nbsp;Skarstein, Oyvin &amp; Uhlen, Kjetil. (1989). Design Considerations with Respect to Long-Term Diesel Saving in Wind/Diesel Plants. Wind Engineering. 13. 72-87.&nbsp;</p>", revisions = ""), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, origin = {-0.179, -0.717}, lineColor = {128, 128, 128}, fillColor = {149, 23, 41}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 25), Polygon(visible = true, origin = {1.285, 1.137}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 1, points = {{-33.397, 21.115}, {-40.471, 21.115}, {-40.471, 10.006}, {-46.067, 10.006}, {-46.067, 23.901}, {-51.285, 23.901}, {-51.285, -10.011}, {-46.067, -10.011}, {-46.067, 3.901}, {-40.011, 3.901}, {-40.011, -6.099}, {-32.608, -6.099}, {-20.011, -26.099}, {33.933, -26.099}, {33.933, -16.099}, {39.824, -16.099}, {39.824, -26.099}, {46.923, -26.099}, {49.487, -20.364}, {51.656, -13.593}, {51.656, 1}, {49.29, 8.494}, {46.923, 13.901}, {39.43, 13.901}, {39.43, 3.901}, {33.933, 3.901}, {19.989, 29.398}, {3.933, 29.398}, {3.933, 33.901}, {13.793, 33.901}, {13.793, 38.863}, {-16.067, 38.863}, {-16.067, 33.901}, {-6.067, 33.901}, {-6.067, 29.398}, {-25.114, 29.398}}), Polygon(visible = true, origin = {-6.751, 11.167}, lineColor = {149, 23, 41}, fillColor = {149, 23, 41}, fillPattern = FillPattern.Solid, points = {{7.515, 5.136}, {14.449, 5.136}, {9.441, -4.717}, {18.912, -4.717}, {4.609, -21.167}, {8.478, -10.112}, {-0.35, -10.112}})}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end Diesel_Generator_Fuel_Table;
