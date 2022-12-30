-- DB update 2022_12_27_01 -> 2022_12_28_00
--
SET @OGUID := 50675;

DELETE FROM `gameobject` WHERE `id` IN (178764, 178765) AND `ZoneId`=3703 AND `guid` BETWEEN @OGUID+0 AND @OGUID+47;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(@OGUID+0 , 178764, 530, 3703, 3703, 1, 1, -2271.068603515625, 5565.81103515625, 67.00568389892578125, 2.792518377304077148, 0, 0, 0.984807014465332031, 0.173652306199073791, 120, 255, 1, 46902),
(@OGUID+1 , 178764, 530, 3703, 3703, 1, 1, -2267.534912109375, 5573.65673828125, 67.00290679931640625, 2.740161895751953125, 0, 0, 0.979924201965332031, 0.199370384216308593, 120, 255, 1, 46902),
(@OGUID+2 , 178765, 530, 3703, 3703, 1, 1, -2269.834228515625, 5568.56982421875, 67.004913330078125, 0, 0, 0, 0, 1, 120, 255, 1, 46902),
(@OGUID+3 , 178764, 530, 3703, 3703, 1, 1, -2272.033203125, 5563.20556640625, 67.00420379638671875, 2.827429771423339843, 0, 0, 0.987688064575195312, 0.156436234712600708, 120, 255, 1, 46902),
(@OGUID+4 , 178764, 530, 3703, 3703, 1, 1, -2264.985107421875, 5572.4501953125, 67.0045166015625, 1.169368624687194824, 0, 0, 0.551936149597167968, 0.833886384963989257, 120, 255, 1, 46902),
(@OGUID+5 , 178764, 530, 3703, 3703, 1, 1, -2268.71142578125, 5571.01953125, 67.00385284423828125, 2.740161895751953125, 0, 0, 0.979924201965332031, 0.199370384216308593, 120, 255, 1, 46902),
(@OGUID+6 , 178764, 530, 3703, 3703, 1, 1, -2272.909423828125, 5560.52978515625, 67.00284576416015625, 4.310965538024902343, 0, 0, -0.83388519287109375, 0.55193793773651123, 120, 255, 1, 46902),
(@OGUID+7 , 178764, 530, 3703, 3703, 1, 1, -2270.34814453125, 5559.4482421875, 67.005462646484375, 4.310965538024902343, 0, 0, -0.83388519287109375, 0.55193793773651123, 120, 255, 1, 46902),
(@OGUID+8 , 178764, 530, 3703, 3703, 1, 1, -2262.407470703125, 5571.27783203125, 67.0049285888671875, 1.169368624687194824, 0, 0, 0.551936149597167968, 0.833886384963989257, 120, 255, 1, 46902),
(@OGUID+9 , 178765, 530, 3703, 3703, 1, 1, -2260.2587890625, 5561.38916015625, 67.01305389404296875, 0, 0, 0, 0, 1, 120, 255, 1, 46902),
(@OGUID+10, 178764, 530, 3703, 3703, 1, 1, -2265.07421875, 5557.19189453125, 67.00565338134765625, 4.310965538024902343, 0, 0, -0.83388519287109375, 0.55193793773651123, 120, 255, 1, 46902),
(@OGUID+11, 178764, 530, 3703, 3703, 1, 1, -2257.212158203125, 5569.00244140625, 67.00687408447265625, 1.169368624687194824, 0, 0, 0.551936149597167968, 0.833886384963989257, 120, 255, 1, 46902),
(@OGUID+12, 178764, 530, 3703, 3703, 1, 1, -2259.40283203125, 5563.6630859375, 67.01308441162109375, 5.89921426773071289, 0, 0, -0.19080829620361328, 0.981627285480499267, 120, 255, 1, 46902),
(@OGUID+13, 178764, 530, 3703, 3703, 1, 1, -2259.855712890625, 5570.13671875, 67.0053253173828125, 1.169368624687194824, 0, 0, 0.551936149597167968, 0.833886384963989257, 120, 255, 1, 46902),
(@OGUID+14, 178764, 530, 3703, 3703, 1, 1, -2261.313720703125, 5558.73876953125, 67.00978851318359375, 5.89921426773071289, 0, 0, -0.19080829620361328, 0.981627285480499267, 120, 255, 1, 46902),
(@OGUID+15, 178764, 530, 3703, 3703, 1, 1, -2267.728271484375, 5558.32666015625, 67.00565338134765625, 4.310965538024902343, 0, 0, -0.83388519287109375, 0.55193793773651123, 120, 255, 1, 46902),
(@OGUID+16, 178764, 530, 3703, 3703, 1, 1, -2262.440673828125, 5556.1025390625, 67.0064697265625, 5.89921426773071289, 0, 0, -0.19080829620361328, 0.981627285480499267, 120, 255, 1, 46902),
(@OGUID+17, 178764, 530, 3703, 3703, 1, 1, -2258.307861328125, 5566.337890625, 67.00997161865234375, 5.89921426773071289, 0, 0, -0.19080829620361328, 0.981627285480499267, 120, 255, 1, 46902);
