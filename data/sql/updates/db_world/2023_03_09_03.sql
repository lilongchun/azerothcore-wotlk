-- DB update 2023_03_09_02 -> 2023_03_09_03
DELETE FROM `quest_request_items_locale` WHERE `ID` IN (455, 457, 470, 471, 487, 488, 498, 501, 509, 513, 516, 518, 526, 527, 528, 531, 541, 545, 549, 567, 569, 574, 575, 579, 593, 598) AND `locale` = 'deDE';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(455, 'deDE', 'Ihr kommt vom Loch Modan? Wie sieht es mit den Orcs beim Algaztor aus?', 0),
(457, 'deDE', 'Eure Aufgabe ist noch nicht erfüllt, $N. Kehrt zu mir zurück, wenn 5 Räudige Nachtsäbler und 5 Disteleber getötet wurden.', 0),
(470, 'deDE', 'Habt Ihr meine Tasche gefunden?', 0),
(471, 'deDE', 'Mein Lehrling ist wie ein Sohn für mich. Wird hart für ihn sein, sein Leben mit nur einem Bein zu fristen.$B$BAh, $N, wie läuft\'s? Habt Ihr meine Häute?', 0),
(487, 'deDE', 'Die Straße ist noch immer nicht sicher, $C. Kehrt um und erschlagt 6 Wegelagerer der Knarzklauen und kommt zu mir zurück.', 0),
(488, 'deDE', 'Ihr wart also ein fleißiges Bienchen, $N? Ich habe darauf gewartet, dass Ihr mir das bringt, was ich benötige.', 0),
(498, 'deDE', 'Ihr müsst Euch beeilen, $C. Mich schaudert es bei dem Gedanken, was die Menschen Drull und Tog\'thar antun könnten.', 0),
(501, 'deDE', 'Ich erinnere mich an Euch, $N. Ihr wolltet mir dabei helfen mein neuestes Elixier zu brauen. Das Blut brauche ich, um den Einwohnern des Hügellands mein höchsteigenes, hausgemachtes Spezial-Elend zu präsentieren.', 0),
(509, 'deDE', 'Hattet Ihr Erfolg in der Nethandersiedlung?', 0),
(513, 'deDE', 'Könnt Ihr nicht sehen, $C, dass ich beschäftigt bin? Die Dunkle Fürstin besteht auf einer neuen Pest, bevor die Vorhut der Geißel aus Nordend uns überwältigt. Und dann noch die menschliche Bedrohung aus dem Süden. Meine Zeit ist im Augenblick sehr wertvoll. Es ist hoffentlich von Bedeutung!', 0),
(516, 'deDE', 'Habt Ihr ihr Lager bereits entdeckt? Die Zeit drängt!', 0),
(518, 'deDE', 'Ich stelle fest, dass Eure Aufgabe unvollendet ist, $N. Soll ich Sharlindra über Eure Unfähigkeit informieren?', 0),
(526, 'deDE', 'Habt Ihr das Lichtgeschmiedete Eisen gefunden, das Ihr braucht?', 0),
(527, 'deDE', 'Als Hochexekutorin von Tarrens Mühle, die unter dem direkten Befehl von Varimathras und der Dunklen Fürstin steht, müsst Ihr meinem Befehl folgen.$B$BVielleicht nehmt Ihr diesen Krieg mit der Allianz auf die leichte Schulter?  Wenn das der Fall ist, sollte ich Euch hier und jetzt enthaupten.  Andernfalls reist nach Westen zu den Feldern des Hügellands und führt den Kampf gegen die Menschen, wie befohlen.$B$BWegtreten.', 0),
(528, 'deDE', 'Ihr habt Eure Befehle, $C. Hört auf, hier in Tarrens Mühle zu trödeln, wenn es anderswo Arbeit zu erledigen gibt.', 0),
(531, 'deDE', 'Sehr gute Arbeit, $N! Wir habens ihm wirklich gezeigt! Hier, gebt mir den Kopf, ich werde mich darum kümmern.', 0),
(541, 'deDE', 'Dun Garok erweist sich als ein zu großes Hindernis für Euch, $C? Und ich dachte, Ihr hättet Euch im Hügelland tapfer behauptet.$B$BWenn Ihr der Euch zugewiesenen Aufgabe nicht gewachsen seid, werde ich jemand anderes finden, der bessere Ergebnisse erzielen kann. Was Euch betrifft, so bin ich mir sicher, dass die Dunkle Fürstin in Tirisfal immer mehr Totengräber gebrauchen kann.', 0),
(545, 'deDE', 'Habt Ihr die Patrouillen von Dalaran an den Ruinen bereits ausgedünnt?', 0),
(549, 'deDE', 'Habt Ihr nichts Besseres zu tun, als hier vor mir zu stehen, $C? Als Hochexekutorin habe ich Dringenderes zu tun, als Eure verrottende Visage anzustarren.', 0),
(567, 'deDE', 'Ja?', 0),
(569, 'deDE', 'Habt Ihr schon Fortschritte bei den Ogern in den Ruinen von Mizjah gemacht, $C?', 0), 
(574, 'deDE', 'Unteroffizier Yohwa sagte mir, dass Ihr geschickt und mutig seid, $C. Habt Ihr etwas zu berichten?', 0),
(575, 'deDE', 'Meine Ausrüstung ist startklar, $N, ich warte nur noch auf die Häute. Wir wollen Quizvox ja nicht warten lassen.$B$BEs ist für niemanden gut, wenn der Cheferfinder des Tüftlerverbands unzufrieden ist.', 18019),
(579, 'deDE', 'König Varian betrachtet Lernen als sehr wichtig und hat daher Geld zur Verfügung gestellt, damit verschiedene Folianten und Schriften kopiert und für die Öffentlichkeit zugänglich gemacht werden können. Es ist ganz einfach, Ihr bringt mir einen Bibliotheksschein, und ich gebe Euch ein Exemplar eines der verfügbaren Bücher.', 0),
(593, 'deDE', 'Yenniku steht betäubt vor Euch, sein Geist an einem anderen Ort...', 0),
(598, 'deDE', 'Die Schädelspalter werden den Tag verdammen, an dem sie uns den Krieg erklärten! Ist Eure Aufgabe erfüllt?', 0);
