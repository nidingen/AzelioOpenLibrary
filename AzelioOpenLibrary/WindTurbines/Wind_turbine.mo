within AzelioOpenLibrary.WindTurbines;

model Wind_turbine "Wind turbine with tabulated power coefficients"
  Modelica.Blocks.Interfaces.RealInput T_Amb(unit = "degC") "Ambient temperature at location" annotation(Placement(visible = true, transformation(origin = {-155, 45}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Cp "Wind turbine Power coefficient" annotation(Placement(visible = true, transformation(origin = {25, 110}, extent = {{-20, -20}, {20, 20}}, rotation = -450), iconTransformation(origin = {-50, 90}, extent = {{-20, -20}, {20, 20}}, rotation = -810)));
  Modelica.Blocks.Interfaces.RealInput v_h(unit = "m/s") "Wind speed at hub height" annotation(Placement(visible = true, transformation(origin = {-40, 113.305}, extent = {{-20, -20}, {20, 20}}, rotation = -450), iconTransformation(origin = {-100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = -1080)));
  Modelica.Blocks.Interfaces.RealInput h(unit = "m") "Hub height" annotation(Placement(visible = true, transformation(origin = {157.553, 43.484}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {50, 90}, extent = {{-20, -20}, {20, 20}}, rotation = -810)));
  Modelica.Blocks.Interfaces.RealInput p(unit = "kPa") "Ambient pressure at location" annotation(Placement(visible = true, transformation(origin = {-168.028, -3.802}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter Real P_Nom(unit = "W") "Wind turbine nominal capacity" annotation(Placement(visible = true, transformation(origin = {158.241, -40}, extent = {{-20, -20}, {20, 20}}, rotation = -180), iconTransformation(origin = {90, 50}, extent = {{-20, -20}, {20, 20}}, rotation = -540)));
  parameter Real D(unit = "m") "Wind turbine rotor diameter" annotation(Placement(visible = true, transformation(origin = {155, 10}, extent = {{-20, -20}, {20, 20}}, rotation = -180), iconTransformation(origin = {91.69, -50}, extent = {{-20, -20}, {20, 20}}, rotation = -180)));
  parameter Real v_cin(unit = "m/s") "Cut-in wind speed";
  parameter Real v_cof(unit = "m/s") "Cut-off wind speed";
  Modelica.Blocks.Interfaces.RealOutput P_WT(unit = "W") "Wind Turbine power output" annotation(Placement(visible = true, transformation(origin = {-30, -110}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = -360)));
  Modelica.Blocks.Interfaces.RealOutput E_WT(unit = "J") "Wind Turbine energy yield" annotation(Placement(visible = true, transformation(origin = {30, -110}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = -360)));
  Real CF "Capacity Factor";
  Real rho(unit = "kg/m3") "Air density at ambient conditions";
  Real p_WT(unit = "W") "intermediate variable to check the power output";
  Real T_h(unit = "degC") "Temperature at hub height";
equation
  T_h = T_Amb - 0.66 * h / 100;
  rho = 0.34837 * p / Modelica.SIunits.Conversions.from_degC(T_h);
  if noEvent(v_h < v_cin) then
    p_WT = 0;
  elseif noEvent(v_h >= v_cof) then
    p_WT = 0;
  else
    p_WT = 0.125 * rho * Modelica.Constants.pi * D ^ 2 * Cp * v_h ^ 3;
  end if;
  if p_WT > P_Nom then
    P_WT = P_Nom;
  else
    P_WT = p_WT;
  end if;
  P_WT = der(E_WT);
  CF = Modelica.SIunits.Conversions.to_Wh(E_WT) / (8760 * P_Nom);
  annotation(Documentation(info = "<p>This block simulates a wind turbine and calculates the power output <em>P<sub>WT</sub></em> [W] and annual energy yield <em>E<sub>WT&nbsp;</sub></em>[J, MWh] based on TMY data [1].</p>
<p><em>P<sub>WT</sub> = 0.5&nbsp;&middot; <span style=\"font-family: symbol;\">r</span>&nbsp;&middot; <span style=\"font-family: symbol;\">p</span>&nbsp;&middot; (D/2)<sup>2</sup>&nbsp;&middot; C<sub>p</sub> &middot; v<sub>h</sub><sup>3</sup></em></p>
<p>where:</p>
<ul>
<li><em><span style=\"font-family: symbol;\">r</span>&nbsp;</em>is air density at local temperature and pressure [kg/m<sup>3</sup>];</li>
<li><em>D</em> is the wind turbine diameter [m];</li>
<li>Cp is the power coefficient of the wind turbine; and</li>
<li><em>v<sub>h</sub></em> is the wind speed at hub height [m/s].</li>
</ul>
<p>Air density is calculated according to the ideal gas law [1]:</p>
<p><em><span style=\"font-family: symbol;\">r</span> = 0.34837 &nbsp;&middot; p/(T<sub>h</sub>+273.15)</em></p>
<p>where<em>&nbsp;</em></p>
<ul>
<li><em>p</em>&nbsp;is atmospheric pressure&nbsp;from TMY data[kPa]; and</li>
<li><em>T<sub>h</sub></em>&nbsp;is ambient temperature, at hub height <em>h&nbsp;</em>[&ordm;C].</li>
</ul>
<p>Air temperature at hub height is determined according to the standard lapse rate [1]:</p>
<p><em>T<sub>h</sub> = T<sub>Amb</sub> -0.66&nbsp;&middot; h/100</em></p>
<p>The power coefficient <em>C<sub>p</sub></em> is the fundamental input, as table: the first column is the wind speed and the second column is <em>C<sub>p</sub></em>. The actual <em>C<sub>p</sub></em>&nbsp;is calculated through linear interpolation (CombiTable1Ds).&nbsp;</p>
<p>Wind speed at hub height <em>v<sub>h</sub></em> is determined by the relative block.</p>
<p>Energy yield is determined as integral of power output and converted to MWh.</p>
<p>Required inputs:</p>
<ul>
<li><em>p;</em></li>
<li><em>T<sub>Amb</sub></em>;</li>
<li><em>EASL</em>;</li>
<li><em>v<sub>h</sub></em>;</li>
<li><em>C<sub>p</sub></em>;</li>
<li><em>P<sub>Nom</sub></em>, nominal wind turbine power [W], needed to check and limit power production in case <em>P<sub>WT</sub></em> exceeds the nominal power;</li>
<li><em>D</em>.</li>
</ul>
<h2>Reference</h2>
<p>[1] <em>Wind Energy Explained</em>, Manwell et al, 2nd Edition</p>", revisions = ""), Placement(visible = true, transformation(origin = {-0, -110}, extent = {{-20, -20}, {20, 20}}, rotation = -450), iconTransformation(origin = {-23.569, -15.964}, extent = {{-10, -10}, {10, 10}}, rotation = 0)), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {128, 128, 128}, fillColor = {149, 23, 41}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 25), Line(visible = true, origin = {0.179, 45.003}, points = {{0, 45.714}, {-6, -4.286}, {-6, -24.286}, {0, -34.286}, {6, -24.286}, {6, -4.286}, {0, 45.714}}, color = {255, 255, 255}, thickness = 2.5, smooth = Smooth.Bezier), Line(visible = true, origin = {-29.514, -6.426}, rotation = 120, points = {{0, 45.714}, {-6, -4.286}, {-6, -24.286}, {0, -34.286}, {6, -24.286}, {6, -4.286}, {0, 45.714}}, color = {255, 255, 255}, thickness = 2.5, smooth = Smooth.Bezier), Line(visible = true, origin = {29.872, -6.524}, rotation = 240, points = {{0, 45.714}, {-6, -4.286}, {-6, -24.286}, {0, -34.286}, {6, -24.286}, {6, -4.286}, {0, 45.714}}, color = {255, 255, 255}, thickness = 2.5, smooth = Smooth.Bezier), Rectangle(visible = true, origin = {0.179, -39.068}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, lineThickness = 2.5, extent = {{-2.5, -53.729}, {2.5, 53.729}}), Ellipse(visible = true, origin = {0.179, 10.717}, lineColor = {255, 255, 255}, fillColor = {149, 23, 41}, fillPattern = FillPattern.Solid, lineThickness = 2.5, extent = {{-5, -5}, {5, 5}})}), experiment(__Wolfram_SynchronizeWithRealTime = false), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end Wind_turbine;
