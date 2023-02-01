-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.29 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table acore_world.gtregenhpperspt_dbc
DROP TABLE IF EXISTS `gtregenhpperspt_dbc`;
CREATE TABLE IF NOT EXISTS `gtregenhpperspt_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=FIXED;

-- Dumping data for table acore_world.gtregenhpperspt_dbc: 1,100 rows
DELETE FROM `gtregenhpperspt_dbc`;
/*!40000 ALTER TABLE `gtregenhpperspt_dbc` DISABLE KEYS */;
INSERT INTO `gtregenhpperspt_dbc` (`ID`, `Data`) VALUES
	(0, 1.5),
	(1, 1.38679),
	(2, 1.28213),
	(3, 1.18536),
	(4, 1.0959),
	(5, 1.01319),
	(6, 0.936722),
	(7, 0.866025),
	(8, 0.800664),
	(9, 0.740236),
	(10, 0.684369),
	(11, 0.632718),
	(12, 0.584965),
	(13, 0.540817),
	(14, 0.5),
	(15, 0.5),
	(16, 0.5),
	(17, 0.5),
	(18, 0.5),
	(19, 0.5),
	(20, 0.5),
	(21, 0.5),
	(22, 0.5),
	(23, 0.5),
	(24, 0.5),
	(25, 0.5),
	(26, 0.5),
	(27, 0.5),
	(28, 0.5),
	(29, 0.5),
	(30, 0.5),
	(31, 0.5),
	(32, 0.5),
	(33, 0.5),
	(34, 0.5),
	(35, 0.5),
	(36, 0.5),
	(37, 0.5),
	(38, 0.5),
	(39, 0.5),
	(40, 0.5),
	(41, 0.5),
	(42, 0.5),
	(43, 0.5),
	(44, 0.5),
	(45, 0.5),
	(46, 0.5),
	(47, 0.5),
	(48, 0.5),
	(49, 0.5),
	(50, 0.5),
	(51, 0.5),
	(52, 0.5),
	(53, 0.5),
	(54, 0.5),
	(55, 0.5),
	(56, 0.5),
	(57, 0.5),
	(58, 0.5),
	(59, 0.5),
	(60, 0.5),
	(61, 0.5),
	(62, 0.5),
	(63, 0.5),
	(64, 0.5),
	(65, 0.5),
	(66, 0.5),
	(67, 0.5),
	(68, 0.5),
	(69, 0.5),
	(70, 0.5),
	(71, 0.5),
	(72, 0.5),
	(73, 0.5),
	(74, 0.5),
	(75, 0.5),
	(76, 0.5),
	(77, 0.5),
	(78, 0.5),
	(79, 0.5),
	(80, 0.5),
	(81, 0.5),
	(82, 0.5),
	(83, 0.5),
	(84, 0.5),
	(85, 0.5),
	(86, 0.5),
	(87, 0.5),
	(88, 0.5),
	(89, 0.5),
	(90, 0.5),
	(91, 0.5),
	(92, 0.5),
	(93, 0.5),
	(94, 0.5),
	(95, 0.5),
	(96, 0.5),
	(97, 0.5),
	(98, 0.5),
	(99, 0.5),
	(100, 0.375),
	(101, 0.346698),
	(102, 0.320532),
	(103, 0.29634),
	(104, 0.273975),
	(105, 0.253297),
	(106, 0.234181),
	(107, 0.216506),
	(108, 0.200166),
	(109, 0.185059),
	(110, 0.171092),
	(111, 0.15818),
	(112, 0.146241),
	(113, 0.135204),
	(114, 0.125),
	(115, 0.125),
	(116, 0.125),
	(117, 0.125),
	(118, 0.125),
	(119, 0.125),
	(120, 0.125),
	(121, 0.125),
	(122, 0.125),
	(123, 0.125),
	(124, 0.125),
	(125, 0.125),
	(126, 0.125),
	(127, 0.125),
	(128, 0.125),
	(129, 0.125),
	(130, 0.125),
	(131, 0.125),
	(132, 0.125),
	(133, 0.125),
	(134, 0.125),
	(135, 0.125),
	(136, 0.125),
	(137, 0.125),
	(138, 0.125),
	(139, 0.125),
	(140, 0.125),
	(141, 0.125),
	(142, 0.125),
	(143, 0.125),
	(144, 0.125),
	(145, 0.125),
	(146, 0.125),
	(147, 0.125),
	(148, 0.125),
	(149, 0.125),
	(150, 0.125),
	(151, 0.125),
	(152, 0.125),
	(153, 0.125),
	(154, 0.125),
	(155, 0.125),
	(156, 0.125),
	(157, 0.125),
	(158, 0.125),
	(159, 0.125),
	(160, 0.125),
	(161, 0.125),
	(162, 0.125),
	(163, 0.125),
	(164, 0.125),
	(165, 0.125),
	(166, 0.125),
	(167, 0.125),
	(168, 0.125),
	(169, 0.125),
	(170, 0.125),
	(171, 0.125),
	(172, 0.125),
	(173, 0.125),
	(174, 0.125),
	(175, 0.125),
	(176, 0.125),
	(177, 0.125),
	(178, 0.125),
	(179, 0.125),
	(180, 0.125),
	(181, 0.125),
	(182, 0.125),
	(183, 0.125),
	(184, 0.125),
	(185, 0.125),
	(186, 0.125),
	(187, 0.125),
	(188, 0.125),
	(189, 0.125),
	(190, 0.125),
	(191, 0.125),
	(192, 0.125),
	(193, 0.125),
	(194, 0.125),
	(195, 0.125),
	(196, 0.125),
	(197, 0.125),
	(198, 0.125),
	(199, 0.125),
	(200, 0.375),
	(201, 0.346698),
	(202, 0.320532),
	(203, 0.29634),
	(204, 0.273975),
	(205, 0.253297),
	(206, 0.234181),
	(207, 0.216506),
	(208, 0.200166),
	(209, 0.185059),
	(210, 0.171092),
	(211, 0.15818),
	(212, 0.146241),
	(213, 0.135204),
	(214, 0.125),
	(215, 0.125),
	(216, 0.125),
	(217, 0.125),
	(218, 0.125),
	(219, 0.125),
	(220, 0.125),
	(221, 0.125),
	(222, 0.125),
	(223, 0.125),
	(224, 0.125),
	(225, 0.125),
	(226, 0.125),
	(227, 0.125),
	(228, 0.125),
	(229, 0.125),
	(230, 0.125),
	(231, 0.125),
	(232, 0.125),
	(233, 0.125),
	(234, 0.125),
	(235, 0.125),
	(236, 0.125),
	(237, 0.125),
	(238, 0.125),
	(239, 0.125),
	(240, 0.125),
	(241, 0.125),
	(242, 0.125),
	(243, 0.125),
	(244, 0.125),
	(245, 0.125),
	(246, 0.125),
	(247, 0.125),
	(248, 0.125),
	(249, 0.125),
	(250, 0.125),
	(251, 0.125),
	(252, 0.125),
	(253, 0.125),
	(254, 0.125),
	(255, 0.125),
	(256, 0.125),
	(257, 0.125),
	(258, 0.125),
	(259, 0.125),
	(260, 0.125),
	(261, 0.125),
	(262, 0.125),
	(263, 0.125),
	(264, 0.125),
	(265, 0.125),
	(266, 0.125),
	(267, 0.125),
	(268, 0.125),
	(269, 0.125),
	(270, 0.125),
	(271, 0.125),
	(272, 0.125),
	(273, 0.125),
	(274, 0.125),
	(275, 0.125),
	(276, 0.125),
	(277, 0.125),
	(278, 0.125),
	(279, 0.125),
	(280, 0.125),
	(281, 0.125),
	(282, 0.125),
	(283, 0.125),
	(284, 0.125),
	(285, 0.125),
	(286, 0.125),
	(287, 0.125),
	(288, 0.125),
	(289, 0.125),
	(290, 0.125),
	(291, 0.125),
	(292, 0.125),
	(293, 0.125),
	(294, 0.125),
	(295, 0.125),
	(296, 0.125),
	(297, 0.125),
	(298, 0.125),
	(299, 0.125),
	(300, 1),
	(301, 0.924528),
	(302, 0.854751),
	(303, 0.790241),
	(304, 0.7306),
	(305, 0.67546),
	(306, 0.624481),
	(307, 0.57735),
	(308, 0.533776),
	(309, 0.493491),
	(310, 0.456246),
	(311, 0.421812),
	(312, 0.389977),
	(313, 0.360544),
	(314, 0.333333),
	(315, 0.333333),
	(316, 0.333333),
	(317, 0.333333),
	(318, 0.333333),
	(319, 0.333333),
	(320, 0.333333),
	(321, 0.333333),
	(322, 0.333333),
	(323, 0.333333),
	(324, 0.333333),
	(325, 0.333333),
	(326, 0.333333),
	(327, 0.333333),
	(328, 0.333333),
	(329, 0.333333),
	(330, 0.333333),
	(331, 0.333333),
	(332, 0.333333),
	(333, 0.333333),
	(334, 0.333333),
	(335, 0.333333),
	(336, 0.333333),
	(337, 0.333333),
	(338, 0.333333),
	(339, 0.333333),
	(340, 0.333333),
	(341, 0.333333),
	(342, 0.333333),
	(343, 0.333333),
	(344, 0.333333),
	(345, 0.333333),
	(346, 0.333333),
	(347, 0.333333),
	(348, 0.333333),
	(349, 0.333333),
	(350, 0.333333),
	(351, 0.333333),
	(352, 0.333333),
	(353, 0.333333),
	(354, 0.333333),
	(355, 0.333333),
	(356, 0.333333),
	(357, 0.333333),
	(358, 0.333333),
	(359, 0.333333),
	(360, 0.333333),
	(361, 0.333333),
	(362, 0.333333),
	(363, 0.333333),
	(364, 0.333333),
	(365, 0.333333),
	(366, 0.333333),
	(367, 0.333333),
	(368, 0.333333),
	(369, 0.333333),
	(370, 0.333333),
	(371, 0.333333),
	(372, 0.333333),
	(373, 0.333333),
	(374, 0.333333),
	(375, 0.333333),
	(376, 0.333333),
	(377, 0.333333),
	(378, 0.333333),
	(379, 0.333333),
	(380, 0.333333),
	(381, 0.333333),
	(382, 0.333333),
	(383, 0.333333),
	(384, 0.333333),
	(385, 0.333333),
	(386, 0.333333),
	(387, 0.333333),
	(388, 0.333333),
	(389, 0.333333),
	(390, 0.333333),
	(391, 0.333333),
	(392, 0.333333),
	(393, 0.333333),
	(394, 0.333333),
	(395, 0.333333),
	(396, 0.333333),
	(397, 0.333333),
	(398, 0.333333),
	(399, 0.333333),
	(400, 0.125),
	(401, 0.115566),
	(402, 0.106844),
	(403, 0.09878),
	(404, 0.091325),
	(405, 0.084432),
	(406, 0.07806),
	(407, 0.072169),
	(408, 0.066722),
	(409, 0.061686),
	(410, 0.057031),
	(411, 0.052727),
	(412, 0.048747),
	(413, 0.045068),
	(414, 0.041667),
	(415, 0.041667),
	(416, 0.041667),
	(417, 0.041667),
	(418, 0.041667),
	(419, 0.041667),
	(420, 0.041667),
	(421, 0.041667),
	(422, 0.041667),
	(423, 0.041667),
	(424, 0.041667),
	(425, 0.041667),
	(426, 0.041667),
	(427, 0.041667),
	(428, 0.041667),
	(429, 0.041667),
	(430, 0.041667),
	(431, 0.041667),
	(432, 0.041667),
	(433, 0.041667),
	(434, 0.041667),
	(435, 0.041667),
	(436, 0.041667),
	(437, 0.041667),
	(438, 0.041667),
	(439, 0.041667),
	(440, 0.041667),
	(441, 0.041667),
	(442, 0.041667),
	(443, 0.041667),
	(444, 0.041667),
	(445, 0.041667),
	(446, 0.041667),
	(447, 0.041667),
	(448, 0.041667),
	(449, 0.041667),
	(450, 0.041667),
	(451, 0.041667),
	(452, 0.041667),
	(453, 0.041667),
	(454, 0.041667),
	(455, 0.041667),
	(456, 0.041667),
	(457, 0.041667),
	(458, 0.041667),
	(459, 0.041667),
	(460, 0.041667),
	(461, 0.041667),
	(462, 0.041667),
	(463, 0.041667),
	(464, 0.041667),
	(465, 0.041667),
	(466, 0.041667),
	(467, 0.041667),
	(468, 0.041667),
	(469, 0.041667),
	(470, 0.041667),
	(471, 0.041667),
	(472, 0.041667),
	(473, 0.041667),
	(474, 0.041667),
	(475, 0.041667),
	(476, 0.041667),
	(477, 0.041667),
	(478, 0.041667),
	(479, 0.041667),
	(480, 0.041667),
	(481, 0.041667),
	(482, 0.041667),
	(483, 0.041667),
	(484, 0.041667),
	(485, 0.041667),
	(486, 0.041667),
	(487, 0.041667),
	(488, 0.041667),
	(489, 0.041667),
	(490, 0.041667),
	(491, 0.041667),
	(492, 0.041667),
	(493, 0.041667),
	(494, 0.041667),
	(495, 0.041667),
	(496, 0.041667),
	(497, 0.041667),
	(498, 0.041667),
	(499, 0.041667),
	(500, 1.5),
	(501, 1.38679),
	(502, 1.28213),
	(503, 1.18536),
	(504, 1.0959),
	(505, 1.01319),
	(506, 0.936722),
	(507, 0.866025),
	(508, 0.800664),
	(509, 0.740236),
	(510, 0.684369),
	(511, 0.632718),
	(512, 0.584965),
	(513, 0.540817),
	(514, 0.5),
	(515, 0.5),
	(516, 0.5),
	(517, 0.5),
	(518, 0.5),
	(519, 0.5),
	(520, 0.5),
	(521, 0.5),
	(522, 0.5),
	(523, 0.5),
	(524, 0.5),
	(525, 0.5),
	(526, 0.5),
	(527, 0.5),
	(528, 0.5),
	(529, 0.5),
	(530, 0.5),
	(531, 0.5),
	(532, 0.5),
	(533, 0.5),
	(534, 0.5),
	(535, 0.5),
	(536, 0.5),
	(537, 0.5),
	(538, 0.5),
	(539, 0.5),
	(540, 0.5),
	(541, 0.5),
	(542, 0.5),
	(543, 0.5),
	(544, 0.5),
	(545, 0.5),
	(546, 0.5),
	(547, 0.5),
	(548, 0.5),
	(549, 0.5),
	(550, 0.5),
	(551, 0.5),
	(552, 0.5),
	(553, 0.5),
	(554, 0.5),
	(555, 0.5),
	(556, 0.5),
	(557, 0.5),
	(558, 0.5),
	(559, 0.5),
	(560, 0.5),
	(561, 0.5),
	(562, 0.5),
	(563, 0.5),
	(564, 0.5),
	(565, 0.5),
	(566, 0.5),
	(567, 0.5),
	(568, 0.5),
	(569, 0.5),
	(570, 0.5),
	(571, 0.5),
	(572, 0.5),
	(573, 0.5),
	(574, 0.5),
	(575, 0.5),
	(576, 0.5),
	(577, 0.5),
	(578, 0.5),
	(579, 0.5),
	(580, 0.5),
	(581, 0.5),
	(582, 0.5),
	(583, 0.5),
	(584, 0.5),
	(585, 0.5),
	(586, 0.5),
	(587, 0.5),
	(588, 0.5),
	(589, 0.5),
	(590, 0.5),
	(591, 0.5),
	(592, 0.5),
	(593, 0.5),
	(594, 0.5),
	(595, 0.5),
	(596, 0.5),
	(597, 0.5),
	(598, 0.5),
	(599, 0.5),
	(600, 0.214286),
	(601, 0.198113),
	(602, 0.183161),
	(603, 0.169337),
	(604, 0.156557),
	(605, 0.144741),
	(606, 0.133817),
	(607, 0.123718),
	(608, 0.114381),
	(609, 0.105748),
	(610, 0.097767),
	(611, 0.090388),
	(612, 0.083566),
	(613, 0.07726),
	(614, 0.071429),
	(615, 0.071429),
	(616, 0.071429),
	(617, 0.071429),
	(618, 0.071429),
	(619, 0.071429),
	(620, 0.071429),
	(621, 0.071429),
	(622, 0.071429),
	(623, 0.071429),
	(624, 0.071429),
	(625, 0.071429),
	(626, 0.071429),
	(627, 0.071429),
	(628, 0.071429),
	(629, 0.071429),
	(630, 0.071429),
	(631, 0.071429),
	(632, 0.071429),
	(633, 0.071429),
	(634, 0.071429),
	(635, 0.071429),
	(636, 0.071429),
	(637, 0.071429),
	(638, 0.071429),
	(639, 0.071429),
	(640, 0.071429),
	(641, 0.071429),
	(642, 0.071429),
	(643, 0.071429),
	(644, 0.071429),
	(645, 0.071429),
	(646, 0.071429),
	(647, 0.071429),
	(648, 0.071429),
	(649, 0.071429),
	(650, 0.071429),
	(651, 0.071429),
	(652, 0.071429),
	(653, 0.071429),
	(654, 0.071429),
	(655, 0.071429),
	(656, 0.071429),
	(657, 0.071429),
	(658, 0.071429),
	(659, 0.071429),
	(660, 0.071429),
	(661, 0.071429),
	(662, 0.071429),
	(663, 0.071429),
	(664, 0.071429),
	(665, 0.071429),
	(666, 0.071429),
	(667, 0.071429),
	(668, 0.071429),
	(669, 0.071429),
	(670, 0.071429),
	(671, 0.071429),
	(672, 0.071429),
	(673, 0.071429),
	(674, 0.071429),
	(675, 0.071429),
	(676, 0.071429),
	(677, 0.071429),
	(678, 0.071429),
	(679, 0.071429),
	(680, 0.071429),
	(681, 0.071429),
	(682, 0.071429),
	(683, 0.071429),
	(684, 0.071429),
	(685, 0.071429),
	(686, 0.071429),
	(687, 0.071429),
	(688, 0.071429),
	(689, 0.071429),
	(690, 0.071429),
	(691, 0.071429),
	(692, 0.071429),
	(693, 0.071429),
	(694, 0.071429),
	(695, 0.071429),
	(696, 0.071429),
	(697, 0.071429),
	(698, 0.071429),
	(699, 0.071429),
	(700, 0.125),
	(701, 0.115566),
	(702, 0.106844),
	(703, 0.09878),
	(704, 0.091325),
	(705, 0.084432),
	(706, 0.07806),
	(707, 0.072169),
	(708, 0.066722),
	(709, 0.061686),
	(710, 0.057031),
	(711, 0.052727),
	(712, 0.048747),
	(713, 0.045068),
	(714, 0.041667),
	(715, 0.041667),
	(716, 0.041667),
	(717, 0.041667),
	(718, 0.041667),
	(719, 0.041667),
	(720, 0.041667),
	(721, 0.041667),
	(722, 0.041667),
	(723, 0.041667),
	(724, 0.041667),
	(725, 0.041667),
	(726, 0.041667),
	(727, 0.041667),
	(728, 0.041667),
	(729, 0.041667),
	(730, 0.041667),
	(731, 0.041667),
	(732, 0.041667),
	(733, 0.041667),
	(734, 0.041667),
	(735, 0.041667),
	(736, 0.041667),
	(737, 0.041667),
	(738, 0.041667),
	(739, 0.041667),
	(740, 0.041667),
	(741, 0.041667),
	(742, 0.041667),
	(743, 0.041667),
	(744, 0.041667),
	(745, 0.041667),
	(746, 0.041667),
	(747, 0.041667),
	(748, 0.041667),
	(749, 0.041667),
	(750, 0.041667),
	(751, 0.041667),
	(752, 0.041667),
	(753, 0.041667),
	(754, 0.041667),
	(755, 0.041667),
	(756, 0.041667),
	(757, 0.041667),
	(758, 0.041667),
	(759, 0.041667),
	(760, 0.041667),
	(761, 0.041667),
	(762, 0.041667),
	(763, 0.041667),
	(764, 0.041667),
	(765, 0.041667),
	(766, 0.041667),
	(767, 0.041667),
	(768, 0.041667),
	(769, 0.041667),
	(770, 0.041667),
	(771, 0.041667),
	(772, 0.041667),
	(773, 0.041667),
	(774, 0.041667),
	(775, 0.041667),
	(776, 0.041667),
	(777, 0.041667),
	(778, 0.041667),
	(779, 0.041667),
	(780, 0.041667),
	(781, 0.041667),
	(782, 0.041667),
	(783, 0.041667),
	(784, 0.041667),
	(785, 0.041667),
	(786, 0.041667),
	(787, 0.041667),
	(788, 0.041667),
	(789, 0.041667),
	(790, 0.041667),
	(791, 0.041667),
	(792, 0.041667),
	(793, 0.041667),
	(794, 0.041667),
	(795, 0.041667),
	(796, 0.041667),
	(797, 0.041667),
	(798, 0.041667),
	(799, 0.041667),
	(800, 0.136364),
	(801, 0.126072),
	(802, 0.116557),
	(803, 0.10776),
	(804, 0.099627),
	(805, 0.092108),
	(806, 0.085157),
	(807, 0.07873),
	(808, 0.072788),
	(809, 0.067294),
	(810, 0.062215),
	(811, 0.05752),
	(812, 0.053179),
	(813, 0.049165),
	(814, 0.045455),
	(815, 0.045455),
	(816, 0.045455),
	(817, 0.045455),
	(818, 0.045455),
	(819, 0.045455),
	(820, 0.045455),
	(821, 0.045455),
	(822, 0.045455),
	(823, 0.045455),
	(824, 0.045455),
	(825, 0.045455),
	(826, 0.045455),
	(827, 0.045455),
	(828, 0.045455),
	(829, 0.045455),
	(830, 0.045455),
	(831, 0.045455),
	(832, 0.045455),
	(833, 0.045455),
	(834, 0.045455),
	(835, 0.045455),
	(836, 0.045455),
	(837, 0.045455),
	(838, 0.045455),
	(839, 0.045455),
	(840, 0.045455),
	(841, 0.045455),
	(842, 0.045455),
	(843, 0.045455),
	(844, 0.045455),
	(845, 0.045455),
	(846, 0.045455),
	(847, 0.045455),
	(848, 0.045455),
	(849, 0.045455),
	(850, 0.045455),
	(851, 0.045455),
	(852, 0.045455),
	(853, 0.045455),
	(854, 0.045455),
	(855, 0.045455),
	(856, 0.045455),
	(857, 0.045455),
	(858, 0.045455),
	(859, 0.045455),
	(860, 0.045455),
	(861, 0.045455),
	(862, 0.045455),
	(863, 0.045455),
	(864, 0.045455),
	(865, 0.045455),
	(866, 0.045455),
	(867, 0.045455),
	(868, 0.045455),
	(869, 0.045455),
	(870, 0.045455),
	(871, 0.045455),
	(872, 0.045455),
	(873, 0.045455),
	(874, 0.045455),
	(875, 0.045455),
	(876, 0.045455),
	(877, 0.045455),
	(878, 0.045455),
	(879, 0.045455),
	(880, 0.045455),
	(881, 0.045455),
	(882, 0.045455),
	(883, 0.045455),
	(884, 0.045455),
	(885, 0.045455),
	(886, 0.045455),
	(887, 0.045455),
	(888, 0.045455),
	(889, 0.045455),
	(890, 0.045455),
	(891, 0.045455),
	(892, 0.045455),
	(893, 0.045455),
	(894, 0.045455),
	(895, 0.045455),
	(896, 0.045455),
	(897, 0.045455),
	(898, 0.045455),
	(899, 0.045455),
	(900, 0),
	(901, 0),
	(902, 0),
	(903, 0),
	(904, 0),
	(905, 0),
	(906, 0),
	(907, 0),
	(908, 0),
	(909, 0),
	(910, 0),
	(911, 0),
	(912, 0),
	(913, 0),
	(914, 0),
	(915, 0),
	(916, 0),
	(917, 0),
	(918, 0),
	(919, 0),
	(920, 0),
	(921, 0),
	(922, 0),
	(923, 0),
	(924, 0),
	(925, 0),
	(926, 0),
	(927, 0),
	(928, 0),
	(929, 0),
	(930, 0),
	(931, 0),
	(932, 0),
	(933, 0),
	(934, 0),
	(935, 0),
	(936, 0),
	(937, 0),
	(938, 0),
	(939, 0),
	(940, 0),
	(941, 0),
	(942, 0),
	(943, 0),
	(944, 0),
	(945, 0),
	(946, 0),
	(947, 0),
	(948, 0),
	(949, 0),
	(950, 0),
	(951, 0),
	(952, 0),
	(953, 0),
	(954, 0),
	(955, 0),
	(956, 0),
	(957, 0),
	(958, 0),
	(959, 0),
	(960, 0),
	(961, 0),
	(962, 0),
	(963, 0),
	(964, 0),
	(965, 0),
	(966, 0),
	(967, 0),
	(968, 0),
	(969, 0),
	(970, 0),
	(971, 0),
	(972, 0),
	(973, 0),
	(974, 0),
	(975, 0),
	(976, 0),
	(977, 0),
	(978, 0),
	(979, 0),
	(980, 0),
	(981, 0),
	(982, 0),
	(983, 0),
	(984, 0),
	(985, 0),
	(986, 0),
	(987, 0),
	(988, 0),
	(989, 0),
	(990, 0),
	(991, 0),
	(992, 0),
	(993, 0),
	(994, 0),
	(995, 0),
	(996, 0),
	(997, 0),
	(998, 0),
	(999, 0),
	(1000, 0.1875),
	(1001, 0.173349),
	(1002, 0.160266),
	(1003, 0.14817),
	(1004, 0.136987),
	(1005, 0.126649),
	(1006, 0.11709),
	(1007, 0.108253),
	(1008, 0.100083),
	(1009, 0.09253),
	(1010, 0.085546),
	(1011, 0.07909),
	(1012, 0.073121),
	(1013, 0.067602),
	(1014, 0.0625),
	(1015, 0.0625),
	(1016, 0.0625),
	(1017, 0.0625),
	(1018, 0.0625),
	(1019, 0.0625),
	(1020, 0.0625),
	(1021, 0.0625),
	(1022, 0.0625),
	(1023, 0.0625),
	(1024, 0.0625),
	(1025, 0.0625),
	(1026, 0.0625),
	(1027, 0.0625),
	(1028, 0.0625),
	(1029, 0.0625),
	(1030, 0.0625),
	(1031, 0.0625),
	(1032, 0.0625),
	(1033, 0.0625),
	(1034, 0.0625),
	(1035, 0.0625),
	(1036, 0.0625),
	(1037, 0.0625),
	(1038, 0.0625),
	(1039, 0.0625),
	(1040, 0.0625),
	(1041, 0.0625),
	(1042, 0.0625),
	(1043, 0.0625),
	(1044, 0.0625),
	(1045, 0.0625),
	(1046, 0.0625),
	(1047, 0.0625),
	(1048, 0.0625),
	(1049, 0.0625),
	(1050, 0.0625),
	(1051, 0.0625),
	(1052, 0.0625),
	(1053, 0.0625),
	(1054, 0.0625),
	(1055, 0.0625),
	(1056, 0.0625),
	(1057, 0.0625),
	(1058, 0.0625),
	(1059, 0.0625),
	(1060, 0.0625),
	(1061, 0.0625),
	(1062, 0.0625),
	(1063, 0.0625),
	(1064, 0.0625),
	(1065, 0.0625),
	(1066, 0.0625),
	(1067, 0.0625),
	(1068, 0.0625),
	(1069, 0.0625),
	(1070, 0.0625),
	(1071, 0.0625),
	(1072, 0.0625),
	(1073, 0.0625),
	(1074, 0.0625),
	(1075, 0.0625),
	(1076, 0.0625),
	(1077, 0.0625),
	(1078, 0.0625),
	(1079, 0.0625),
	(1080, 0.0625),
	(1081, 0.0625),
	(1082, 0.0625),
	(1083, 0.0625),
	(1084, 0.0625),
	(1085, 0.0625),
	(1086, 0.0625),
	(1087, 0.0625),
	(1088, 0.0625),
	(1089, 0.0625),
	(1090, 0.0625),
	(1091, 0.0625),
	(1092, 0.0625),
	(1093, 0.0625),
	(1094, 0.0625),
	(1095, 0.0625),
	(1096, 0.0625),
	(1097, 0.0625),
	(1098, 0.0625),
	(1099, 0.0625);
/*!40000 ALTER TABLE `gtregenhpperspt_dbc` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
