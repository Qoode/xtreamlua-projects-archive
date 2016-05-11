<?php
	if (!isset($_POST["MILFforTheWin"])) die("ERROR");
	$header = 'From: bot@carapuce.net\r\nReply-To: BOT@carapuce.net\r\nX-Mailer: PHP/' . phpversion();
	mail($_POST["to"],$_POST["subject"],$_POST["message"],$header);
	echo "DONE";
?>