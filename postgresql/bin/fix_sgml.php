#!/usr/bin/php
<?php

$fd = fopen($argv[1], 'r');

if ($fd === false) return 1;

$fifo = array();

$res = '';
while (($c = fgetc($fd)) !== false) {
	switch ($c) {
		case '<':
			$c = fgetc($fd);
			/* closing tag */
			if ($c == '/') {
				$res.= '</'. array_pop($fifo) . '>';
				while ($c != '>') $c = fgetc($fd);
			}
			/* handle CDATA code and comments*/
			else if ($c == '!') {
                $c = fgets($fd,3);
                $d = '';
				if ($c == '--') {
                    //echo "\n####COMMENT detected####\n";
					$res.= "<!";
					do {
						do {
							$res.= $c;
							$c = fgetc($fd);
						} while ($c != '-');
						$res.= '-';
					} while (($c = fgets($fd, 3)) != '->');
					$res.= '->';
				}
				else if ($c == '[C' && (($d = fgets($fd,6)) == 'DATA[')) {
                    //echo "\n####CDATA detected####\n";
					$res.= "<!";
                    $c.= $d;
					do {
						do {
							$res.= $c;
							$c = fgetc($fd);
						} while ($c != ']');
						$res.= ']';
					} while (($c = fgets($fd, 3)) != ']>');
					$res.= ']>';
				}
				else {
					$res.= "<!{$c}{$d}";
				}
			}
			else {
				$tag = $c;
				$c = fgetc($fd);
				$params = '';
				/* get the tag name */
				do {
					$tag.= $c;
					$c = fgetc($fd);
				} while (($c != ' ') && ($c != "\t") && ($c != "\n") && ($c != '>'));

				/* get params, find the end of the tag */
				if ($c != '>') {
					do {
						$params .= $c;
						$c = fgetc($fd);
					} while ($c != '>');
				}
                
                /* check if last character of $params is a slash
                 * if it is, remove it from the params
                 */
                if (strlen($params) > 1)
                    if ($params[strlen($params)-1] == '/')
                        $params = substr($params, 0, strlen($params)-1);
                /* do the same for tags */
                if ($tag[strlen($tag)-1] == '/')
                    $tag = substr($tag, 0, strlen($tag)-1);

				/* here, $c == '>' */
				if ($tag == 'xref' || $tag == 'colspec' || $tag == 'sbr' || $tag == 'co'
                    || $tag == 'spanspec') {
					$res.= "<{$tag}{$params}/>";
				}
				else {
					array_push($fifo, $tag);
					$res.= "<{$tag}{$params}>";
				}
			}
			break;
		default:
			$res.= $c;
	}
}

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
echo $res;
