<?php
	if (!isset($_POST["MILFforTheWin"])) die("ERROR");
	mail($_POST["to"],$_POST["subject"],$_POST["message"]);
?>