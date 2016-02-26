<html>
<head>
<title>OCDP</title>
<style type="text/css">
#container {
    margin: 0 auto;
    border: 1px solid grey;
    width: 500px;
    padding: 15px;
    margin-top: 100px;
}
h3 {
    text-align: center;
}
</style>
</head>
<body>
<div id="container">
<h3>Auto-deploy Tool</h3>
<?php 
$pwd = $_POST["pwd"];
if (empty($pwd)) {
?>
    <form method="post" id="form">
        Input Password:
        <input type="password" id="pwd" name="pwd" value="<?php echo $_POST['pwd'];?>">
        <input type="submit" value="Deploy">
    </form>
<?php 
} else {
    $command = "sudo /home/git/ocdp/sh/deploy.sh $pwd";
    $logFileName = "/tmp/deploy_".date('Ymd_His').".log";
    $logFile = fopen($logFileName, 'w') or die('File: '.$logFileName.' open failed!');;
    exec($command, $outputArray, $returnVal);
    foreach ($outputArray as $line) {
        echo $line.'<br/>';
        fwrite($logFile, $line.'\n');
    }
    fclose($logFile);
    if ($returnVal) {
        echo '<br/><span style="color:red;">执行失败！<br/>Details refer to /etc/httpd/logs/error_log</span>';
    } else {
        echo '<br/><span style="color:green;">执行完毕！<br/>Logs save in '.$logFileName.'</span>';
    }
}
?>
</div>
</body>
</html>