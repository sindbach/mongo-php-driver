--TEST--
DBPointer type (deprecated): short OID (greater than minimum, but truncated)
--DESCRIPTION--
Generated by scripts/convert-bson-corpus-tests.php

DO NOT EDIT THIS FILE
--FILE--
<?php

require_once __DIR__ . '/../utils/tools.php';

$bson = hex2bin('1A0000000C61000300000061620056E1FC72E0C917E9C4716100');

throws(function() use ($bson) {
    var_dump(toPHP($bson));
}, 'MongoDB\Driver\Exception\UnexpectedValueException');

?>
===DONE===
<?php exit(0); ?>
--EXPECT--
OK: Got MongoDB\Driver\Exception\UnexpectedValueException
===DONE===