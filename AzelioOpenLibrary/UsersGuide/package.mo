within AzelioOpenLibrary;

package UsersGuide "User's Guide"
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Ellipse(visible = true, lineColor = {149, 23, 41}, fillColor = {149, 23, 41}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Text(visible = true, origin = {-0.816, 0}, textColor = {255, 255, 255}, extent = {{-100.816, -100}, {100.816, 100}}, textString = "i", textStyle = {TextStyle.Bold, TextStyle.Italic})}), DocumentationClass = true, Documentation(info = "<html><div>
<div>
<p>The library, written in Modelica, contains simplified models of a Stirling engine and a latent heat thermal storage (TES). The core power unit is a model of Azelio's in-house Stirling engine working gas channel [1], while the the thermal energy storage model is of a latent heat thermal storage [2]. Auxiliary components required to build a complete system are included, such as generator, cooling system, heat resistance, generic loss model, wind turbine and pv panel. Several example systems are included.</p>
<p>1. M. Nilsson et al, \"A Stirling Engine for Thermal Energy Storage\", Proceedings of SolarPACES2018, Casablanca, Morocco, 2018</p>
<p>2. T. Lindqvist, et al., A novel modular and dispatchable CSP Stirling system: design, validation, and demonstration plans, Submitted to SOLARPACES 2018: International Conference on Concentrating Solar Power and Chemical Energy Systems, American Institute of Physics, 2018&rdquo;</p>
</div>
</div>
<div>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody>
<tr>
<td>Power cycle models</td>
<td>Library of power conversion units. Currently containing one model, that of a Stirling engine</td>
</tr>
<tr>
<td>Loss models</td>
<td>Library for loss models. The sole model in this library allows , e.g., modelling of mechanical losses such as friction</td>
</tr>
<tr>
<td>Thermal models</td>
<td>Library of thermal models, such as simplified models representing a cooling system or heat resistance</td>
</tr>
<tr>
<td>Energy storage</td>
<td>Library containing a latent heat enrgy storage model in 0D and its enclosure</td>
</tr>
<tr>
<td>Electrical models</td>
<td>Library of electrical equipment such as generator, inverter and photovoltaic panels</td>
</tr>
<tr>
<td>Optical models</td>
<td>Library of optical mirror based concentrators for modelling of concentrated solar power</td>
</tr>
<tr>
<td>Wind turbines</td>
<td>Library of models related to wind turbine simulation</td>
</tr>
<tr>
<td>Gensets</td>
<td>Library containing simple models of generator sets fueled by combustible fuel, such as Diesel engines</td>
</tr>
<tr>
<td>Examples</td>
<td>Library of example systems</td>
</tr>
<tr>
<td>Utilities</td>
<td>Library with some practical utility models, such as the custom clock allwing arbitrary start time</td>
</tr>
</tbody>
</table>
</div></html>"));
end UsersGuide;
