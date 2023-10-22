-- DB update 2023_03_09_01 -> 2023_03_09_02
DELETE FROM `quest_request_items_locale` WHERE `ID` IN (306, 310, 312, 313, 319, 332, 335, 347, 353, 370, 371, 372, 374, 378, 379, 380, 384, 385, 404, 409, 410, 412, 421, 427, 429, 433) AND `locale` = 'deDE';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(306, 'deDE', 'Habt Ihr Merrin gefunden? Hat sie eine Nachricht geschickt?', 0),
(310, 'deDE', 'Die Datumsangabe auf diesem Fass legt nahe, dass es demnächst angestochen werden wird.', 0),
(312, 'deDE', 'Habt Ihr es geschafft, an den Inhalt meiner Fleischtruhe ranzukommen, $N?', 0),
(313, 'deDE', 'He, $N. Wart Ihr schon im Graufelsbau? Diese Wendigos können ziemlich heftig sein.', 0),
(319, 'deDE', 'Habt Ihr Euch um die wilden Tiere gekümmert?', 0),
(332, 'deDE', 'Seid gegrüßt und fühlt Euch willkommen, $Gedler Herr:edle Dame;. Habt Ihr schon einmal einen unserer ausgezeichneten Weine versucht?', 0),
(335, 'deDE', 'Wischock wird bald genug Unterstützung haben, um uns jede Menge Ärger zu machen. Habt Ihr es endlich geschafft, Euch die Tilloaträne oder die Bisamwurzel anzueignen?', 0),
(347, 'deDE', 'Habt Ihr das Rethbanerz?', 0),
(353, 'deDE', 'Ihr seid den ganzen weiten Weg von Sturmwind gekommen? Ich habe gehört, es wird da unten in den Menschenlanden dank herumlaufender Briganten und Orcs etwas brenzlig. An einem solchen Ort kann $Gein:eine; $C sich perfekt beweisen!', 0),
(370, 'deDE', '$GJunger:Junge; $C, Ihr solltet Eure Zeit nicht hier in Brill vergeuden, wenn Euer Volk Euch im Kampf für ihre Sache braucht. Nun, nehmt die Waffen in die Hand und reist nach Südwesten, zum verfallenen Turm, und tötet Hauptmann Perrine zusammen mit 3 Scharlachroten Zeloten und 3 Scharlachroten Missionaren. Wir werden den Scharlachroten Kreuzzug wie Vieh zum Schlachter treiben.', 0),
(371, 'deDE', 'Wie ich sehe, seid Ihr zurückgekehrt, aber Eure Aufgabe ist noch nicht erfüllt. Vielleicht ist es Euch ja recht, dass die Menschen den Plan der Dunklen Fürstin durchkreuzen? Oder aber Ihr folgt dem Ruf der Pflicht und tötet Hauptmann Vachon und seine Bande von Scharlachroten Ordensmitgliedern!', 0),
(372, 'deDE', 'Ihr habt Eure Pflicht noch nicht erfüllt, $C.  Wir können nicht erwarten, dass wir den Plan der Dunklen Fürstin ausführen, wenn der Scharlachrote Kreuzzug unsere Soldaten bedrängt. Bringt ihren Tod herbei und erfüllt Eure Pflicht gegenüber Sylvanas!', 0),
(374, 'deDE', 'Habt Ihr bereits 10 Scharlachrote Insignienringe gesammelt, $C?', 0),
(378, 'deDE', 'Ich werde nicht zulassen, dass närrische Menschen-Bürokratie zwergischen Angelegenheiten in die Quere kommt, $N. Kam Tiefenzorn ist erwiesenermaßen einer der Verschwörer des Angriffs auf den Thandolübergang. König Magnis gute Gefolgsleute ließen dank Tiefenzorns Verrat ihr Leben. Den Menschen mag es genug sein, Tiefenzorn im Verlies verrotten zu lassen, aber ich werde nicht mehr ruhig schlafen, bis Tiefenzorn erschlagen ist.', 0),
(379, 'deDE', 'Na, haben die Nomaden Euch die Wasserbeutel "freiwillig" gegeben?', 0),
(380, 'deDE', 'Nehmt Euch vor dem Gift der Spinnen in Acht, $N. Wenn Ihr ein starkes Brennen spürt, solltet Ihr es untersuchen lassen.', 0),
(384, 'deDE', 'Ich werde sechs Klippeneberrippchen und einen Krug Rhapsodiemalz benötigen, $N.', 0),
(385, 'deDE', 'Hab ich Euch eigentlich erzählt, wie ich damals beinahe meine Hand an einen der Kroks verloren hätte? Ein übles Viech war das, mit Zähnen wie Messer. Aber ich hatte Glück... Hab dem Monster mit meinem Messer das Maul gestopft. Ich habe das Messer sogar noch irgendwo herumliegen...', 0),
(404, 'deDE', 'Habt Ihr die Aufgabe erledigt, die ich Euch auftrug? Habt Ihr die Eitrigen Klauen?', 0),
(409, 'deDE', 'Ich erwarte Euren Treuebeweis, $C.', 0),
(410, 'deDE', 'Dies ist ein alter, abgewetzter, blutiger Tisch.', 0),
(412, 'deDE', 'Der Rekombobulator wird laufen wie geschmiert, sobald wir ausreichend Restabilisationszahnräder und Gyromechanische Getriebeteile haben.', 0),
(421, 'deDE', 'Wenn Ihr Euch mir gegenüber beweisen wollt, müsst Ihr 5 Weißskalpe des Mondzorns töten. Erfüllt diese Aufgabe und ich werde dafür sorgen, dass Eure Fähigkeiten für würdigere Aufgaben eingesetzt werden.', 0),
(427, 'deDE', 'Wenn Ihr der Dunklen Fürstin Euren Wert beweisen wollt, müsst Ihr 10 Scharlachrote Krieger töten, $C.', 0),
(429, 'deDE', 'Meine Zeit ist knapp, $C, denn die Dunkle Fürstin hat mich mit einer wichtigen Aufgabe betraut.', 0),
(433, 'deDE', 'Wenn wir die Troggs vom Steinbruch von Gol\'Bolar entfernen können, wäre das der Erste von vielen Schritten, die wir unternehmen müssen, um uns von dieser Bedrohung zu befreien.', 0);
