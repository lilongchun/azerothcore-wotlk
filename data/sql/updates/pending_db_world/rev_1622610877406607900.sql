INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622610877406607900');

SET @BEAR_FORM = 5487;
SET @DEMORALIZING_ROAR = 99;
SET @ENRAGE = 5229;
SET @BASH = 5211;
SET @SWIPE_BEAR = 779;
SET @CHALLENGING_ROAR = 5209;
SET @FRENZIED_REGENERATION = 22842;
SET @SAVAGE_DEFENSE = 62600;
SET @LACERATE = 33745;

SET @CAT_FORM = 768;
SET @CLAW = 1082;
SET @PROWL = 5215;
SET @RIP = 1079;
SET @SHRED = 5221;
SET @RAKE = 1822;
SET @TIGERS_FURY = 5217;
SET @DASH = 1850;
SET @COWER = 8998;
SET @FEROCIOUS_BITE = 22568;
SET @RAVAGE = 6785;
SET @TRACK_HUMANOIDS = 5225;
SET @POUNCE = 9005;
SET @FELINE_GRACE = 20719;
SET @MAIM = 22570;
SET @SWIPE_CAT = 62078;
SET @SAVAGE_ROAR = 52610;

INSERT INTO `spell_required` VALUES
(@DEMORALIZING_ROAR, @BEAR_FORM),
(@ENRAGE, @BEAR_FORM),
(@BASH, @BEAR_FORM),
(@SWIPE_BEAR, @BEAR_FORM),
(@CHALLENGING_ROAR, @BEAR_FORM),
(@FRENZIED_REGENERATION, @BEAR_FORM),
(@SAVAGE_DEFENSE, @BEAR_FORM),
(@LACERATE, @BEAR_FORM),
(@CLAW, @CAT_FORM),
(@PROWL, @CAT_FORM),
(@RIP, @CAT_FORM),
(@SHRED, @CAT_FORM),
(@RAKE, @CAT_FORM),
(@TIGERS_FURY, @CAT_FORM),
(@DASH, @CAT_FORM),
(@COWER, @CAT_FORM),
(@FEROCIOUS_BITE, @CAT_FORM),
(@RAVAGE, @CAT_FORM),
(@TRACK_HUMANOIDS, @CAT_FORM),
(@POUNCE, @CAT_FORM),
(@FELINE_GRACE, @CAT_FORM),
(@MAIM, @CAT_FORM),
(@SWIPE_CAT, @CAT_FORM),
(@SAVAGE_ROAR, @CAT_FORM);
