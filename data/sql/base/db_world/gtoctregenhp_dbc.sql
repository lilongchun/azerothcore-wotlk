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

-- Dumping structure for table acore_world.gtoctregenhp_dbc
DROP TABLE IF EXISTS `gtoctregenhp_dbc`;
CREATE TABLE IF NOT EXISTS `gtoctregenhp_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=FIXED;

-- Dumping data for table acore_world.gtoctregenhp_dbc: 1,100 rows
DELETE FROM `gtoctregenhp_dbc`;
/*!40000 ALTER TABLE `gtoctregenhp_dbc` DISABLE KEYS */;
INSERT INTO `gtoctregenhp_dbc` (`ID`, `Data`) VALUES
	(0, 0.394737),
	(1, 0.462264),
	(2, 0.474862),
	(3, 0.515375),
	(4, 0.521857),
	(5, 0.533258),
	(6, 0.520401),
	(7, 0.509427),
	(8, 0.500415),
	(9, 0.462648),
	(10, 0.488835),
	(11, 0.486706),
	(12, 0.449973),
	(13, 0.450681),
	(14, 0.454545),
	(15, 0.454545),
	(16, 0.454545),
	(17, 0.5),
	(18, 0.5),
	(19, 0.5),
	(20, 0.5),
	(21, 0.5),
	(22, 0.555556),
	(23, 0.555556),
	(24, 0.555556),
	(25, 0.555556),
	(26, 0.555556),
	(27, 0.555556),
	(28, 0.555556),
	(29, 0.555556),
	(30, 0.555556),
	(31, 0.555556),
	(32, 0.555556),
	(33, 0.555556),
	(34, 0.555556),
	(35, 0.555556),
	(36, 0.555556),
	(37, 0.555556),
	(38, 0.555556),
	(39, 0.555556),
	(40, 0.555556),
	(41, 0.555556),
	(42, 0.555556),
	(43, 0.555556),
	(44, 0.555556),
	(45, 0.625),
	(46, 0.625),
	(47, 0.625),
	(48, 0.625),
	(49, 0.625),
	(50, 0.625),
	(51, 0.625),
	(52, 0.625),
	(53, 0.625),
	(54, 0.625),
	(55, 0.625),
	(56, 0.625),
	(57, 0.625),
	(58, 0.625),
	(59, 0.625),
	(60, 0.625),
	(61, 0.625),
	(62, 0.625),
	(63, 0.625),
	(64, 0.625),
	(65, 0.625),
	(66, 0.625),
	(67, 0.625),
	(68, 0.625),
	(69, 0.625),
	(70, 0.625),
	(71, 0.625),
	(72, 0.625),
	(73, 0.625),
	(74, 0.625),
	(75, 0.625),
	(76, 0.625),
	(77, 0.625),
	(78, 0.625),
	(79, 0.625),
	(80, 0.625),
	(81, 0.625),
	(82, 0.625),
	(83, 0.625),
	(84, 0.625),
	(85, 0.625),
	(86, 0.625),
	(87, 0.625),
	(88, 0.625),
	(89, 0.625),
	(90, 0.625),
	(91, 0.625),
	(92, 0.625),
	(93, 0.625),
	(94, 0.625),
	(95, 0.625),
	(96, 0.625),
	(97, 0.625),
	(98, 0.625),
	(99, 0.625),
	(100, 0.277778),
	(101, 0.301476),
	(102, 0.328751),
	(103, 0.320368),
	(104, 0.313114),
	(105, 0.316622),
	(106, 0.302168),
	(107, 0.298629),
	(108, 0.276091),
	(109, 0.255254),
	(110, 0.25347),
	(111, 0.243353),
	(112, 0.243736),
	(113, 0.22534),
	(114, 0.208333),
	(115, 0.208333),
	(116, 0.208333),
	(117, 0.217391),
	(118, 0.217391),
	(119, 0.217391),
	(120, 0.217391),
	(121, 0.217391),
	(122, 0.217391),
	(123, 0.227273),
	(124, 0.227273),
	(125, 0.227273),
	(126, 0.227273),
	(127, 0.238095),
	(128, 0.238095),
	(129, 0.238095),
	(130, 0.238095),
	(131, 0.238095),
	(132, 0.25),
	(133, 0.25),
	(134, 0.25),
	(135, 0.25),
	(136, 0.25),
	(137, 0.25),
	(138, 0.25),
	(139, 0.25),
	(140, 0.25),
	(141, 0.263158),
	(142, 0.263158),
	(143, 0.263158),
	(144, 0.263158),
	(145, 0.263158),
	(146, 0.263158),
	(147, 0.263158),
	(148, 0.263158),
	(149, 0.263158),
	(150, 0.263158),
	(151, 0.263158),
	(152, 0.263158),
	(153, 0.263158),
	(154, 0.263158),
	(155, 0.263158),
	(156, 0.263158),
	(157, 0.263158),
	(158, 0.263158),
	(159, 0.263158),
	(160, 0.263158),
	(161, 0.263158),
	(162, 0.263158),
	(163, 0.263158),
	(164, 0.263158),
	(165, 0.263158),
	(166, 0.263158),
	(167, 0.263158),
	(168, 0.263158),
	(169, 0.263158),
	(170, 0.263158),
	(171, 0.263158),
	(172, 0.263158),
	(173, 0.263158),
	(174, 0.263158),
	(175, 0.263158),
	(176, 0.263158),
	(177, 0.263158),
	(178, 0.263158),
	(179, 0.263158),
	(180, 0.263158),
	(181, 0.263158),
	(182, 0.263158),
	(183, 0.263158),
	(184, 0.263158),
	(185, 0.263158),
	(186, 0.263158),
	(187, 0.263158),
	(188, 0.263158),
	(189, 0.263158),
	(190, 0.263158),
	(191, 0.263158),
	(192, 0.263158),
	(193, 0.263158),
	(194, 0.263158),
	(195, 0.263158),
	(196, 0.263158),
	(197, 0.263158),
	(198, 0.263158),
	(199, 0.263158),
	(200, 0.267857),
	(201, 0.288915),
	(202, 0.312714),
	(203, 0.311937),
	(204, 0.313114),
	(205, 0.297997),
	(206, 0.302168),
	(207, 0.279363),
	(208, 0.266888),
	(209, 0.255254),
	(210, 0.235989),
	(211, 0.218179),
	(212, 0.208916),
	(213, 0.193149),
	(214, 0.178571),
	(215, 0.178571),
	(216, 0.178571),
	(217, 0.178571),
	(218, 0.178571),
	(219, 0.178571),
	(220, 0.178571),
	(221, 0.178571),
	(222, 0.178571),
	(223, 0.178571),
	(224, 0.178571),
	(225, 0.185185),
	(226, 0.185185),
	(227, 0.185185),
	(228, 0.185185),
	(229, 0.185185),
	(230, 0.192308),
	(231, 0.192308),
	(232, 0.192308),
	(233, 0.192308),
	(234, 0.192308),
	(235, 0.192308),
	(236, 0.192308),
	(237, 0.192308),
	(238, 0.192308),
	(239, 0.192308),
	(240, 0.192308),
	(241, 0.192308),
	(242, 0.2),
	(243, 0.2),
	(244, 0.2),
	(245, 0.2),
	(246, 0.2),
	(247, 0.2),
	(248, 0.2),
	(249, 0.2),
	(250, 0.2),
	(251, 0.2),
	(252, 0.2),
	(253, 0.2),
	(254, 0.2),
	(255, 0.2),
	(256, 0.2),
	(257, 0.2),
	(258, 0.2),
	(259, 0.2),
	(260, 0.2),
	(261, 0.2),
	(262, 0.2),
	(263, 0.2),
	(264, 0.2),
	(265, 0.2),
	(266, 0.2),
	(267, 0.2),
	(268, 0.2),
	(269, 0.2),
	(270, 0.2),
	(271, 0.2),
	(272, 0.2),
	(273, 0.2),
	(274, 0.2),
	(275, 0.2),
	(276, 0.2),
	(277, 0.2),
	(278, 0.2),
	(279, 0.2),
	(280, 0.2),
	(281, 0.2),
	(282, 0.2),
	(283, 0.2),
	(284, 0.2),
	(285, 0.2),
	(286, 0.2),
	(287, 0.2),
	(288, 0.2),
	(289, 0.2),
	(290, 0.2),
	(291, 0.2),
	(292, 0.2),
	(293, 0.2),
	(294, 0.2),
	(295, 0.2),
	(296, 0.2),
	(297, 0.2),
	(298, 0.2),
	(299, 0.2),
	(300, 0.365854),
	(301, 0.42024),
	(302, 0.442113),
	(303, 0.455908),
	(304, 0.476478),
	(305, 0.460541),
	(306, 0.468361),
	(307, 0.455803),
	(308, 0.421402),
	(309, 0.411242),
	(310, 0.40257),
	(311, 0.372187),
	(312, 0.365603),
	(313, 0.33801),
	(314, 0.3125),
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
	(341, 0.357143),
	(342, 0.357143),
	(343, 0.357143),
	(344, 0.357143),
	(345, 0.357143),
	(346, 0.357143),
	(347, 0.357143),
	(348, 0.357143),
	(349, 0.357143),
	(350, 0.357143),
	(351, 0.357143),
	(352, 0.357143),
	(353, 0.357143),
	(354, 0.357143),
	(355, 0.357143),
	(356, 0.357143),
	(357, 0.357143),
	(358, 0.357143),
	(359, 0.357143),
	(360, 0.357143),
	(361, 0.357143),
	(362, 0.357143),
	(363, 0.357143),
	(364, 0.357143),
	(365, 0.357143),
	(366, 0.357143),
	(367, 0.357143),
	(368, 0.357143),
	(369, 0.357143),
	(370, 0.357143),
	(371, 0.357143),
	(372, 0.357143),
	(373, 0.357143),
	(374, 0.357143),
	(375, 0.357143),
	(376, 0.357143),
	(377, 0.357143),
	(378, 0.357143),
	(379, 0.357143),
	(380, 0.357143),
	(381, 0.357143),
	(382, 0.357143),
	(383, 0.357143),
	(384, 0.357143),
	(385, 0.357143),
	(386, 0.357143),
	(387, 0.357143),
	(388, 0.357143),
	(389, 0.357143),
	(390, 0.357143),
	(391, 0.357143),
	(392, 0.357143),
	(393, 0.357143),
	(394, 0.357143),
	(395, 0.357143),
	(396, 0.357143),
	(397, 0.357143),
	(398, 0.357143),
	(399, 0.357143),
	(400, 0.357143),
	(401, 0.355588),
	(402, 0.337402),
	(403, 0.311937),
	(404, 0.288395),
	(405, 0.266629),
	(406, 0.246506),
	(407, 0.227901),
	(408, 0.210701),
	(409, 0.194799),
	(410, 0.180097),
	(411, 0.166505),
	(412, 0.153938),
	(413, 0.14232),
	(414, 0.131579),
	(415, 0.131579),
	(416, 0.131579),
	(417, 0.131579),
	(418, 0.131579),
	(419, 0.131579),
	(420, 0.131579),
	(421, 0.131579),
	(422, 0.131579),
	(423, 0.142857),
	(424, 0.142857),
	(425, 0.142857),
	(426, 0.142857),
	(427, 0.142857),
	(428, 0.142857),
	(429, 0.142857),
	(430, 0.142857),
	(431, 0.142857),
	(432, 0.142857),
	(433, 0.142857),
	(434, 0.142857),
	(435, 0.166667),
	(436, 0.166667),
	(437, 0.166667),
	(438, 0.166667),
	(439, 0.166667),
	(440, 0.166667),
	(441, 0.166667),
	(442, 0.166667),
	(443, 0.166667),
	(444, 0.166667),
	(445, 0.166667),
	(446, 0.172414),
	(447, 0.178571),
	(448, 0.178571),
	(449, 0.178571),
	(450, 0.178571),
	(451, 0.178571),
	(452, 0.178571),
	(453, 0.178571),
	(454, 0.178571),
	(455, 0.178571),
	(456, 0.178571),
	(457, 0.178571),
	(458, 0.178571),
	(459, 0.192308),
	(460, 0.192308),
	(461, 0.192308),
	(462, 0.192308),
	(463, 0.192308),
	(464, 0.192308),
	(465, 0.192308),
	(466, 0.192308),
	(467, 0.192308),
	(468, 0.192308),
	(469, 0.192308),
	(470, 0.192308),
	(471, 0.192308),
	(472, 0.192308),
	(473, 0.192308),
	(474, 0.192308),
	(475, 0.192308),
	(476, 0.192308),
	(477, 0.192308),
	(478, 0.192308),
	(479, 0.192308),
	(480, 0.192308),
	(481, 0.192308),
	(482, 0.192308),
	(483, 0.192308),
	(484, 0.192308),
	(485, 0.192308),
	(486, 0.192308),
	(487, 0.192308),
	(488, 0.192308),
	(489, 0.192308),
	(490, 0.192308),
	(491, 0.192308),
	(492, 0.192308),
	(493, 0.192308),
	(494, 0.192308),
	(495, 0.192308),
	(496, 0.192308),
	(497, 0.192308),
	(498, 0.192308),
	(499, 0.192308),
	(500, 0.394737),
	(501, 0.462264),
	(502, 0.474862),
	(503, 0.515375),
	(504, 0.521857),
	(505, 0.533258),
	(506, 0.520401),
	(507, 0.509427),
	(508, 0.500415),
	(509, 0.462648),
	(510, 0.488835),
	(511, 0.486706),
	(512, 0.449973),
	(513, 0.450681),
	(514, 0.454545),
	(515, 0.454545),
	(516, 0.454545),
	(517, 0.5),
	(518, 0.5),
	(519, 0.5),
	(520, 0.5),
	(521, 0.5),
	(522, 0.555556),
	(523, 0.555556),
	(524, 0.555556),
	(525, 0.555556),
	(526, 0.555556),
	(527, 0.555556),
	(528, 0.555556),
	(529, 0.555556),
	(530, 0.555556),
	(531, 0.555556),
	(532, 0.555556),
	(533, 0.555556),
	(534, 0.555556),
	(535, 0.555556),
	(536, 0.555556),
	(537, 0.555556),
	(538, 0.555556),
	(539, 0.555556),
	(540, 0.555556),
	(541, 0.555556),
	(542, 0.555556),
	(543, 0.555556),
	(544, 0.555556),
	(545, 0.625),
	(546, 0.625),
	(547, 0.625),
	(548, 0.625),
	(549, 0.625),
	(550, 0.625),
	(551, 0.625),
	(552, 0.625),
	(553, 0.625),
	(554, 0.625),
	(555, 0.625),
	(556, 0.625),
	(557, 0.625),
	(558, 0.625),
	(559, 0.625),
	(560, 0.625),
	(561, 0.625),
	(562, 0.625),
	(563, 0.625),
	(564, 0.625),
	(565, 0.625),
	(566, 0.625),
	(567, 0.625),
	(568, 0.625),
	(569, 0.625),
	(570, 0.625),
	(571, 0.625),
	(572, 0.625),
	(573, 0.625),
	(574, 0.625),
	(575, 0.625),
	(576, 0.625),
	(577, 0.625),
	(578, 0.625),
	(579, 0.625),
	(580, 0.625),
	(581, 0.625),
	(582, 0.625),
	(583, 0.625),
	(584, 0.625),
	(585, 0.625),
	(586, 0.625),
	(587, 0.625),
	(588, 0.625),
	(589, 0.625),
	(590, 0.625),
	(591, 0.625),
	(592, 0.625),
	(593, 0.625),
	(594, 0.625),
	(595, 0.625),
	(596, 0.625),
	(597, 0.625),
	(598, 0.625),
	(599, 0.625),
	(600, 0.258621),
	(601, 0.277358),
	(602, 0.284917),
	(603, 0.289113),
	(604, 0.281),
	(605, 0.273835),
	(606, 0.260201),
	(607, 0.240563),
	(608, 0.222407),
	(609, 0.205621),
	(610, 0.190103),
	(611, 0.175755),
	(612, 0.16249),
	(613, 0.150227),
	(614, 0.138889),
	(615, 0.138889),
	(616, 0.142857),
	(617, 0.147059),
	(618, 0.151515),
	(619, 0.151515),
	(620, 0.151515),
	(621, 0.15625),
	(622, 0.15625),
	(623, 0.15625),
	(624, 0.15625),
	(625, 0.15625),
	(626, 0.16129),
	(627, 0.16129),
	(628, 0.16129),
	(629, 0.166667),
	(630, 0.166667),
	(631, 0.166667),
	(632, 0.166667),
	(633, 0.166667),
	(634, 0.166667),
	(635, 0.166667),
	(636, 0.172414),
	(637, 0.172414),
	(638, 0.172414),
	(639, 0.172414),
	(640, 0.172414),
	(641, 0.172414),
	(642, 0.172414),
	(643, 0.172414),
	(644, 0.172414),
	(645, 0.172414),
	(646, 0.172414),
	(647, 0.172414),
	(648, 0.172414),
	(649, 0.172414),
	(650, 0.172414),
	(651, 0.172414),
	(652, 0.172414),
	(653, 0.172414),
	(654, 0.172414),
	(655, 0.172414),
	(656, 0.172414),
	(657, 0.172414),
	(658, 0.172414),
	(659, 0.172414),
	(660, 0.172414),
	(661, 0.172414),
	(662, 0.172414),
	(663, 0.172414),
	(664, 0.172414),
	(665, 0.172414),
	(666, 0.172414),
	(667, 0.172414),
	(668, 0.172414),
	(669, 0.172414),
	(670, 0.172414),
	(671, 0.172414),
	(672, 0.172414),
	(673, 0.172414),
	(674, 0.172414),
	(675, 0.172414),
	(676, 0.172414),
	(677, 0.172414),
	(678, 0.172414),
	(679, 0.172414),
	(680, 0.172414),
	(681, 0.172414),
	(682, 0.172414),
	(683, 0.172414),
	(684, 0.172414),
	(685, 0.172414),
	(686, 0.172414),
	(687, 0.172414),
	(688, 0.172414),
	(689, 0.172414),
	(690, 0.172414),
	(691, 0.172414),
	(692, 0.172414),
	(693, 0.172414),
	(694, 0.172414),
	(695, 0.172414),
	(696, 0.172414),
	(697, 0.172414),
	(698, 0.172414),
	(699, 0.172414),
	(700, 0.238095),
	(701, 0.252144),
	(702, 0.261659),
	(703, 0.241911),
	(704, 0.223653),
	(705, 0.206773),
	(706, 0.191168),
	(707, 0.17674),
	(708, 0.163401),
	(709, 0.151069),
	(710, 0.139667),
	(711, 0.129126),
	(712, 0.119381),
	(713, 0.110371),
	(714, 0.102041),
	(715, 0.102041),
	(716, 0.102041),
	(717, 0.102041),
	(718, 0.102041),
	(719, 0.102041),
	(720, 0.102041),
	(721, 0.102041),
	(722, 0.102041),
	(723, 0.102041),
	(724, 0.102041),
	(725, 0.102041),
	(726, 0.102041),
	(727, 0.102041),
	(728, 0.102041),
	(729, 0.102041),
	(730, 0.102041),
	(731, 0.102041),
	(732, 0.102041),
	(733, 0.102041),
	(734, 0.104167),
	(735, 0.104167),
	(736, 0.104167),
	(737, 0.104167),
	(738, 0.106383),
	(739, 0.106383),
	(740, 0.106383),
	(741, 0.108696),
	(742, 0.108696),
	(743, 0.108696),
	(744, 0.108696),
	(745, 0.108696),
	(746, 0.111111),
	(747, 0.111111),
	(748, 0.111111),
	(749, 0.113636),
	(750, 0.113636),
	(751, 0.113636),
	(752, 0.116279),
	(753, 0.116279),
	(754, 0.116279),
	(755, 0.116279),
	(756, 0.119048),
	(757, 0.119048),
	(758, 0.119048),
	(759, 0.119048),
	(760, 0.121951),
	(761, 0.121951),
	(762, 0.121951),
	(763, 0.121951),
	(764, 0.121951),
	(765, 0.121951),
	(766, 0.121951),
	(767, 0.121951),
	(768, 0.121951),
	(769, 0.121951),
	(770, 0.121951),
	(771, 0.121951),
	(772, 0.121951),
	(773, 0.121951),
	(774, 0.121951),
	(775, 0.121951),
	(776, 0.121951),
	(777, 0.121951),
	(778, 0.121951),
	(779, 0.121951),
	(780, 0.121951),
	(781, 0.121951),
	(782, 0.121951),
	(783, 0.121951),
	(784, 0.121951),
	(785, 0.121951),
	(786, 0.121951),
	(787, 0.121951),
	(788, 0.121951),
	(789, 0.121951),
	(790, 0.121951),
	(791, 0.121951),
	(792, 0.121951),
	(793, 0.121951),
	(794, 0.121951),
	(795, 0.121951),
	(796, 0.121951),
	(797, 0.121951),
	(798, 0.121951),
	(799, 0.121951),
	(800, 0.241935),
	(801, 0.256813),
	(802, 0.261659),
	(803, 0.263414),
	(804, 0.249068),
	(805, 0.23027),
	(806, 0.212891),
	(807, 0.196824),
	(808, 0.181969),
	(809, 0.168236),
	(810, 0.155538),
	(811, 0.1438),
	(812, 0.132947),
	(813, 0.122913),
	(814, 0.113636),
	(815, 0.113636),
	(816, 0.113636),
	(817, 0.113636),
	(818, 0.113636),
	(819, 0.113636),
	(820, 0.113636),
	(821, 0.113636),
	(822, 0.113636),
	(823, 0.113636),
	(824, 0.113636),
	(825, 0.113636),
	(826, 0.113636),
	(827, 0.113636),
	(828, 0.113636),
	(829, 0.113636),
	(830, 0.113636),
	(831, 0.116279),
	(832, 0.116279),
	(833, 0.116279),
	(834, 0.116279),
	(835, 0.116279),
	(836, 0.116279),
	(837, 0.116279),
	(838, 0.116279),
	(839, 0.119048),
	(840, 0.119048),
	(841, 0.119048),
	(842, 0.119048),
	(843, 0.119048),
	(844, 0.119048),
	(845, 0.121951),
	(846, 0.121951),
	(847, 0.121951),
	(848, 0.121951),
	(849, 0.121951),
	(850, 0.125),
	(851, 0.125),
	(852, 0.125),
	(853, 0.125),
	(854, 0.125),
	(855, 0.125),
	(856, 0.125),
	(857, 0.128205),
	(858, 0.128205),
	(859, 0.128205),
	(860, 0.128205),
	(861, 0.128205),
	(862, 0.128205),
	(863, 0.128205),
	(864, 0.128205),
	(865, 0.128205),
	(866, 0.128205),
	(867, 0.128205),
	(868, 0.128205),
	(869, 0.128205),
	(870, 0.128205),
	(871, 0.128205),
	(872, 0.128205),
	(873, 0.128205),
	(874, 0.128205),
	(875, 0.128205),
	(876, 0.128205),
	(877, 0.128205),
	(878, 0.128205),
	(879, 0.128205),
	(880, 0.128205),
	(881, 0.128205),
	(882, 0.128205),
	(883, 0.128205),
	(884, 0.128205),
	(885, 0.128205),
	(886, 0.128205),
	(887, 0.128205),
	(888, 0.128205),
	(889, 0.128205),
	(890, 0.128205),
	(891, 0.128205),
	(892, 0.128205),
	(893, 0.128205),
	(894, 0.128205),
	(895, 0.128205),
	(896, 0.128205),
	(897, 0.128205),
	(898, 0.128205),
	(899, 0.128205),
	(900, 1),
	(901, 1),
	(902, 1),
	(903, 1),
	(904, 1),
	(905, 1),
	(906, 1),
	(907, 1),
	(908, 1),
	(909, 1),
	(910, 1),
	(911, 1),
	(912, 1),
	(913, 1),
	(914, 1),
	(915, 1),
	(916, 1),
	(917, 1),
	(918, 1),
	(919, 1),
	(920, 1),
	(921, 1),
	(922, 1),
	(923, 1),
	(924, 1),
	(925, 1),
	(926, 1),
	(927, 1),
	(928, 1),
	(929, 1),
	(930, 1),
	(931, 1),
	(932, 1),
	(933, 1),
	(934, 1),
	(935, 1),
	(936, 1),
	(937, 1),
	(938, 1),
	(939, 1),
	(940, 1),
	(941, 1),
	(942, 1),
	(943, 1),
	(944, 1),
	(945, 1),
	(946, 1),
	(947, 1),
	(948, 1),
	(949, 1),
	(950, 1),
	(951, 1),
	(952, 1),
	(953, 1),
	(954, 1),
	(955, 1),
	(956, 1),
	(957, 1),
	(958, 1),
	(959, 1),
	(960, 1),
	(961, 1),
	(962, 1),
	(963, 1),
	(964, 1),
	(965, 1),
	(966, 1),
	(967, 1),
	(968, 1),
	(969, 1),
	(970, 1),
	(971, 1),
	(972, 1),
	(973, 1),
	(974, 1),
	(975, 1),
	(976, 1),
	(977, 1),
	(978, 1),
	(979, 1),
	(980, 1),
	(981, 1),
	(982, 1),
	(983, 1),
	(984, 1),
	(985, 1),
	(986, 1),
	(987, 1),
	(988, 1),
	(989, 1),
	(990, 1),
	(991, 1),
	(992, 1),
	(993, 1),
	(994, 1),
	(995, 1),
	(996, 1),
	(997, 1),
	(998, 1),
	(999, 1),
	(1000, 0.245902),
	(1001, 0.266691),
	(1002, 0.278723),
	(1003, 0.282229),
	(1004, 0.273975),
	(1005, 0.266629),
	(1006, 0.246506),
	(1007, 0.227901),
	(1008, 0.210701),
	(1009, 0.194799),
	(1010, 0.180097),
	(1011, 0.166505),
	(1012, 0.153938),
	(1013, 0.14232),
	(1014, 0.131579),
	(1015, 0.131579),
	(1016, 0.131579),
	(1017, 0.131579),
	(1018, 0.131579),
	(1019, 0.131579),
	(1020, 0.131579),
	(1021, 0.135135),
	(1022, 0.135135),
	(1023, 0.135135),
	(1024, 0.135135),
	(1025, 0.135135),
	(1026, 0.135135),
	(1027, 0.135135),
	(1028, 0.135135),
	(1029, 0.135135),
	(1030, 0.138889),
	(1031, 0.138889),
	(1032, 0.138889),
	(1033, 0.138889),
	(1034, 0.138889),
	(1035, 0.138889),
	(1036, 0.138889),
	(1037, 0.138889),
	(1038, 0.138889),
	(1039, 0.138889),
	(1040, 0.138889),
	(1041, 0.138889),
	(1042, 0.138889),
	(1043, 0.138889),
	(1044, 0.138889),
	(1045, 0.138889),
	(1046, 0.138889),
	(1047, 0.138889),
	(1048, 0.138889),
	(1049, 0.138889),
	(1050, 0.138889),
	(1051, 0.138889),
	(1052, 0.138889),
	(1053, 0.138889),
	(1054, 0.138889),
	(1055, 0.138889),
	(1056, 0.138889),
	(1057, 0.138889),
	(1058, 0.138889),
	(1059, 0.138889),
	(1060, 0.138889),
	(1061, 0.138889),
	(1062, 0.138889),
	(1063, 0.138889),
	(1064, 0.138889),
	(1065, 0.138889),
	(1066, 0.138889),
	(1067, 0.138889),
	(1068, 0.138889),
	(1069, 0.138889),
	(1070, 0.138889),
	(1071, 0.138889),
	(1072, 0.138889),
	(1073, 0.138889),
	(1074, 0.138889),
	(1075, 0.138889),
	(1076, 0.138889),
	(1077, 0.138889),
	(1078, 0.138889),
	(1079, 0.138889),
	(1080, 0.138889),
	(1081, 0.138889),
	(1082, 0.138889),
	(1083, 0.138889),
	(1084, 0.138889),
	(1085, 0.138889),
	(1086, 0.138889),
	(1087, 0.138889),
	(1088, 0.138889),
	(1089, 0.138889),
	(1090, 0.138889),
	(1091, 0.138889),
	(1092, 0.138889),
	(1093, 0.138889),
	(1094, 0.138889),
	(1095, 0.138889),
	(1096, 0.138889),
	(1097, 0.138889),
	(1098, 0.138889),
	(1099, 0.138889);
/*!40000 ALTER TABLE `gtoctregenhp_dbc` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
