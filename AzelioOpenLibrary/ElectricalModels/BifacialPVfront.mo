within AzelioOpenLibrary.ElectricalModels;

model BifacialPVfront
  Modelica.Blocks.Interfaces.RealInput G_DHI(unit = "W/m2") "Diffuse Horizontal Irradiance" annotation(Placement(visible = true, transformation(origin = {-155, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput G_DNI(unit = "W/m2") "Direct Normal Irradiance" annotation(Placement(visible = true, transformation(origin = {-155, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Sun_Azim(unit = "rad") "Solar Azimuth angle" annotation(Placement(visible = true, transformation(origin = {-155, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Sun_Elev(unit = "rad") "Solar Elevation angle" annotation(Placement(visible = true, transformation(origin = {-155, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput G_GHI(unit = "W/m2") "Global Horizontal Irradiance" annotation(Placement(visible = true, transformation(origin = {-155, 35}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput G_F_Tot(unit = "W/m2") "Total irradiance on collector" annotation(Placement(visible = true, transformation(origin = {146.913, 2.416}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput G_F(unit = "W/m2") "Total useful irradiance on collector" annotation(Placement(visible = true, transformation(origin = {146.913, 2.416}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput M "Air mass modifier" annotation(Placement(visible = true, transformation(origin = {152.379, -0.966}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Boolean Tracking = true "True for single-axis tracking E-W, false for fixed tilt";
  parameter Real Lat(unit = "deg") = 31.03 "Location latitude";
  parameter Real EASL(unit = "m") = 1258 "Elevation above sea level at location";
  parameter Real Alb = 0.2 "Ground albedo coefficient";
  constant Real nref = 1.526 "Effective index of refraction of the cell cover";
  constant Real K_gl(unit = "m-1") = 4 "Glazing extinction coefficient";
  constant Real L_gl(unit = "m") = 0.002 "Glazing thickness";
  Real Sun_Zen(unit = "rad") "Sun Zenith angle";
  Real PV_track(unit = "rad") "PV tracking axis angle";
  Real PV_Azim(unit = "rad") "PV azimuth angle";
  Real beta_ref(unit = "rad") "Reference tilt angle";
  Real beta_c(unit = "rad") "Tilt";
  Real rot(unit = "rad") "Surface rotation angle about tracking axis";
  Real theta_b(unit = "rad") "Incidence angle";
  Real a "control value on incidence angle";
  Real cos_eff "Cosine effectiveness";
  Real G_b(unit = "W/m2") "Beam Irradiance on collector";
  Real G_d(unit = "W/m2") "Diffuse Irradiance on collector";
  Real G_g(unit = "W/m2") "Ground reflectes Irradiance on collector";
  Real theta_d(unit = "rad") "Effective incidence of diffused irradiance";
  Real theta_g(unit = "rad") "Effective incidence of reflected irradiance";
  Real theta_r(unit = "rad") "Referemce angle, 1 deg";
  Real theta_tb(unit = "rad") "Refraction angle for beam irradiance";
  Real theta_td(unit = "rad") "Refraction angle for diffused irradiance";
  Real theta_tg(unit = "rad") "Refraction angle for ground reflected irradiance";
  Real theta_tr(unit = "rad") "Refraction angle for reference";
  Real trans_d_temp "Diffuse transmittance";
  Real trans_g_temp "Reflected transmittance";
  Real trans_b "Beam transmittance";
  Real trans_d "Diffuse transmittance";
  Real trans_g "Reflected transmittance";
  Real trans_0 "Reference transmittance";
  Real IAM_b "Incidence angle modifier for beam irradiance";
  Real IAM_d "Incidence angle modifier for diffused irradiance";
  Real IAM_g "Incidence angle modifier for ground reflected irradiance";
  Real AM "Air mass";
equation
  Sun_Zen = 0.5 * Modelica.Constants.pi - Sun_Elev;
  if noEvent(Lat >= 0) then
    PV_track = Modelica.Constants.pi;
  else
    PV_track = 0;
  end if;
  if noEvent(abs(Lat) > 65) then
    beta_ref = Modelica.SIunits.Conversions.from_deg(0.224 * abs(Lat) + 33.6);
  else
    beta_ref = Modelica.SIunits.Conversions.from_deg(0.764 * abs(Lat) + 2.1);
  end if;
  if Tracking then
    rot = atan(tan(Sun_Zen) * sin(Sun_Azim - PV_track));
    beta_c = abs(rot);
    if noEvent(abs(beta_c) > 0) then
      PV_Azim = PV_track + asin(sin(rot) / sin(beta_c));
    else
      PV_Azim = PV_track;
    end if;
  else
    rot = 0;
    beta_c = beta_ref;
    PV_Azim = PV_track;
  end if;
  a = cos(beta_c) * cos(Sun_Zen) + sin(beta_c) * sin(Sun_Zen) * cos(Sun_Azim - PV_Azim);
  if noEvent(a < (-1)) then
    theta_b = Modelica.Constants.pi;
  elseif noEvent(a > 1) then
    theta_b = 0;
  else
    theta_b = acos(a);
  end if;
  cos_eff = cos(theta_b);
  G_b = G_DNI * cos(theta_b);
  G_d = 0.5 * G_DHI * (1 + cos(beta_c));
  G_g = 0.5 * G_GHI * Alb * (1 - cos(beta_c));
  G_F_Tot = G_b + G_d + G_g;
  theta_d = Modelica.SIunits.Conversions.from_deg(59.68 - 0.1388 * Modelica.SIunits.Conversions.to_deg(beta_c) + 0.001497 * Modelica.SIunits.Conversions.to_deg(beta_c) ^ 2);
  theta_g = Modelica.SIunits.Conversions.from_deg(90.00 - 0.5788 * Modelica.SIunits.Conversions.to_deg(beta_c) + 0.002693 * Modelica.SIunits.Conversions.to_deg(beta_c) ^ 2);
  theta_r = Modelica.SIunits.Conversions.from_deg(1);
  theta_tb = asin(sin(theta_b) / nref);
  theta_td = asin(sin(theta_d) / nref);
  theta_tg = asin(sin(theta_g) / nref);
  theta_tr = asin(sin(theta_r) / nref);
  if noEvent(theta_b > 0) then
    trans_b = exp(-K_gl * L_gl / cos(theta_tb)) * (1 - 0.5 * (sin(theta_tb - theta_b) ^ 2 / sin(theta_tb + theta_b) ^ 2 + tan(theta_tb - theta_b) ^ 2 / tan(theta_tb + theta_b) ^ 2));
  elseif noEvent(theta_b < 0) then
    trans_b = exp(-K_gl * L_gl / cos(theta_tb)) * (1 - 0.5 * (sin(theta_tb - theta_b) ^ 2 / sin(theta_tb + theta_b) ^ 2 + tan(theta_tb - theta_b) ^ 2 / tan(theta_tb + theta_b) ^ 2));
  else
    trans_b = 1;
  end if;
  trans_d_temp = exp(-K_gl * L_gl / cos(theta_td)) * (1 - 0.5 * (sin(theta_td - theta_d) ^ 2 / sin(theta_td + theta_d) ^ 2 + tan(theta_td - theta_d) ^ 2 / tan(theta_td + theta_d) ^ 2));
  trans_g_temp = exp(-K_gl * L_gl / cos(theta_tg)) * (1 - 0.5 * (sin(theta_tg - theta_g) ^ 2 / sin(theta_tg + theta_g) ^ 2 + tan(theta_tg - theta_g) ^ 2 / tan(theta_tg + theta_g) ^ 2));
  if noEvent(trans_d_temp < 0) then
    trans_d = 0;
  else
    trans_d = trans_d_temp;
  end if;
  if noEvent(trans_g_temp < 0) then
    trans_g = 0;
  else
    trans_g = trans_g_temp;
  end if;
  trans_0 = exp(-K_gl * L_gl / cos(theta_tr)) * (1 - 0.5 * (sin(theta_tr - theta_r) ^ 2 / sin(theta_tr + theta_r) ^ 2 + tan(theta_tr - theta_r) ^ 2 / tan(theta_tr + theta_r) ^ 2));
  IAM_b = trans_b / trans_0;
  IAM_d = trans_d / trans_0;
  IAM_g = trans_g / trans_0;
  if noEvent(Sun_Zen >= Modelica.SIunits.Conversions.from_deg(86)) then
    AM = (cos(Modelica.SIunits.Conversions.from_deg(86)) + 0.5057 * (96.080 - 86) ^ (-1.634)) ^ (-1) * exp(-0.0001184 * EASL);
  elseif noEvent(Sun_Zen <= 0) then
    AM = (1 + 0.5057 * 96.080 ^ (-1.634)) ^ (-1) * exp(-0.0001184 * EASL);
  else
    AM = (cos(Sun_Zen) + 0.5057 * (96.080 - Modelica.SIunits.Conversions.to_deg(Sun_Zen)) ^ (-1.634)) ^ (-1) * exp(-0.0001184 * EASL);
  end if;
  M = 0.918093 + 0.086257 * AM - 0.024459 * AM ^ 2 + 0.002816 * AM ^ 3 - 0.000126 * AM ^ 4;
  G_F = M * (G_b * IAM_b + G_d * IAM_d + G_g * IAM_g);
  annotation(Documentation(info = "<p>This model simulates the&nbsp;incident radiation on&nbsp;the front side of bifacial PV modules in a solar farm,&nbsp;based on NREL SAM procedure [1], using the following TMY data for a given location, when latitude and elevation above sea level <em>EASL</em> (m)&nbsp;are known:</p>
<ul>
<li>Global Horizontal Irradiance <em>G<sub>GHI</sub></em> (W/m<sup>2</sup>);</li>
<li>Diffuse Horizontal Irradiance <em>G<sub>DHI</sub></em>&nbsp;(W/m<sup>2</sup>);</li>
<li>Direct Normal Irradiance<em> G<sub>DNI</sub></em>&nbsp;(W/m<sup>2</sup>);</li>
<li>Ambient temperature <em>T<sub>Amb</sub></em> (&deg;C);</li>
<li>Solar azimuth angle <em>Azim<sub>Sun</sub></em> (rad);</li>
<li>Solar elevation angle <em>Elev<sub>Sun</sub></em> (rad);</li>
<li>Wind speed <em>w</em> (m/s).</li>
</ul>
<p>Firstly, it is necessary to select if the system includes a single-axis tracking system, to improve performance. This is done by selecting the boolean value \"true\" for the boolean variable \"Tracking\".</p>
<p>All angles are calculated in radians and all the temperatures are converted to Klevin. Sun Zenith <em>Zen<sub>Sun</sub></em> (rad)&nbsp;is determined as complementary angle of the solar elevation. The tracking axis angle <em>Track<sub>PV</sub></em> (rad) is assumed to be either zero (Southern Hemisphere) or pi (Northern Hemisphere).</p>
<p>Depending on the tracking system, the tilt angle of the collectors <em><span style=\"font-family: symbol;\">b</span><sub>c</sub></em> (rad), the rotation of the tracking angle <em>rot</em> (rad)&nbsp;and the actual collector azimuth angle <em>Azim<sub>PV</sub></em> (rad)&nbsp;are determined.</p>
<table style=\"height: 159px; margin-left: auto; margin-right: auto;\" width=\"439\">
<tbody>
<tr>
<td><strong>Fixed tilt&nbsp;</strong></td>
<td style=\"text-align: left;\"><strong>Single axis tracking</strong></td>
</tr>
<tr>
<td><em>rot = 0</em></td>
<td style=\"text-align: left;\"><em>rot = atan(tan(Zen<sub>Sun</sub>)&nbsp;<span style=\"font-family: symbol;\"><span style=\"font-family: verdana, geneva;\">&middot;&nbsp;</span></span>sin(Azim<sub>Sun</sub> - Azim<sub>PV</sub>))</em></td>
</tr>
<tr>
<td><em><span style=\"font-family: symbol;\">b</span><sub>c&nbsp;</sub>= f(Lat)</em></td>
<td style=\"text-align: left;\"><em>&nbsp;<span style=\"font-family: symbol;\">b</span><sub>c&nbsp;</sub>=&nbsp;abs(rot)</em></td>
</tr>
<tr>
<td><em>Azim<sub>PV</sub> = Track<sub>PV</sub></em></td>
<td style=\"text-align: left;\"><em>&nbsp;Azim<sub>PV</sub> = Track<sub>PV</sub> + asin(sin(rot) / sin(<span style=\"font-family: symbol;\">b</span><sub>c</sub>))</em></td>
</tr>
</tbody>
</table>
<p>At this point, the incidence angle <em><span style=\"font-family: symbol;\">q<sub><span style=\"font-family: verdana, geneva;\">b</span></sub></span></em>&nbsp;(rad) and cosine efficiency cos(<em><span style=\"font-family: symbol;\">q<sub><span style=\"font-family: verdana, geneva;\">b</span></sub></span></em>)&nbsp;can be calculated:&nbsp;</p>
<p><em><span style=\"font-family: symbol;\">q<sub><span style=\"font-family: verdana, geneva;\">b&nbsp;</span></sub><span style=\"font-family: verdana, geneva;\">= acos(cos(<span style=\"font-family: symbol;\">b</span><sub>c</sub>)&nbsp;&middot; cos(Zen<sub>Sun</sub>) + sin(<span style=\"font-family: symbol;\">b</span><sub>c</sub>)&nbsp;&middot; sin(Zen<sub>Sun</sub>)&nbsp;&middot; cos(Azim<sub>Sun&nbsp;</sub>- Azim<sub>PV</sub>))</span></span></em></p>
<p>Referring to [1], actual incidence angles for beam <em>G<sub>b </sub></em>(W), diffuse <em>G<sub>d</sub>&nbsp;</em>(W) and global irradiance <em>G<sub>g</sub></em>&nbsp;(W) are determined by&nbsp;multiplying TMY&nbsp;irradiance with incidence angle modifiers <em>IAM<sub>b</sub></em>, <em>IAM<sub>d</sub></em> and <em>IAM<sub>g</sub></em>&nbsp;based on trasmittance and optical properties of glass.&nbsp;</p>
<p>Air mass <em>AM</em> is determined and from it the air mass modifier coefficient <em>M</em> can be derived and used to finally obtain the usefuyl irradiance on the tilted collector <em>G</em> (W).</p>
<p><em>G = M&nbsp;<span style=\"font-family: symbol;\"><span style=\"font-family: verdana, geneva;\">&middot; (G<sub>b</sub>&nbsp;&middot; IAM<sub>b</sub> + G<sub>d</sub>&nbsp;&middot; IAM<sub>d</sub> + G<sub>g</sub>&nbsp;&middot; IAM<sub>g</sub>)</span></span></em></p>", revisions = ""), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {128, 128, 128}, fillColor = {149, 23, 41}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 20), Polygon(visible = true, origin = {0.297, -66.13}, lineColor = {255, 255, 255}, fillColor = {149, 23, 41}, lineThickness = 2.5, points = {{-4.305, 21.377}, {-4.305, 0.67}, {-14.769, -1.905}, {-14.769, -11.905}, {-0.297, -17.142}, {14.843, -11.905}, {14.843, -1.905}, {4.379, 1.338}, {4.379, 21.377}}), Rectangle(visible = true, origin = {0, 1.965}, lineColor = {255, 255, 255}, fillColor = {149, 23, 41}, fillPattern = FillPattern.Solid, lineThickness = 2.5, extent = {{-50, -50}, {50, 50}}), Line(visible = true, origin = {-40, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {-30, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {-20, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {-10, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {10, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {30, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {40, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {20, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, 41.965}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, 31.965}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, 21.965}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, 11.965}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, 1.965}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, -8.035}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, -28.035}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, -38.035}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, -18.035}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Text(visible = true, origin = {0, 70}, textColor = {255, 255, 255}, extent = {{-75, -16.216}, {75, 16.216}}, textString = "FRONT", textStyle = {TextStyle.Bold})}), experiment(__Wolfram_SynchronizeWithRealTime = false), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end BifacialPVfront;
