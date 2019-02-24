<?php
echo($_ENV['male']." et ".$_ENV['femelle']);
echo(' </p>
<table>
 <tr>
  <td><H3>M&egrave;re : </H3></td>
  <td><h4>'.$_ENV['femelle'].'</h4></td>
  <td width="250" align="center"></td>
  <td width="250" align="center"></td>
 </tr>
 <tr>
  <td width="150"><br></td>
  <td><img src="'.$_ENV['femelle_img'].'" height="125"></td>
  <td width="250" align="center"></td>
  <td width="250" align="center"></td>
 </tr>
 <tr>
  <td colspan="3" align="right"><h4>Les chiots</h4><ul style="list-style-type:none; ">
		  <li>Epsyyellow de Notre chaumiere</li><li>Emi de notre chaumiere</li>
		  <li>Elvis de notre chaumiere</li><li>Elliot de notre chaumiere</li></ul>
  </td>
  <td align="right" width="200"><a href="galerie.php?gallerie='.$_GET['gallerie'].'"><img alt="Lien vers gallerie" border="0" src="Images/gallerie.png"></a></td>
 </tr>
 <tr>
  <td><H3>P&egrave;re : </H3></td>
  <td><h4>'.$parent_res['male'].'</h4></td>
  <td width="250" align="center"></td>
  <td width="250" align="center"></td>
 </tr>
 <tr>
  <td width="150"><br></td>
  <td><img src="'.$parent_res['male_img'].'" height="125"></td>
  <td width="250"></td>
  <td width="250" align="center"></td>
 </tr>
</table>');
 		?>	
	   </div>
	<!--****Fin du contenu****-->
<!--///////////////////////////////////////////////////////////////////////////////////////-->

<!--///////////////////////////////////////////////////////////////////////////////////////-->
	<!--****Pied de page****-->
		<div id="footer">
			<p>Site &agrave; usage personnel, effectu&eacute; par mon fils &agrave; l'aide de certains sites et de copains.</p>
		</div>
	<!--****fin du pied de page****-->
<!--///////////////////////////////////////////////////////////////////////////////////////-->
</div>
<!--Fin de la page-->
</body>
</html>