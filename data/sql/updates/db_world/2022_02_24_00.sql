-- DB update 2022_02_23_00 -> 2022_02_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_23_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_23_00 2022_02_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1644944413701037300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644944413701037300');

DELETE FROM `quest_template_locale` WHERE `locale` = 'zhTW' AND `id` IN (8249,8250,8251,8252,8253,8254,8255,8256,8257,8258,8259,8260,8261,8262,8263,8264,8265,8266,8267,8268,8269,8270,8271,8272,8273,8275,8276,8277,8278,8279,8280,8281,8282,8283,8284,8285,8286,8287,8288,8289,8290,8291,8292,8293,8294,8295,8296,8297,8298,8299,8300,8301,8302,8303,8304,8305,8306,8307,8308,8309,8310,8311,8312,8313,8314,8315,8316,8317,8318,8319,8320,8321,8322,8323,8324,8325,8326,8327,8328,8329,8330,8331,8332,8333,8334,8335,8336,8338,8339,8340,8341,8342,8343,8344,8345,8346,8347,8348,8349,8350,8351,8352,8353,8354,8355,8356,8357,8358,8359,8360,8361,8362,8363,8364,8365,8366,8367,8368,8369,8370,8371,8372,8373,8374,8375,8376,8377,8378,8379,8380,8381,8382,8383,8384,8385,8386,8387,8388,8389,8390,8391,8392,8393,8394,8395,8396,8397,8398,8399,8400,8401,8402,8403,8404,8405,8406,8407,8408,8409,8410,8411,8412,8413,8414,8415,8416,8417,8418,8419,8420,8421,8422,8423,8424,8425,8426,8427,8428,8429,8430,8431,8432,8433,8434,8435,8436,8437,8438,8439,8440,8441,8442,8443,8444,8445,8446,8447,8448,8449,8450,8451,8452,8453,8454,8460,8461,8462,8463,8464,8465,8466,8467,8468,8469,8470,8471,8472,8473,8474);
INSERT INTO `quest_template_locale` VALUES
(8249,"zhTW","垃圾箱","","","","去找奧特蘭克山脈的法拉德。","","","","",0),
(8250,"zhTW","法師的會見","最近經常有人打聽大法師克希雷姆……他們都跟你差不多。$B$B如果你想要找他的話，就去艾薩拉吧。克希雷姆居住在高高的懸崖頂端，只有他那傲慢的僕人薩納斯能利用傳送術到達那兒。$B$B薩納斯就在崖下紮營。你可以在埃達拉斯廢墟入口處找到通往艾薩拉的大道，在交叉路口往北直走就是了。","找到薩納斯，讓他將你傳送到大法師克希雷姆那兒。","","","","","","",0),
(8251,"zhTW","魔法的塵埃","艾薩拉的血精靈正在尋求一種碾磨他們獲得的魔法物品的方法，通過這種方法所獲得的粉末與普通的分解法術所獲得的材料是不同的。$B$B當我派我的學徒去交換這種粉末的時候，血精靈們毫不猶豫地把他幹掉了。因此，他們必須付出代價。$B$B談判結束，$N。找到艾薩拉北部的這些血精靈，然後使用更具“說服力”的方法來獲得他們的那些閃光塵埃。","為大法師克希雷姆收集10份閃光塵埃。","","去艾薩拉找在熊頭的大法師克希雷姆。","","","","",0),
(8252,"zhTW","納迦的珊瑚","看看你的四周吧。遺跡和海岸被惡鞭納迦所佔據了。最近，它們開始熟悉這塊土地，並開始接觸產于艾薩拉的稀有材料。$B$B我說的就是魔化珊瑚——不知道為什麼，惡鞭納迦也盯上了它。海灣中的珊瑚已經所剩無幾了，但是它們對於我的研究工作來說是至關重要的。我需要你去從惡鞭海妖那裡搶回一些魔化珊瑚，然後把它們帶給我。","收集6塊魔化珊瑚，然後把它們交給大法師克希雷姆。","","去艾薩拉找在熊頭的大法師克希雷姆。","","","","",0),
(8253,"zhTW","毀滅摩弗拉斯","在沉沒的阿塔哈卡神廟深處，有一條名叫摩弗拉斯的綠龍。$B$B數年前我受到他的襲擊，在我組織起有效的防禦之前，他就把我的學徒整個吞了下去。雖然死掉個把學徒對我來說不是很嚴重的事情，但他身上有一塊巨大的、擁有極強能量的奧術碎片。$B$B你必須召集隊友，共同深入神廟。去殺死摩弗拉斯，從這傢伙的胃中取出我的奧術碎片來。","從摩弗拉斯身上取回奧術碎片，然後返回大法師克希雷姆那兒。","","去艾薩拉找在熊頭的大法師克希雷姆。","","","","",0),
(8254,"zhTW","塞納裡奧議會的求助","神的道路是幫助那些需要幫助的人。如何去幫助他們，這並不重要；重要的是你為什麼要去幫助他們。$B$B塞納裡奧議會需要你的説明，去和艾薩拉的奧汀克談一談吧，他就住在埃達拉斯廢墟東北部懸崖的頂部。","找到艾薩拉的奧汀克。","","","","","","",0),
(8255,"zhTW","苔蹄快步者","艾薩拉的苔蹄快步者是一種曾經居住在費伍德森林的生物，它們對疾病和毒藥免疫，因此沒有被那裡的墮落力量所感染。在它們與生俱來的智慧的指引下，苔蹄快步者簡單地選擇了離開。$B$B雖然我感到非常遺憾，但是我希望你能幫助我去獵捕這些強大的野獸。收集四份健康的野鹿腺體，這是淨化藥膏的第一種成分——我們會利用淨化藥膏來治療費伍德森林。","收集4份健康的野鹿腺體，把它們交給艾薩拉的奧汀克。奧汀克住在埃達拉斯廢墟東北部懸崖的頂部。","","去艾薩拉找破碎海岸的奧汀克。","","","","",0),
(8256,"zhTW","亡靈的腐液","製作淨化藥膏所需的配方極其簡單：一份有毒的藥劑，兩份治療藥劑。你已經獲得了一份治療藥劑，那麼你得收集一份毒藥。$B$B埃達拉斯廢墟附近徘徊的上層精靈充滿了邪惡的力量，它們經常會生出一些令人作嘔的綠色粘液。這種東西被稱為亡靈腐液。$B$B這種東西的邪惡力量非常強大，因此我只需要你帶給我一份亡靈腐液就行了。","為艾薩拉的奧汀克帶回一份亡靈腐液。奧汀克住在埃達拉斯廢墟東北部懸崖的頂端。","","去艾薩拉找破碎海岸的奧汀克。","","","","",0),
(8257,"zhTW","摩弗拉斯之血","藥劑的最後一種成分就是我以前說的第二種治療藥劑。$B$B據說綠龍摩弗拉斯對任何形式的毒藥和疾病都免疫——這是無數德魯伊用生命換來的資訊。毫無疑問，他的血液符合我們的要求。$B$B在你收集最後一種成分時，塞納裡奧議會的一名信使將帶走你已經收集到的成分。召集你的夥伴，轉至沉沒的阿塔哈卡神廟中的綠龍巢穴吧。將他的血液交給費伍德森林中的格雷塔·苔蹄。","轉至沉沒的阿塔哈卡神廟，殺死綠龍摩弗拉斯，將他的血液交給費伍德森林中的格雷塔·苔蹄。沉沒的神廟的入口就在悲傷沼澤中。","","去費伍德森林找翡翠聖地的格雷塔·苔蹄。","","","","",0),
(8258,"zhTW","達克雷爾的威脅","死亡騎士達克雷爾主宰了通靈學院的屍骨儲藏所。他威脅要扭曲整個靈魂國度來達到他自己的目的，我們必須阻止他！這就是水晶球可以幫助你的地方。$B$B在屍骨儲藏所地下室的中心使用預言水晶球，以此來召喚達克雷爾的爪牙。擊敗這些爪牙，接下來死亡騎士就會出現了。$N，把他的徽記帶給我！只有他的死亡才可以將靈魂國度的局勢扭轉過來！","在通靈學院地下室的屍骨儲藏所的中心使用預言水晶球，然後與被召喚出來的幽靈作戰。擊敗這些幽靈之後，死亡騎士達克雷爾才會出現，你的任務就是擊敗他。$B$B把死亡騎士達克雷爾的徽記交給奧格瑞瑪智慧穀的薩格尼。","","去找奧格瑞瑪的薩格尼。","","","","",0),
(8259,"zhTW","更合適的獎勵","","","","","","","","",0),
(8260,"zhTW","阿拉索基本醫療包","","","","","","","","",0),
(8261,"zhTW","阿拉索標準醫療包","","","","","","","","",0),
(8262,"zhTW","阿拉索高級醫療包","","","","","","","","",0),
(8263,"zhTW","污染者基本醫療包","","","","","","","","",0),
(8264,"zhTW","污染者標準醫療包","","","","","","","","",0),
(8265,"zhTW","污染者高級醫療包","","","","","","","","",0),
(8266,"zhTW","奉獻綬帶","","","","去找灰谷的哨兵艾蒂亞·輕歌。","","","","",0),
(8267,"zhTW","奉獻綬帶","","","","去找灰谷的哨兵艾蒂亞·輕歌。","","","","",0),
(8268,"zhTW","奉獻綬帶","","","","去貧瘠之地找莫爾杉營地的沙塔爾·碎顱。","","","","",0),
(8269,"zhTW","奉獻綬帶","","","","去貧瘠之地找莫爾杉營地的沙塔爾·碎顱。","","","","",0),
(8270,"zhTW","測試複製任務","","","","","","","","",0),
(8271,"zhTW","雷矛英雄","","","","","","","","",0),
(8272,"zhTW","霜狼英雄","","","","","","","","",0),
(8273,"zhTW","奧蘭的感謝","","","","","","","","",0),
(8275,"zhTW","奪回希利蘇斯","注意了，聯盟的英雄們！有這樣一個威脅，我們長久以來都沒能將它消除。希利蘇斯地區的蟲穴中傳來的震顫提醒我們，它們的數量正在不斷地增加，它們正在準備更大規模的擴張！$B$B塞納裡奧議會的力量已經聚集在希利蘇斯，要及時地阻止那些異種生物！它們絕不能污染我們的土地！$B$B所有符合條件的勇士都去塞納裡奧要塞向喚風者梅恩·長角報告吧！異種生物必須被徹底消滅！","與希利蘇斯塞納裡奧要塞的喚風者梅恩·長角談一談。","","","","","","",0),
(8276,"zhTW","奪回希利蘇斯","注意了，部落的勇士們！有這樣一個威脅，我們長久以來都沒能將它消除。希利蘇斯地區的蟲穴中傳來的震顫提醒我們，它們的數量正在不斷地增加，它們正在準備更大規模的擴張！$B$B塞納裡奧議會的力量已經聚集在希利蘇斯，要及時地阻止那些異種生物！它們絕不能污染我們的土地！$B$B所有符合條件的勇士都去塞納裡奧要塞向喚風者梅恩·長角報告吧！異種生物必須被徹底消滅！","與希利蘇斯塞納裡奧要塞的喚風者梅恩·長角談一談。","","","","","","",0),
(8277,"zhTW","沙漠中的劇毒","比提克斯·斯巴格為你效勞！我的堂兄諾格在為塞納裡奧要塞的煉金師進行稀有草藥的採集工作，好吧，至少以前他在這麼做。在他最後一次回來的時候，他的血液中帶著一種強力毒液。$B$B我已經設法減緩毒性發作的時間，但是如果想要完全中和它的話，我就需要這種毒液的原始樣本。$B$B諾格是從北面回來的，因此我想應該是石鞭蠍或者掠沙蜘蛛幹的。帶給我一些尖刺和毒牙，然後我就可以製作解毒劑了。","希利蘇斯塞納裡奧要塞的比提克斯·斯巴格要求你帶8個石鞭蠍之刺和8個掠沙蜘蛛的牙齒給他。","","去希利蘇斯找塞納裡奧要塞的比提克斯·斯巴格。","","","","",0),
(8278,"zhTW","諾格的最後一線希望","該死的！解毒劑沒有生效。諾格一定是被南邊的某種毒性更強的生物蜇了。$B$B我需要你去那裡給我帶回更多的樣品，$N。好消息是因為它們的毒性夠強，所以我需要的樣品數量不用那麼多。壞消息是南部各種有毒生物的種類更多，因此我需要各種各樣的樣品。","希利蘇斯塞納裡奧要塞的比提克斯·斯巴格要求你給他帶去3個石鞭巨鉗蠍之刺、3個石鞭掠奪者之刺和3個石行蜘蛛的牙齒。","","去希利蘇斯找塞納裡奧要塞的比提克斯·斯巴格。","","","","",0),
(8279,"zhTW","暮光詞典","暮光之錘對於敢於侵犯他們的人絕不會手軟。他們把我當作野獸一樣進行獵捕。不用說，他們的敵人就是我的朋友！$B$B要破譯這塊石板上的文字，我需要用他們的文字撰寫的書籍來破譯這些秘密的資訊——我需要暮光詞典。這麼重要的工具被他們分成三章，放在了不同的地方！掌管它們的人被稱為暮光守護者，去暮光之錘營地找到他們吧。","把暮光詞典的三個章節交給希利蘇斯的隱士奧泰爾。","","去找希利蘇斯的隱士奧泰爾。","","","","",0),
(8280,"zhTW","保護補給線","塞納裡奧要塞具有相當重要的戰略意義。我確信只要我們可以控制住它，那麼我們對於異種蟲類的勝利必定會實現。另外我們還需要保證我們的物資補給可以及時到位。$B$B對於我們的補給商隊來說，遍地都是的沙蟲比異種蟲類威脅還要大。就在今天早上，一大批晨光麥被掘泥打擊者襲擊並全部損失；我需要你去減少它們的數量，以此來保證我們的物資流通順暢。","希利蘇斯塞納裡奧要塞的喚風者梅恩·長角要求你去殺死15只掘泥打擊者。","","去希利蘇斯找塞納裡奧要塞的喚風者梅恩·長角。","","","","",0),
(8281,"zhTW","確保安全","迄今為止，你的表現很好地證明了你的實力，$N。然而，我們的補給線還沒有完全安全。在解決了掘泥打擊者的問題之後，他們南部的親戚會佔據他們留下的空缺。$B$B你需要擊殺一些掘泥摧毀者，讓它們不敢輕易越雷池一步，我們絕不能視我們的補給線安全為兒戲。","希利蘇斯塞納裡奧要塞的喚風者梅恩·長角要求你去殺死20只掘泥摧毀者。","","去希利蘇斯找塞納裡奧要塞的喚風者梅恩·長角。","","","","",0),
(8282,"zhTW","諾格的背包","我在哪裡？我的包在哪裡？*氣喘吁吁*我一定是在逃脫那只巨蠍“死亡彎鉤”的時候把它給弄丟了。我在逃命的時候匆匆忙忙就跑進了一個石鞭掠奪者的巢穴。$B$B那個包裡有各種各樣的稀有材料。沒有了它們，我和比提克斯就沒有辦法製造塞納裡奧要塞所需要的藥劑了。我現在太虛弱，已經沒有辦法爬起來了，但是如果你可以把我的材料拿回來，那麼我就可以幫你製作這些藥劑。$B$B我是在南邊山中碰到死亡彎鉤的，就在銅須營地的後面。","從希利蘇斯南部山中找到諾格的背包，然後將它交給塞納裡奧要塞中的諾格。","","去希利蘇斯找塞納裡奧要塞的諾格·斯巴格。","","","","",0),
(8283,"zhTW","通緝：死亡彎鉤","我們相信，可怕的蠍子“死亡彎鉤”正在南面的山脈一帶活動。對南邊的巡邏士兵和遠征軍而言，她是個極大的威脅。誰能殺掉這個禍害，就將獲得價值不菲的獎勵。你可以向塞納裡奧要塞瞭望塔的衛兵隊長維斯·庫魯茲詢問獎勵事宜。","將死亡彎鉤的蠍鉗交給衛兵隊長維斯·庫魯茲。","","去希利蘇斯找塞納裡奧要塞的維斯·庫魯茲。","","","","",0),
(8284,"zhTW","暮光的秘密","暮光之錘教徒曾在西北方進行發展。如果你現在去那裡，還會發現那個區域到處都是元素生物，四周散落著的木頭碎片和帆布可以幫你找到營地所在的地點。$B$B我從那裡找回了一些粘土石板碎片，但是數量還不足以拼成有用的東西。如果你可以幫我找到其它的石板碎片，我們也許可以找到暮光之錘出現在希利蘇斯的原因。","希利蘇斯塞納裡奧要塞的地質學家拉克斯班要你去收集8塊暮光石板碎片。","","去希利蘇斯找塞納裡奧要塞的地質學家拉克斯班。","","","","",0),
(8285,"zhTW","沙漠隱士","傳說有一個前暮光之錘成員奧泰爾離開了這個團體，聽說他現在隱居在南風村。也許你可以在那裡尋求關於破譯這塊石板的幫助。$B$B帶上這塊拼好的石板，找到奧泰爾吧。","把復原的石板帶給希利蘇斯的隱士奧泰爾。","","","","","","",0),
(8286,"zhTW","明天的希望","當他出現時，我已經奄奄一息，瀕臨死亡。他對著我受傷的身體呼了一口氣，便耐心地等待著時間的沙礫清理我的傷口。$B$B他說，“如果必須這樣的話，你將永遠活下去。”這樣，我成為了一名守望者。$B$B看那片沙漠，第二場戰爭就要來臨了。你必須找到青銅龍的棲身之所。去時光之穴看看主人回來了沒有。我必須確認這一點才能有所行動。","轉至塔納利斯的時光之穴尋找諾茲多姆的子嗣，阿納克洛斯。$B$B完成任務後回到希利蘇斯塞納裡奧要塞的流沙守望者巴里斯托爾斯那兒。","找到諾茲多姆的子嗣。","去希利蘇斯找塞納裡奧要塞的流沙守望者巴里斯托爾斯。","","","","",0),
(8287,"zhTW","擺脫困境","嗯，是這樣的……我這裡有相當有用的資訊！我看到塞納裡奧議會的人來到了希利蘇斯。他們計畫把暮光之錘趕出這個地區，是不是？這很好；$B$B把這塊羊皮紙袋給他們的領袖，指揮官瑪爾利斯。不久之後暮光之錘就會被消滅，然後我就將永遠脫離他們的魔爪！","把解密石板碑文交給指揮官瑪爾利斯。","","","","","","",0),
(8288,"zhTW","唯一的領袖","不能再浪費時間了！我們必須找到一位英雄！完成任務需要一支軍隊，但是必須有一位真正的勇士擔負起統帥整個盟軍的重任。$B$B黑石之王的巢穴中有一頭異常兇猛的野獸：勒什雷爾。他守護著征戰大廳，阻止外人進入奈法利安的聖所。殺死那個邪惡的傢伙，把它的徽記帶給我，然後你就可以開始下一步的旅程了。","到黑石山中的奈法利安巢穴去，殺死勒什雷爾，並帶回它的徽記。$B$B將勒什雷爾的徽記交給希利蘇斯塞納裡奧要塞的流沙守望者巴里斯托爾斯。","","去希利蘇斯找塞納裡奧要塞的流沙守望者巴里斯托爾斯。","","","","",0),
(8289,"zhTW","功勳獎章","","","","去找灰谷的哨兵艾蒂亞·輕歌。","","","","",0),
(8290,"zhTW","擊敗入侵者","在這個通道的另一端，你會看到一片戰火紛飛的土地，年輕的$c。部落不斷侵入我們神聖的森林，鋸斷這裡的蒼天古樹來建造他們的戰爭機器。$B$B進入戰歌峽谷，幫助銀翼要塞擊敗入侵的部落勢力吧！$B$B完成這個任務，獲得一枚銀翼功勳獎章，我就會獎勵你。","進入戰歌峽谷抵禦部落小隊的攻擊，獲得一枚銀翼功勳獎章，然後向銀翼樹林中的哨兵艾蒂亞·輕歌回復。","","去灰穀找銀翼樹林的哨兵艾蒂亞·輕歌。","","","","",0),
(8291,"zhTW","擊敗入侵者！","在這個通道的另一端，你會看到一片戰火紛飛的土地，年輕的$c。部落不斷侵入我們神聖的森林，鋸斷這裡的蒼天古樹來建造他們的戰爭機器。$B$B進入戰歌峽谷，幫助銀翼要塞擊敗入侵的部落勢力吧！$B$B完成這個任務，獲得一枚銀翼功勳獎章，我就會獎勵你。","進入戰歌峽谷抵禦部落小隊的攻擊，獲得一枚銀翼功勳獎章，然後向銀翼樹林中的哨兵艾蒂亞·輕歌回復。","","去灰穀找銀翼樹林的哨兵艾蒂亞·輕歌。","","","","",0),
(8292,"zhTW","功勳獎章","","","","去找灰谷的哨兵艾蒂亞·輕歌。","","","","",0),
(8293,"zhTW","榮譽獎章","","","","去找貧瘠之地的沙塔爾·碎顱。","","","","",0),
(8294,"zhTW","鎮壓銀翼部隊","灰谷森林將在強大的部落面前屈服，$r。無論暗夜精靈們說什麼做什麼，都無法阻止我們的推進。卡利姆多屬於部落，誰敢阻止我們拿取屬於我們的東西，誰就要死！$B$B讓你的心中充滿榮耀之光，讓那些膽敢阻止我們的敵人一個個倒下。摧毀銀翼要塞中的哨兵部隊，並拿到一枚戰歌榮譽獎章。把這樣一枚獎章給我拿來，你就可以獲得獎賞。","進入戰歌峽谷擊敗聯盟小隊，獲得一枚戰歌榮譽獎章，然後向莫爾杉營地的沙塔爾·碎顱覆命。","","去貧瘠之地找莫爾杉營地的沙塔爾·碎顱。","","","","",0),
(8295,"zhTW","鎮壓銀翼部隊","灰谷森林將在強大的部落面前屈服，$r。無論暗夜精靈們說什麼做什麼，都無法阻止我們的推進。卡利姆多屬於部落，誰敢阻止我們拿取屬於我們的東西，誰就要死！$B$B讓你的心中充滿榮耀之光，讓那些膽敢阻止我們的敵人一個個倒下。摧毀銀翼要塞中的哨兵部隊，並拿到一枚戰歌榮譽獎章。把這樣一枚獎章給我拿來，你就可以獲得獎賞。","進入戰歌峽谷擊敗聯盟小隊，獲得一枚戰歌榮譽獎章，然後向莫爾杉營地的沙塔爾·碎顱覆命。","","去貧瘠之地找莫爾杉營地的沙塔爾·碎顱。","","","","",0),
(8296,"zhTW","榮譽獎章","","","","去找貧瘠之地的沙塔爾·碎顱。","","","","",0),
(8297,"zhTW","阿拉希盆地的資源！","我們必須依靠我們的士兵進行戰鬥，所有的士兵都會這麼告訴你的。他們還會告訴你，他們正在使用破爛不堪的裝備，饑腸轆轆地開向戰場！$B$B這就是阿拉希盆地顯得非常重要的原因。金屬，武器，食物，木材——所有我們所需要的東西都可以從那裡獲得。$B$B那就是我需要你發揮作用的地方，$N。進入阿拉希盆地，比敵人佔據更多的基地，以此來獲得戰鬥的勝利，然後給我帶回一箱資源來。","獲得阿拉希盆地戰鬥的勝利，獲取一隻阿拉希資源箱，然後向避難谷地的瑪克里爾中士覆命。","","去阿拉希高地找避難谷地的瑪克里爾中士。","","","","",0),
(8298,"zhTW","更多的資源","","","","去找阿拉希高地的瑪克里爾中士。","","","","",0),
(8299,"zhTW","切斷阿拉索補給線","阿拉索聯軍正在不惜一切代價進攻阿拉希，並妄圖奪回這個區域。聯盟的各個種族正在全力進軍這塊遙遠的土地，想要將他們的勢力從避難谷地擴張到這裡。我們必須阻止他們，而最好的方式就是奪取他們的資源。$B$B你可以幫助我們，$N。進入阿拉希盆地，那裡遍地都是豐富的礦藏、肥沃的土地和技藝精湛的能工巧匠。佔據並控制你找到的所有基地，贏得戰鬥，然後把你獲得的資源給我拿回來。","進入阿拉希盆地，獲得一箱阿拉希資源箱，然後將它交給落錘鎮的亡靈哨兵莫提斯。","","去阿拉希高地找東部禁錮法陣的亡靈哨兵莫提斯。","","","","",0),
(8300,"zhTW","更多的資源","","","","去找阿拉希高地的亡靈哨兵莫提斯。","","","","",0),
(8301,"zhTW","正義之路","諾茲多姆的子嗣根本不信任低等種族。雖然你已經向我證明了你的確具備了英雄的潛質，但是現在你還得向我的主人證明這一點。$B$B亞什蟲巢、左拉蟲巢、雷戈蟲巢，這些地方的蟲子們蠢蠢欲動，對我們形成了極大的威脅。殺死這些蟲巢中的異種蟲類，從它們的甲殼上取下碎片。當你獲得足夠多的碎片時，回到我這兒來。","希利蘇斯塞納裡奧要塞的流沙守望者巴里斯托爾斯想要你殺死亞什蟲巢、左拉蟲巢和雷戈蟲巢中的異種蟲類。從死去的蟲子屍體上收集異種蠍殼碎片。當你收集到200塊異種蠍殼碎片時，回到巴里斯托爾斯那兒去。$B$B作為一名諾茲多姆的特使，只有你和你的副官可以從異種蟲類的屍體上拾取異種蠍殼碎片。請注意保持你的包裹空間足夠多。","","去希利蘇斯找塞納裡奧要塞的流沙守望者巴里斯托爾斯。","","","","",0),
(8302,"zhTW","正義之手","凡人，明智地選擇你的副官。每當你完成一次任務，你就可以選擇一個新的副官。$B$B我需要更多的異種蠍殼碎片。別浪費時間！","希利蘇斯塞納裡奧要塞的流沙守望者巴里斯托爾斯想要你殺死亞什蟲巢、左拉蟲巢和雷戈蟲巢中的異種蟲類。從死去的蟲子屍體上收集異種蠍殼碎片。當你收集到200塊異種蠍殼碎片時，回到巴里斯托爾斯那兒去。","","去希利蘇斯找塞納裡奧要塞的流沙守望者巴里斯托爾斯。","","","","",0),
(8303,"zhTW","阿納克洛斯","是時候了，$N。$B$B我隱瞞這個秘密已經很久了，我對此深表歉意。敵人無處不在，很可能就在我們眼皮底下。請閱讀這本密典，好好運用我教給你的知識，去尋找我們的主人。","到塔納利斯的時光之穴去尋找阿納克洛斯。","","","","","","",0),
(8304,"zhTW","親愛的納塔莉亞","我親愛的納塔莉亞走失了。$B$B老實說，她失蹤之前好幾周都行為怪異。我不止一次看到她在四下無人時喃喃自語。她堅持說什麼自己是對的，堅持繼續自己的研究。$B$B我最後一次見她的時候，她正朝著南邊的銅須營地走去。$B$B我的兵力非常薄弱，$N。所以我想請你轉至銅須營地，問問那些矮人。","希利蘇斯塞納裡奧要塞的指揮官瑪爾利斯想要你詢問銅須營地的矮人。你可以在塞納裡奧要塞以南找到銅須營地。$B$B一旦你收集到有用的資訊，就回到指揮官瑪爾利斯那兒。","","去希利蘇斯找塞納裡奧要塞的指揮官瑪爾利斯。","詢問法蘭克爾","詢問魯特加爾","","",0),
(8305,"zhTW","久遠的記憶","你已經知道了故事的一半，現在是瞭解另一半的時候了。我和我的下屬的行事方法大相徑庭。返回希利蘇斯，去甲蟲之台吧。別害怕你所見的事物……別忘記你學到的東西。","希利蘇斯時光之穴的阿納克洛斯想要你轉至位於希利蘇斯南部沙漠的甲蟲之台。$B$B當你學習完畢後再回到他那兒去。","流沙之戰。","","","","","",0),
(8306,"zhTW","深入瘋狂之口","我想讓你轉至雷戈蟲巢，看看我心愛的納塔莉亞變成什麼樣了，$N。要單獨完成這項任務並不容易，我建議你帶上幾個朋友。在你動身轉至蟲巢之前，請一定返回營地跟那些矮人談談。他們或許會告訴你對付居住在蟲巢中的異種蟲類的竅門。$B$B$N，如果納塔莉亞真的如他們所說的那樣變得瘋狂……做你應該做的。$B$B<指揮官瑪爾利斯轉過身去。>","希利蘇斯塞納裡奧要塞的指揮官瑪爾利斯想要你找到他心愛的納塔莉亞。你收集到的資訊表明納塔莉亞·瑪爾利斯可能在南面的雷戈蟲巢。$B$B在你趕往蟲巢之前，記得去銅須營地拜訪一下那兒的矮人，他們或許會給你提些建議。$B$B$N，記住指揮官的話：做你應該做的……","","去希利蘇斯找塞納裡奧要塞的指揮官瑪爾利斯。","娜塔莉雅小姐的命運","","","",0),
(8307,"zhTW","沙漠食譜","要適應沙漠生活並不容易。我思念奧伯丁的小鳥和綠樹，而在希利蘇斯這片乾燥的土地上，可供食用的食物少之又少。我在嘗試著研究沙漠中的草藥，但是草藥的數量並不多。$B$B我曾經看到西邊的那些暮光之錘成員獵殺沙蟲作為食物。沙蟲的味道很苦，不知道他們是怎麼吃下去的……如果你碰巧去他們營地的話，記得仔細觀察，看能不能學到點什麼。","轉至塞納裡奧要塞以西的暮光之錘營地，調查沙蟲的烹飪方法。","","","","","","",0),
(8308,"zhTW","布萊恩·銅須的信","致此信的讀者：$B$B當你讀到這兒時，我可能已經死了，也可能很快就會死去，這很難說。總之，大部分人都已經死掉了。$B$B我已經找到了有關一位元泰坦的資訊。他和一個上古之神展開了一場激戰。是的，上古之神。我還找到通往安其拉的古老隧道。$B$B將這封信帶回我的營地，保證我的猴子有充足的食物和水，記得多抱抱它。$B$B- 布萊恩·銅須，探險特派員$B$B附：注意那些崇拜上古之神的暗夜精靈。","將布萊恩·銅須的信件帶往希利蘇斯南部的銅須營地。","","","","","","",0),
(8309,"zhTW","追查雕文","在我們首次嘗試進攻蟲巢、瑪爾利斯夫人變得瘋瘋癲癲之後，那些蟲巢中就不斷湧出蟲子來！這也許跟那些奇怪的水晶上的雕文有關。$B$B我們必須從三個蟲巢的水晶上取下拓文。如果我們能得到拓文，或許能揭開這種瘋症的謎團。$B$B帶上拓文工具，邀上你的夥伴，轉至蟲巢去吧，$N。取下三座蟲巢中的拓文之後再回到我這兒來。","希利蘇斯銅須營地的魯特加爾·雕石想要你轉至亞什蟲巢、左拉蟲巢和雷戈蟲巢，從蟲巢中的雕文水晶上取下拓文。$B$B使用地質學家的抄錄工具包獲取古老雕文的摹本。完成任務後回到魯特加爾·雕石那兒。","","去希利蘇斯找銅須營地的魯特加爾·雕石。","","","","",0),
(8310,"zhTW","破譯密碼","我得製作一種藥劑，幫助我們解讀拓文以及其拉蟲人和異種蟲的語言！我需要什麼？很高興你能這麼問！我需要腦子！確切地說，我需要居住在蟲巢中的不同種群的異種蟲的腦子。把它們的腦子給我，或許魯特加爾的努力就不會白費。","希利蘇斯銅須營地的弗蘭卡·石橋想讓你取回一個亞什異種蟲腦、一個左拉異種蟲腦和一個雷戈異種蟲腦。完成任務後回到弗蘭卡那兒。","","去希利蘇斯找銅須營地的弗蘭卡·石橋。","","","","",0),
(8311,"zhTW","耶斯帕爾的萬聖節糖果！","我想要去討萬聖節糖果，但是我不能去，因為我生病了。如果你可以代我去的話，我會給你一些我已有的糖果！我想你會喜歡這些糖果的……它可以讓你變成又好玩又可怕的東西！$B$B每座主城的旅店老闆都有準備萬聖節的糖果——你只要和他們交談，然後按照他們所要求的做就可以了！另外，鐵爐堡有個叫塔瓦斯德的小侏儒也在散發糖果。如果你得到了所有的糖果，就把它們都帶回來給我吧！","與暴風城、鐵爐堡和達納蘇斯的旅店老闆以及鐵爐堡的塔瓦斯德·基瑟爾談一談。按照他們的要求做出動作，並獲得他們的禮物。$B$B把達納蘇斯水果糖、諾莫瑞根橡皮糖、暴風城杏仁糖和鐵爐堡薄荷糖交給暴風城孤兒院的耶斯帕爾。","","去找暴風城的耶斯帕爾。","","","","",0),
(8312,"zhTW","斯波普斯的萬聖節糖果！","我想要去討萬聖節糖果，但是我不能去，因為我生病了。如果你可以代我去的話，我會給你一些我已有的糖果！我想你會喜歡這些糖果的……它可以讓你變成又好玩又可怕的東西！$B$B每座主城的旅店老闆都有準備萬聖節的糖果——你只要和他們交談，然後按照他們所要求的做就可以了！另外，森金村的一個名叫卡利·雷米克的巨魔也在散發糖果。如果你得到了所有的糖果，就把它們都帶回來給我吧！","與奧格瑞瑪、幽暗城和雷霆崖的旅店老闆以及森金村的卡利·雷米克談一談。按照他們的要求做出動作，並獲得他們的禮物。$B$B把雷霆崖奶糖、暗矛橡皮糖、奧格瑞瑪軟糖和幽暗城薄荷糖交給奧格瑞瑪孤兒院的斯波普斯。","","去找奧格瑞瑪的斯波普斯。","","","","",0),
(8313,"zhTW","分享知識","雖然你能讀懂沙蟲的烹飪配方，但是裡面提到的草藥和香料你都從未聽說過。卡蘭德拉斯或許對此有些瞭解。","將破碎的食譜交給塞納裡奧要塞旅店中的卡蘭德拉斯。","","","","","","",0),
(8314,"zhTW","揭開秘密","我們就快要取得突破了，$N！我們可以通過你取回的拓文在這塊晶華棱柱上重現雕文。很明顯，其拉蟲人和某種未知生物利用這種文字與異種蟲交流資訊。$B$B不幸的是，我們只能從雕文中發現這一點。我們需要設法揭開水晶中隱藏的秘密。$B$B將雕文水晶棱柱交給塞納裡奧要塞的地質學家拉克斯班。她或許能幫上忙。","銅須營地的魯特加爾·雕石想讓你將雕文水晶棱柱交給希利蘇斯塞納裡奧要塞的地質學家拉克斯班。","","","","","","",0),
(8315,"zhTW","召喚","雕文顯示，一位元其拉蟲人的使者跟三個異種蟲相約在一處龍骨旁見面。關於雕文上方的文字，我只能假設那是某種密碼。這密碼很可能是召喚其拉蟲人使者的關鍵。$B$B我將製作一份雕文密碼的副本，你把它放到格拉卡洛之骨的沙中。如果我沒猜錯的話，主宰會認為可以傳遞新資料了。殺死他們，然後跟其拉蟲人使者作戰。他是揭開水晶之謎的關鍵人物……","希利蘇斯塞納裡奧要塞的地質學家拉克斯班想讓你從其拉蟲人使者那裡取回水晶分解裝置。$B$B你已經奉命將召喚雕文帶往塞納裡奧要塞以南的格拉卡洛之骨處，將它們從沙中引出。一旦其拉蟲人使者露面，就殺死它，獲得水晶分解裝置。成功之後回到地質學家拉克斯班那兒去。$B$B你必須召集一支強大的軍隊來完成這項任務，$N！","","去希利蘇斯找塞納裡奧要塞的地質學家拉克斯班。","","","","",0),
(8316,"zhTW","軍備物資","","","","","","","","",0),
(8317,"zhTW","下廚","這食譜肯定會派上用場的。我得去準備沙漠肉丸子了。我需要你的説明，當然，我是不會讓你白費力氣的。","塞納裡奧要塞的卡蘭德拉斯需要製作10只沙漠肉丸子。","","去希利蘇斯找塞納裡奧要塞的卡蘭德拉斯。","","","","",0),
(8318,"zhTW","秘密交流","一些暮光之錘的教徒帶著寫有含糊不清詞句的紙片。我希望你可以弄一些來給我，$c。$B$B我說不清“含糊不清”是什麼概念，總之是含義不清的！他們用這些紙片進行不同團隊之間的秘密交流，如果我們可以找到更多這樣的紙片，那麼他們所能進行的交流就會更少！","把10片暮光密文信交給塞納裡奧要塞的鮑爾·蠻鬃。","","去希利蘇斯找塞納裡奧要塞的鮑爾·蠻鬃。","","","","",0),
(8319,"zhTW","暮光密文信","","","","去找希利蘇斯的鮑爾·蠻鬃。","","","","",0),
(8320,"zhTW","暮光地王","暮光之錘，一群屈服於毀滅力量的教徒，他們在希利蘇斯安營紮寨，日夜舉行奇怪的儀式。我們還不知道他們的計畫是什麼，但是我相信他們正在試圖和那些沙漠中的紅色水晶進行聯繫。$B$B雖然遲早我們會發現他們的秘密，但是眼下，我們需要立即中止他們的威脅。到他們在西邊設立的營地去，找到暮光地王。他們是這些惡棍的首領，也就是你要去擊殺的物件！","殺死10個暮光地王，然後向塞納裡奧要塞的霍姆·蠻鬃覆命。","","去希利蘇斯找塞納裡奧要塞的霍姆·蠻鬃。","","","","",0),
(8321,"zhTW","邪惡的維拉爾","我們發現又一個為暮光之錘運作的基地。那裡被稱為暮光小徑，它是一個位於希利蘇斯東北角的洞穴。該地區的首領，邪惡的維拉爾就徘徊在這個洞穴中——他就是你的下一個目標。當你完成這個任務之後，把他的戒指帶回來。$B$B祝你好運，$N。暮光之錘的惡行一定要被阻止。","把維拉爾的徽記之戒交給塞納裡奧要塞的霍姆·蠻鬃。","","去希利蘇斯找塞納裡奧要塞的霍姆·蠻鬃。","","","","",0),
(8322,"zhTW","腐爛的雞蛋","南海鎮的人們喜歡他們那裡釀的酒，他們為能夠在南海鎮旅館出售這種酒而感到自豪。隨著萬聖節的來臨，我們可以設法毀掉他們這幾個星期的酒！$B$B拿著這些腐爛的蛋，然後把它們放到南海鎮旅館裡面的主釀酒桶裡。你的行為必定會導致大規模的衝突，所以你要準備好保護自己！$B$B一旦你給了南海鎮一點教訓，他們就永遠都不會忘記的，記得回來向我報告！","將腐爛的雞蛋放在南海鎮旅店的主釀酒桶裡。","","","","","","",0),
(8323,"zhTW","真正的信徒","現在我擁有了暮光詞典，不過我還需要你幫我個小忙。$B$B我拋棄了我以前的組織，但是我還是很懷念他們每個月的時事通訊刊物。$B$B如果你想要笑的話就笑吧，但是在這段離開的日子閱讀《真正的信徒》是我消磨時間的好辦法。$B$B這份讀物中有許多我可以和你分享的資訊。請把任何你從暮光之錘成員身上找到的加過密的文字帶給我。","隱士奧泰爾要你帶回10張暮光密文信。","","去找希利蘇斯的隱士奧泰爾。","","","","",0),
(8324,"zhTW","更多的讀物","","","","去找希利蘇斯的隱士奧泰爾。","","","","",0),
(8325,"zhTW","奪回逐日島","你越快開始接受訓練，$N，就對我們大家越有好處。我們已經沒有任何容忍犯錯的餘地了，所以你可要聽仔細。$B$B那些太陽之塔西邊的懸浮著的綠色物體，就是燃燒水晶，它們長期以來給島內供應著能源，而法力浮龍則負責守護著這些水晶。天災軍團對奎爾薩拉斯的入侵大大干擾了我們對這些法力浮龍的魔法控制，導致它們變得不聽調遣。$B$B除了削減它們的數量以外，已經沒有其它的辦法了。去吧，完成之後再回來向我覆命。","殺死8只法力浮龍。它們位於法師塔和陽臺附近的燃燒水晶周圍。","","去永歌森林找逐日島的魔導師艾洛娜。","","","","",0),
(8326,"zhTW","令人遺憾的措施","你所做出的努力產生了一些後果，坦率地說，是我不希望看到的後果。燃燒水晶中紊亂的力量給這個島嶼上的生態平衡帶來的破壞遠比我的預料嚴重許多。我想，我們現在必須採取一些令人遺憾的措施來穩定局勢了。$B$B附近的山貓已經受到了水晶魔力的影響，成為了犧牲品，我們不得不清除它們。帶回它們的項圈，$N，這樣我就可以看看是否能給這些項圈附上一定的魔法抗性，幫助它們從瘋狂中恢復過來。","殺死一些魔泉山貓和魔泉山貓幼崽，並從它們身上收集8個山貓的項圈。完成之後向逐日島的魔導師艾洛娜覆命。","","去永歌森林找逐日島的魔導師艾洛娜。","","","","",0),
(8327,"zhTW","向蘭薩恩·派雷隆報到","你現在可以去向我的助手蘭薩恩·派雷隆報到了。他將會指示你如何進行下一步的工作。我們仍然會留在太陽之塔，繼續想方設法奪回對燃燒水晶的控制，與此同時，你則會去處理法瑟林學院那邊的問題。當你找到蘭薩恩之後，他會把那裡的情況詳細地解釋給你聽。$B$B他就在附近不遠的地方，你只需沿著這條小路向西走，就能找到他。$B$B祝你好運，$N，你一直以來的優秀表現一定會受到獎賞的。","與逐日島的蘭薩恩·派雷隆談一談，他就站在向西去的小路旁。","","","","","","",0),
(8328,"zhTW","法師訓練","既然你已經在你所選擇的職業上有所進步了，我想你一定會希望能夠獲得來自職業訓練師的更多指導。逐日島上有一位名叫朱莉亞·射日者的法師訓練師。去和她談談吧，看看她能教會你些什麼。當然，你得付點學費。$B$B朱莉亞跟逐日島其它訓練師都在太陽之塔的下層。","與逐日島太陽之塔內的法師訓練師朱莉亞·射日者談一談。","","","","","","",0),
(8329,"zhTW","戰士訓練","既然你已經在你所選擇的職業上有所進步，那麼你一定會希望能夠獲得更多來自職業訓練師的指導。耶泰尼斯·射日者負責教誨所有在逐日島一帶的年輕戰士。去和她談談吧，看看他能教會你些什麼。當然，向他求教是需要一些花費的，不會太貴，但至少記得帶上幾個銅板。$B$B耶泰尼斯和其它逐日島上的訓練師都在一塊兒，就在太陽之塔的下層。","與位於逐日島上太陽之塔內的戰士職業訓練師耶泰尼斯·射日者交談。","","","","","","",0),
(8330,"zhTW","索蘭尼亞的物品","由於逐日島這段時間以來所發生的混亂和變故，我幾乎完全沒有時間來收回我散落在島上的東西。現在我必須守在這裡觀察太陽之井，所以我想只能拜託你替我收回這些東西了。$B$B我需要我的占卜寶珠，我的天災魔法卷軸，還有我的日記本。來，拿著這個小背包，我的東西實在是太多了，你可以把它們都裝在這裡面帶回來。請一定要把它們帶回來給我，我會給你一點小禮物以表達謝意的——另外，這個小背包你也可以留下！","收集護井者索蘭尼亞的占卜寶珠、天災魔法卷軸和日記。它們分別位於逐日島上的池塘邊、噴泉附近以及一塊燃燒水晶旁。找到所有物品後，將它們歸還給太陽之塔上的護井者索蘭尼亞。","","去逐日島找太陽之塔的護井者索蘭尼亞。","","","","",0),
(8331,"zhTW","奧蕾爾·金葉","$N，儘管我們盼望著暮光之錘在希利蘇斯行動緩慢……遺憾地是，我們錯了。在對他們發動數次持續的攻擊之後，我們發現一種更為黑暗的力量——深淵議會通過分佈在暮光之錘營地的神秘風石控制著他們。$N，接下來，你要面對的就是深淵議會。$B$B跟塞納裡奧要塞東部的工匠奧蕾爾·金葉談談。她的技能會對你有所幫助。","與塞納裡奧要塞的奧蕾爾·金葉談一談。","","","","","","",0),
(8332,"zhTW","議會的公爵","我們認為應該可能使用一塊風石來伏擊一名深淵議會的公爵。前提是，需要有人通過風石來進行聯繫，並讓公爵確認你是暮光之錘的一名中層人員。$B$B因此我們需要暮光信徒身份勳章的複製品。我可以製作這樣一枚勳章，但是我需要一個大塊魔光碎片，還有深淵聖殿騎士所佩戴的紋章。$B$B把這些帶給我，然後我就可以完成剩下的工作了。","把1個大塊魔光碎片和3頂深淵紋章交給塞納利奧要塞的奧蕾爾·金葉。","","去希利蘇斯找塞納裡奧要塞的奧蕾爾·金葉。","","","","",0),
(8333,"zhTW","身份勳章","","","","去找希利蘇斯的奧蕾爾·金葉。","","","","",0),
(8334,"zhTW","攻勢","在派你進入學院之前，我還另外有件任務要你立刻處理。儘管這群兇暴的樹人嫩苗過去曾是我們逐日島上園丁們的好夥伴，可現在它們卻已經失去了控制。你要迅速將它們全部清除。不過你也要小心，失去控制以後，它們已經變得更加具有攻擊性。這樣的情況下，除了殺死它們，我們已經沒有其它辦法來清除這些曾經溫順的僕從了。$B$B向你下達這樣的命令，我感到很難過，但生存的需要大於一切。我以後會為它們哀悼的。","殺死7只樹人嫩苗和7只兇猛的樹人嫩苗，然後向逐日島的蘭薩恩·派雷隆覆命。","","去永歌森林找逐日島的蘭薩恩·派雷隆。","","","","",0),
(8335,"zhTW","放逐者菲倫德雷","西南方法瑟林學院的頂部住著一個背叛了我們的傢伙。$B$B他名叫菲倫德雷，因為藐視導師與長老們的警告而被放逐出了血精靈的土地。他是我們社會中的一顆毒瘤，如今已經只為滿足其自身貪得無厭的魔癮而活著。他拒絕學習控制魔癮的方法，於是現在成為了一具行屍走肉，成為了一個失心者，並威脅著太陽之塔的安全。$B$B給予他人道的毀滅吧，同時也記得殺死那些被他當作僕從的奧術怨靈。","殺死8只奧術怨靈和2只被污染的奧術怨靈，以及放逐者菲倫德雷，他們位於法瑟林學院。將菲倫德雷的徽記交給逐日島的蘭薩恩·派雷隆。","","去找逐日島的蘭薩恩·派雷隆。","","","","",0),
(8336,"zhTW","奧術薄片","我們失去了對島嶼上許多生物的控制，這真是太糟糕了。這裡曾是一片無比寧靜和諧的地方，最適合學習與研究了。可是現在，我們整天都把時間浪費在防備那些原本是被我們圈養的生物上！$B$B我現在將給你一個難得的機會，你只需要幫我做一些收集工作，我就可以幫你施展一個小魔法做為報酬。你可以在逐日島上所有使用魔法的生物身上找到一種名叫奧術薄片的東西，給我帶一打那玩意回來，完成之後，我會在你身上施放一個小法術，這樣你就能更好地在島上冒險了。","從逐日島上的任意使用魔法的生物身上收集6塊奧術薄片，把它們交給奧術師伊塔納斯。","","去永歌森林找逐日島的奧術師伊塔納斯。","","","","",0),
(8338,"zhTW","被污染的奧術薄片","你在這只被污染的奧術怨靈的屍體旁發現了一塊古怪的薄片，它已經被魔法結晶化了。這塊薄片與你見過的其它奧術薄片有著明顯的不同，散發著黑暗與邪惡的氣息，正如怨靈一般。只是拿著它，你就感覺到了某種非自然的邪惡預兆。$B$B太陽之塔露臺旁的奧術師赫裡恩或許能對這塊薄片進行一些研究。","將被污染的奧術薄片交給逐日島的太陽之塔露臺上的奧術師赫裡恩。","","","","","","",0),
(8339,"zhTW","議會的榮譽","要製作暮光信徒圖章戒指，我需要一堆物品","把物品帶給塞納里奧城堡的奧莉爾·金葉。","","","","","","",0),
(8340,"zhTW","暮光徽記之戒","","","","","","","","",0),
(8341,"zhTW","議會的領主","深淵議會的高階領主只有通過更大的風石才能召喚出來，而只有最高等級的暮光之錘官員才可以和他們說話。不過……我找到了進一步偽裝你並欺騙深淵領主的方法！$B$B我們要偽造一枚只有他們教派中最高級別的成員才擁有的暮光貴族之戒。如果你可以帶給我大塊魔光碎片和深淵徽記的話，我就可以幫你製作一個。","把5個大塊魔光碎片和3個深淵徽記交給塞納裡奧要塞的奧蕾爾·金葉。","","去希利蘇斯找塞納裡奧要塞的奧蕾爾·金葉。","","","","",0),
(8342,"zhTW","暮光徽記之戒","","","","去找希利蘇斯的奧蕾爾·金葉。","","","","",0),
(8343,"zhTW","金葉的發現","$N，奧蕾爾·金葉認為她找到了一種召喚並擊敗深淵議會成員的方法！這樣的任務是十分危險的，但是你已經贏得了塞納裡奧議會極大的尊重。如果有人可以完成這項任務，那麼這個人無疑就是你。$B$B祝你好運，$N。當你準備好之後就去和奧蕾爾談談。","與塞納裡奧要塞的奧蕾爾·金葉談一談。","","","","","","",0),
(8344,"zhTW","力量之源","記住我說的話，年輕的$n，這座島嶼已經被嚴重污染了，這種污染的威脅比起天災軍團留下的餘孽還要大。$B$B我確信，這片島嶼上應該有真正的惡魔存在。$B$B就在這裡西面的法瑟林學院，滋生著大量的奧術怨靈，它們就是一個能讓我們接觸到惡魔力量之源的視窗。你現在的任務就是給我帶回一些未被污染的怨靈精華，以及一些被污染的怨靈精華。$B$B作為給你的報酬，我會教你如何召喚小鬼，它將成為你所擁有的第一個惡魔僕從。","給逐日島的太陽之塔中的召喚者泰里拉倫帶回4份怨靈精華以及1份被污染的怨靈精華。","","去找永歌森林的召喚者泰里拉倫。","","","","",0),
(8345,"zhTW","達斯雷瑪的神龕","日復一日，我矗立在這裡，觀察著，思索著，等待著。當我極目遠眺著海平線時，有許多人指責我只會緬懷過去的日子，無法自拔。但我仍然堅定地認為，每一位來到這座島嶼的訪客都應紀念那些曾為我們的生存而付出並犧牲一切的人。$B$B達斯雷瑪·逐日者是我們的第一任國王。他領導著我們穿越了大漩渦，從卡利姆多來到這裡。$B$B去西邊尋找他的神龕吧，閱讀了上面的紀念銘文之後再回來找我。","閱讀達斯雷瑪的神龕上的銘文之後，向逐日島太陽之塔上的護井者索蘭尼亞覆命。","","去永歌森林找逐日島的護井者索蘭尼亞。","閱讀達斯雷瑪神殿","","","",0),
(8346,"zhTW","無盡的渴求","如果說你在逐日島學到的最重要一課是什麼，那無疑就是如何控制你對魔法的渴求了。血精靈對魔法的渴求是一種無止境的渴求，$N，你所吸收的能量必須完全處於你的掌控之中，並且通過奧術洪流將能量釋放出去。如果你失敗了的話，就將變成一個失心者……變成一個在絕望與瘋狂中苟活的癮君子。$B$B去島上尋找一條法力浮龍，對它使用奧術洪流技能吧。學會掌握欲望所生成的力量。當你學會如何釋放這種力量之後，回來找我。","對一條法力浮龍使用種族特長技能“奧術洪流”，然後向奧術師赫裡恩覆命。","","去永歌森林找逐日島的奧術師赫裡恩。","釋放奧流之術","","","",0),
(8347,"zhTW","幫助信使","魔導師艾洛娜要求你立刻轉至銀月城，以協助我們在那裡的收復行動……這也意味著，她承認你已經成功地解決了法瑟林學院方面的問題。你沒有讓我們失望，$N。$B$B在你轉至南面的鷹翼廣場的路上，或許你應該停下來和信使奧拉莉恩談談，她就在橋的邊上。$B$B信使們負責這裡與大陸之間的交通運輸工作，鑒於你是這樣的足智多謀，他們或許會需要你的説明。","與逐日島南部橋樑旁的信使奧拉莉恩談一談。","","","","","","",0),
(8348,"zhTW","公爵的徽記","霍姆告訴我說你知道召喚深淵公爵的方法了！真是件了不起的事兒。$B$B還有什麼能稱得上是了不起的成就呢？打扁這些傢伙。如果你明白我在說什麼，你就該知道這會對他們的屬下帶來多大的衝擊。把他們的徽記帶回來作為證據。","將深淵徽記交給塞納裡奧要塞的霍姆·蠻鬃。","","去希利蘇斯找塞納裡奧要塞的鮑爾·蠻鬃。","","","","",0),
(8349,"zhTW","鮑爾·蠻鬃","現在你有了勳章，並可以召喚深淵公爵，去和鮑爾·蠻鬃談談吧。他會派你去對付深淵議會。$B$B祝你好運，$N。如果你需要更多的勳章，那麼就來找我吧。","與塞納裡奧要塞的鮑爾·蠻鬃談一談。","","","","","","",0),
(8350,"zhTW","送信","又一位信使的犧牲……這真是一個悲劇，但早在我們接下這份工作的時候，就已經有犧牲的覺悟了。太陽之塔的魔導師艾洛娜希望我們把這只包裹運送到鷹翼廣場的旅店去，越快越好。$B$B但當前我們缺乏人手，我已經沒有任何同伴可以執行這個任務了。$B$B我不想對你說謊，從這裡通向鷹翼廣場的道路是非常危險的，一但離開黎明之路的安全範圍，就可能隨時遭遇攻擊。你能為我們完成這個任務嗎，$N？","將艾洛娜的包裹交給永歌森林鷹翼廣場旅店中的旅店老闆德蘭妮爾。","","","","","","",0),
(8351,"zhTW","與鮑爾談話","現在你可以偽裝成暮光議會的成員了，我想鮑爾·蠻鬃一定想跟你談談。去見他吧，準備接受一項艱巨的任務……","與塞納裡奧要塞的鮑爾·蠻鬃談一談。","","","","","","",0),
(8352,"zhTW","議會的節杖","霍姆和我剛才還談起你呢。他說你已經準備好跟深淵領主作戰了！$B$B我必須告訴你，這是一項非常危險的任務。你最好叫上支持人員。我並不是讓你帶上一兩個朋友，你需要的是一支做好充分的戰鬥準備的精英團隊。如果你的朋友跟你一樣出色，你們或許能打敗他！$B$B如果你打敗了深淵領主，和往常一樣，向我出示證據，我就會給你豐厚的獎勵。","將一柄深淵節杖交給塞納裡奧要塞的鮑爾·蠻鬃。","","去希利蘇斯找塞納裡奧要塞的鮑爾·蠻鬃。","","","","",0),
(8353,"zhTW","學小雞，換糖果","啊，跟一個生病的小孩子玩要糖果的惡作劇遊戲是吧？我要說的是，對四處要糖果的遊戲來說，你的年紀似乎大了點……$B$B嗯，我的糖果是一顆鐵爐堡薄荷糖，你得……你得學小雞咯咯叫！是的，小雞們喜歡薄荷糖……好吧，或許它們不喜歡……但是除非你學小雞叫，否則我不會給你薄荷糖的！$B$B好吧，$C，你準備好了沒？！我們開始吧！","為旅店老闆洛雷·火酒模仿小雞的動作，作為交換，你將得到一顆鐵爐堡薄荷糖！","","去找丹莫羅的旅店老闆洛雷·火酒。","為旅店老闆洛雷·火酒模仿小雞的動作","","","",0),
(8354,"zhTW","學小雞，換糖果","啊，跟一個生病的小孩子玩要糖果的惡作劇遊戲是吧？我要說的是，對四處要糖果的遊戲來說，你的年紀似乎大了點……$B$B嗯，我的糖果是一顆幽暗城薄荷糖，你得……你得學小雞咯咯叫！是的，小雞們喜歡薄荷糖……好吧，或許它們不喜歡……但是除非你學小雞叫，否則我不會給你薄荷糖的！$B$B好吧，$C，你準備好了沒？！我們開始吧！","為旅店老闆諾曼模仿小雞的動作，作為交換，你將得到一顆幽暗城薄荷糖！","","去找提瑞斯法林地的旅店老闆諾曼。","為旅店老闆諾曼模仿小雞的動作","","","",0),
(8355,"zhTW","學火車，換糖果","要糖果的惡作劇遊戲！哈哈！$B$B即使你正在做什麼高尚的事兒，比如為生病的小孩收集糖果之類的，我也不會輕易放過你。我有一顆諾莫瑞根橡皮糖要送給那個生病的孩子……如果你願意模仿火車聲音的話！哈哈，是的，這就是惡作劇！你要拿到水果糖，就得模仿火車的聲音！$B$B哢哢－嗚嗚，$C！","為塔瓦斯德·基瑟爾模仿火車的聲音，作為交換，你將得到一顆諾莫瑞根橡皮糖！","","去找濕地的塔瓦斯德·基瑟爾。","為塔瓦斯德模仿火車的聲音","","","",0),
(8356,"zhTW","顯肌肉，換糖果","你……你的裝束真有趣。即使你心眼好，在陪一個生病的小孩子玩要糖果的惡作劇遊戲，恐怕我還是得要求你做點什麼！$B$B讓我想想……你穿的衣服……看起來非常奇怪……你得炫耀自己的肌肉！是的，就是現在，炫耀你的肌肉吧，強壯的$g男:女;$c！$B$B你必須炫耀肌肉，這樣我才會給你美味的暴風城杏仁糖。這可是萬聖節的超美味糖果哦。","向旅店老闆奧裡森炫耀自己強壯的肌肉，作為交換，你將得到一顆暴風城杏仁糖！","","去找暴風城的旅店老闆奧裡森。","展示肌肉給旅店老闆奧裡森看","","","",0),
(8357,"zhTW","跳跳舞，換糖果","即使你在陪一個生病的小孩子玩要糖果的惡作劇遊戲，你也要做點什麼來換取糖果！傳統習俗可不能被破壞……$B$B我想一顆糖果的代價就是你得跳支舞！是的，讓我們看看你的舞姿！跳舞吧，我會給你美味的奶糖的！","為旅店老闆塞琳尼模仿跳舞動作，作為交換，你將得到一顆達納蘇斯水果糖！","","去找達納蘇斯的旅店老闆塞琳尼。","為旅店老闆塞琳尼跳舞","","","",0),
(8358,"zhTW","學火車，換糖果","要糖果的惡作劇遊戲！哈哈！$B$B即使你正在做什麼高尚的事兒，比如為生病的小孩收集糖果之類的，我也不會輕易放過你。我有一顆暗矛橡皮糖要送給那個生病的孩子……如果你願意模仿火車聲音的話！哈哈，是的，這就是惡作劇！你要拿到水果糖，就得模仿火車的聲音！$B$B哢哢－嗚嗚，$C！","為卡利·雷米克模仿火車的聲音，作為交換，你將得到一顆暗矛橡皮糖！","","去杜隆塔爾找暗矛海灘的卡利·雷米克。","為卡利·雷米克模仿火車的聲音","","","",0),
(8359,"zhTW","顯肌肉，換糖果","你……你的裝束真有趣。即使你心眼好，在陪一個生病的小孩子玩要糖果的惡作劇遊戲，恐怕我還是得要求你做點什麼！$B$B讓我想想……你穿的衣服……看起來非常奇怪……你得炫耀自己的肌肉！是的，就是現在，炫耀你的肌肉吧，強壯的$g男:女;$c！$B$B你必須炫耀肌肉，這樣我才會給你美味的奧格瑞瑪軟糖。這可是萬聖節的超美味糖果哦。","向旅店老闆格雷什卡炫耀自己強壯的肌肉，作為交換，你將得到一顆奧格瑞瑪軟糖！","","去找奧格瑞瑪的旅店老闆格雷什卡。","展示肌肉給旅店老闆格雷什卡看","","","",0),
(8360,"zhTW","跳跳舞，換糖果","即使你在陪一個生病的小孩子玩要糖果的惡作劇遊戲，你也要做點什麼來換取糖果！傳統習俗可不能被破壞……$B$B我想一顆糖果的代價就是你得跳支舞！是的，讓我們看看你的舞姿！跳舞吧，我會給你美味的奶糖的！","為旅店老闆帕拉曼模仿跳舞動作，作為交換，你將得到一顆雷霆崖奶糖！","","去找雷霆崖的旅店老闆帕拉。","跳舞給旅店老闆帕拉看","","","",0),
(8361,"zhTW","深淵聯絡","我們見過暮光之錘的信徒舉行儀式召喚強大的元素生物。我們不知道這些生物是他們崇拜的物件還是他們準備通過這些生物來和更加強大的力量進行溝通。有一件事是可以肯定的：他們聽從這些元素生物的命令。$B$B我需要你找到一名深淵聖殿騎士，然後擊敗他！擒賊先擒王，當你完成任務之後把證明帶回來。","希利蘇斯塞納裡奧要塞的鮑爾·蠻鬃要求你擊敗一名深淵聖殿騎士，並將一個深淵紋章帶回來作為證明。","","去希利蘇斯找塞納裡奧要塞的鮑爾·蠻鬃。","","","","",0),
(8362,"zhTW","深淵紋章","","","","去找希利蘇斯的鮑爾·蠻鬃。","","","","",0),
(8363,"zhTW","深淵徽記","","","","去找希利蘇斯的鮑爾·蠻鬃。","","","","",0),
(8364,"zhTW","深淵節杖","","","","去找希利蘇斯的鮑爾·蠻鬃。","","","","",0),
(8365,"zhTW","海盜的帽子！","你是公司派來幫忙的？我相信你可以的。聽好了，$c。就如你所知的那樣，我是艾澤拉斯上層社會最頂極服飾的提供者。皇帝和皇后，酋長和他們部落所稱的皇后，他們所有的穿著都由我親自推薦。他們可是為此付出了大價錢，而且他們確實得到了最好的服飾。$B$B接下來就是你該做的。你應該去落帆海灣，無論你用什麼辦法，都要去弄到儘量多的海盜的帽子。你認為你可以完成這個任務嗎？","塔納利斯熱砂港的傲慢的店主要你去幫他收集20頂南海海盜帽。","","去塔納利斯的熱砂港找傲慢的店主。","","","","",0),
(8366,"zhTW","南海復仇","啊！他們想要我完成一個不可能完成的任務！$B$B熱砂港想要我給南海海盜一些教訓。問題是我不能同時在兩個地方；我必須待在這裡守護和平。$B$B最近，那些海盜似乎忘記了熱砂港給他們的保護費。所以我希望你可以代表我去給他們洗洗腦子。$B$B你可以在這裡南邊不遠的落帆海灣找到他們。謝謝你，$N，我欠你的人情！","塔納利斯熱砂港的安全主管吉羅姆·比格維茲要你去幹掉10個南海海盜、10個南海劫掠者、10個南海碼頭工人和10個南海流氓。","","去塔納利斯找熱砂港的安全主管吉羅姆·比格維茲。","","","","",0),
(8367,"zhTW","無上的榮耀","與聯盟作戰是為部落效勞的莫大榮耀！那些在各條戰線上和聯盟作戰的士兵是我們最偉大的成員。我們要消滅我們的對手，而不是僅僅進行小規模的遭遇戰，我們要打精心準備的大戰。$B$B去每一條戰線上消滅聯盟吧！為了榮耀！為了部落！","在每個戰場上都取得1枚榮譽獎章，並將它們交給任意部落主城或沙塔斯城中的部落戰爭使者。","","去找部落戰爭使者。","","","","",0),
(8368,"zhTW","峽谷中的戰鬥","我們在戰歌峽谷對銀翼哨兵展開攻勢，這一戰役至關重要。聯盟以保護這片不屬於他們的森林為由，妄圖從部落手中奪取我們最大的伐木場。$B$B別讓他們的妄想成為事實，$N！為了部落，證明你的價值！成功之後再回到我這兒來。","將3枚戰歌榮譽獎章交給戰場外的部落戰爭使者。","","去找部落戰爭使者。","","","","",0),
(8369,"zhTW","奧特蘭克的入侵者","聽好了，$N。不管你以前聽說奧特蘭克山谷的戰鬥進行得怎麼樣，只有一件事情是真的：雷矛探險隊侵入了霜狼的領地。如果有一天我們可以讓聯盟從容地侵佔部落的領地，那麼我將會在那一天蒙羞自殺。出發吧，幹掉入侵者！","把1枚奧特蘭克山谷榮譽獎章交給戰場外的部落戰爭使者。","","去找部落戰爭使者。","","","","",0),
(8370,"zhTW","資源競賽","我們和聯盟的衝突已經上升為一場真正的戰爭，不久之後戰爭就將全面打響。$B$B對於阿拉希盆地的爭奪就是一個很好的開戰理由。要麼就是聯盟佔據它，並用其對付我們；或者就是我們佔據它，然後用來對付聯盟。幫助污染者保持這場資源競賽上的優勢吧，$N！","將3枚阿拉希盆地榮譽獎章交給戰場外的部落戰爭使者。","","去找部落戰爭使者。","","","","",0),
(8371,"zhTW","共同的努力","我們並不是在獨自與部落交戰，$g小夥子:小姑娘;。$B$B如果我們可以取得勝利，那麼我們就可以使用部落的資源來在其它的戰場上對抗他們。反之，如果我們輸掉了這場戰爭，那麼在其它的戰場上，部落將會佔有優勢。$B$B聯盟需要更多你這種身經百戰、意志堅定的老兵！$N，當你在所有戰場上都與部落交戰之後再回到我這裡。","在每個戰場上都取得1枚榮譽獎章，並將它們交給任意聯盟主城、達拉然或沙塔斯城中的聯盟準將。","","去找聯盟準將。","","","","",0),
(8372,"zhTW","自然屏障","銀翼哨兵正在和戰歌前鋒部隊爭奪這片森林。當然，銀翼哨兵保護森林的原因並非只有熱愛大自然這條理由。$B$B灰谷的森林對我們來說是一層天然的戰略屏障，可以抵抗大規模的進攻。如果沒有這片森林的話，阿斯特蘭納很快就會完全暴露在貧瘠之地的攻擊部隊面前。你願意參加對抗戰歌前鋒的戰鬥嗎？為了聯盟！","將3枚戰歌峽谷榮譽獎章交給戰場外的聯盟準將。","","去找聯盟準將。","","","","",0),
(8373,"zhTW","松木的力量","我對萬聖節最憎恨的一點就是被遺忘者用在南海鎮的臭氣彈。誰知道這些節日慶祝用的東西會搞得這樣臭氣熏天……$B$B在萬聖節期間，使用這個清潔器來把部落的雜碎們丟在村莊裡的臭氣彈處理掉吧。它使用了松木的力量來消除那些難聞的味道。$B$B你是否願意加入清潔南海鎮的行列？我會用萬聖節禮物來作為回報的。","使用臭氣彈清潔器來把散落在南海鎮的亡靈臭氣彈處理掉。當任務完成之後，回到南海鎮的哈特曼中士那裡。","清掃一顆被扔在南海鎮的臭氣彈！","去希爾斯布萊德丘陵找南海鎮的哈特曼中士。","","","","",0),
(8374,"zhTW","戰爭的動力","要取得戰爭的勝利，我們要做的並不僅僅是簡單地打敗敵人，勝利的關鍵往往取決於雙方的戰爭資源。$B$B阿拉希盆地蘊藏著大量物資，部落和聯盟都想搶先奪取這些資源。$B$B如果聯盟獲勝，我們的軍隊將獲得大量的劍和矛。如果部落獲勝，這些武器也一樣會被造出來，只不過是由部落的士兵拿在手裡，指著我們！去幫助阿拉希盆地的聯盟吧，$N。","將3枚阿拉希盆地榮譽獎章交給戰場外的聯盟準將。","","去找聯盟準將。","","","","",0),
(8375,"zhTW","銘記奧特蘭克！","不要搞錯了，$N。部落認為奧特蘭克山谷是霜狼氏族的領地，這種看法是很正確的。$B$B你看，雷矛探險隊來這裡是為了和平地搜索礦石和遺跡，而霜狼對此的反應卻極其粗暴和不文明，這是聯盟所沒有預想到的。$B$B讓我們為那些被偷襲的勇敢的矮人默哀吧。現在出發，$C，參加奧特蘭克山谷的大戰。為了聯盟！","把3枚奧特蘭克山谷榮譽獎章交給戰場外的聯盟準將。","","去找聯盟準將。","","","","",0),
(8376,"zhTW","軍備物資","","","","","","","","",0),
(8377,"zhTW","軍備物資","","","","","","","","",0),
(8378,"zhTW","軍備物資","","","","","","","","",0),
(8379,"zhTW","軍備物資","","","","","","","","",0),
(8380,"zhTW","軍備物資","","","","","","","","",0),
(8381,"zhTW","軍備物資","","","","","","","","",0),
(8382,"zhTW","軍備物資","","","","","","","","",0),
(8383,"zhTW","銘記奧特蘭克！","","","","去找聯盟準將。","","","","",0),
(8384,"zhTW","戰爭的動力","","","","去找聯盟準將。","","","","",0),
(8385,"zhTW","共同的努力","","","","去找聯盟準將。","","","","",0),
(8386,"zhTW","自然屏障","","","","去找聯盟準將。","","","","",0),
(8387,"zhTW","奧特蘭克的入侵者","","","","去找部落戰爭使者。","","","","",0),
(8388,"zhTW","無上的榮耀","","","","去找部落戰爭使者。","","","","",0),
(8389,"zhTW","峽谷中的戰鬥","","","","去找部落戰爭使者。","","","","",0),
(8390,"zhTW","資源競賽","","","","去找部落戰爭使者。","","","","",0),
(8391,"zhTW","戰爭的動力","","","","去找聯盟準將。","","","","",0),
(8392,"zhTW","戰爭的動力","","","","去找聯盟準將。","","","","",0),
(8393,"zhTW","戰爭的動力","要取得戰爭的勝利，我們要做的並不僅僅是簡單地打敗敵人，勝利的關鍵往往取決於雙方的戰爭資源。$B$B阿拉希盆地蘊藏著大量物資，部落和聯盟都想搶先奪取這些資源。$B$B如果聯盟獲勝，我們的軍隊將獲得大量的劍和矛。如果部落獲勝，這些武器也一樣會被造出來，只不過是由部落的士兵拿在手裡，指著我們！去幫助阿拉希盆地的聯盟吧，$N。","將3枚阿拉希盆地榮譽獎章交給戰場外的聯盟準將。","","去找聯盟準將。","","","","",0),
(8394,"zhTW","戰爭的動力","要取得戰爭的勝利，我們要做的並不僅僅是簡單地打敗敵人，勝利的關鍵往往取決於雙方的戰爭資源。$B$B阿拉希盆地蘊藏著大量物資，部落和聯盟都想搶先奪取這些資源。$B$B如果聯盟獲勝，我們的軍隊將獲得大量的劍和矛。如果部落獲勝，這些武器也一樣會被造出來，只不過是由部落的士兵拿在手裡，指著我們！去幫助阿拉希盆地的聯盟吧，$N。","將3枚阿拉希盆地榮譽獎章交給戰場外的聯盟準將。","","去找聯盟準將。","","","","",0),
(8395,"zhTW","戰爭的動力","要取得戰爭的勝利，我們要做的並不僅僅是簡單地打敗敵人，勝利的關鍵往往取決於雙方的戰爭資源。$B$B阿拉希盆地蘊藏著大量物資，部落和聯盟都想搶先奪取這些資源。$B$B如果聯盟獲勝，我們的軍隊將獲得大量的劍和矛。如果部落獲勝，這些武器也一樣會被造出來，只不過是由部落的士兵拿在手裡，指著我們！去幫助阿拉希盆地的聯盟吧，$N。","將3枚阿拉希盆地榮譽獎章交給戰場外的聯盟準將。","","去找聯盟準將。","","","","",0),
(8396,"zhTW","戰爭的動力","要取得戰爭的勝利，我們要做的並不僅僅是簡單地打敗敵人，勝利的關鍵往往取決於雙方的戰爭資源。$B$B阿拉希盆地蘊藏著大量物資，部落和聯盟都想搶先奪取這些資源。$B$B如果聯盟獲勝，我們的軍隊將獲得大量的劍和矛。如果部落獲勝，這些武器也一樣會被造出來，只不過是由部落的士兵拿在手裡，指著我們！去幫助阿拉希盆地的聯盟吧，$N。","將3枚阿拉希盆地榮譽獎章交給戰場外的聯盟準將。","","去找聯盟準將。","","","","",0),
(8397,"zhTW","戰爭的動力","","","","去找聯盟準將。","","","","",0),
(8398,"zhTW","戰爭的動力","","","","去找聯盟準將。","","","","",0),
(8399,"zhTW","自然屏障","銀翼哨兵正在和戰歌前鋒部隊爭奪這片森林。當然，銀翼哨兵保護森林的原因並非只有熱愛大自然這條理由。$B$B灰谷的森林對我們來說是一層天然的戰略屏障，可以抵抗大規模的進攻。如果沒有這片森林的話，阿斯特蘭納很快就會完全暴露在貧瘠之地的攻擊部隊面前。你願意參加對抗戰歌前鋒的戰鬥嗎？為了聯盟！","將3枚戰歌峽谷榮譽獎章交給戰場外的聯盟準將。","","去找聯盟準將。","","","","",0),
(8400,"zhTW","自然屏障","銀翼哨兵正在和戰歌前鋒部隊爭奪這片森林。當然，銀翼哨兵保護森林的原因並非只有熱愛大自然這條理由。$B$B灰谷的森林對我們來說是一層天然的戰略屏障，可以抵抗大規模的進攻。如果沒有這片森林的話，阿斯特蘭納很快就會完全暴露在貧瘠之地的攻擊部隊面前。你願意參加對抗戰歌前鋒的戰鬥嗎？為了聯盟！","將3枚戰歌峽谷榮譽獎章交給戰場外的聯盟準將。","","去找聯盟準將。","","","","",0),
(8401,"zhTW","自然屏障","銀翼哨兵正在和戰歌前鋒部隊爭奪這片森林。當然，銀翼哨兵保護森林的原因並非只有熱愛大自然這條理由。$B$B灰谷的森林對我們來說是一層天然的戰略屏障，可以抵抗大規模的進攻。如果沒有這片森林的話，阿斯特蘭納很快就會完全暴露在貧瘠之地的攻擊部隊面前。你願意參加對抗戰歌前鋒的戰鬥嗎？為了聯盟！","將3枚戰歌峽谷榮譽獎章交給戰場外的聯盟準將。","","去找聯盟準將。","","","","",0),
(8402,"zhTW","自然屏障","銀翼哨兵正在和戰歌前鋒部隊爭奪這片森林。當然，銀翼哨兵保護森林的原因並非只有熱愛大自然這條理由。$B$B灰谷的森林對我們來說是一層天然的戰略屏障，可以抵抗大規模的進攻。如果沒有這片森林的話，阿斯特蘭納很快就會完全暴露在貧瘠之地的攻擊部隊面前。你願意參加對抗戰歌前鋒的戰鬥嗎？為了聯盟！","將3枚戰歌峽谷榮譽獎章交給戰場外的聯盟準將。","","去找聯盟準將。","","","","",0),
(8403,"zhTW","自然屏障","銀翼哨兵正在和戰歌前鋒部隊爭奪這片森林。當然，銀翼哨兵保護森林的原因並非只有熱愛大自然這條理由。$B$B灰谷的森林對我們來說是一層天然的戰略屏障，可以抵抗大規模的進攻。如果沒有這片森林的話，阿斯特蘭納很快就會完全暴露在貧瘠之地的攻擊部隊面前。你願意參加對抗戰歌前鋒的戰鬥嗎？為了聯盟！","將3枚戰歌峽谷榮譽獎章交給戰場外的聯盟準將。","","去找聯盟準將。","","","","",0),
(8404,"zhTW","自然屏障","","","","去找聯盟準將。","","","","",0),
(8405,"zhTW","自然屏障","","","","去找聯盟準將。","","","","",0),
(8406,"zhTW","自然屏障","","","","去找聯盟準將。","","","","",0),
(8407,"zhTW","自然屏障","","","","去找聯盟準將。","","","","",0),
(8408,"zhTW","自然屏障","","","","去找聯盟準將。","","","","",0),
(8409,"zhTW","惡臭的雞蛋","腐爛的蛋已經被放進了桶裡。以後南海鎮旅館出產的酒肯定都是次品了！$B$B你現在應該回提瑞斯法林地向黑暗召喚者雅恩卡報告你的成功。","向提瑞斯法林地的黑暗召喚者雅恩卡覆命。","","","","","","",0),
(8410,"zhTW","元素掌握","捕風者巴斯拉需要你這樣充滿智慧的薩滿祭司。他要你帶上每種元素的樣本，證明你已準備就緒。$B$B你可以沿著塔倫米爾以東的河流往北走，巴斯拉就居住在沿途的一處廢墟中。","為捕風者巴斯拉收集一份空氣樣本、一份火元素樣本、一份土元素樣本和一份水元素樣本。","","去奧特蘭克山脈找冰風崗的捕風者巴斯拉。","","","","",0),
(8411,"zhTW","控制元素","歡迎。把元素交給我，然後我們再談談。$B$B火焰，空氣，水，還有大地。把它們交給我，然後我才能相信你。","將土元素、空氣元素、火元素和水元素交給捕風者巴斯拉。","","去奧特蘭克山脈找冰風崗的捕風者巴斯拉。","","","","",0),
(8412,"zhTW","靈魂圖騰","這地方的元素靈魂不再歡迎我了。$B$B我們都熟悉圖騰，現在我需要靈魂圖騰來保護自己。它由四種元素和一些更原始、更接近自然的材料構成。$B$B你可以去西瘟疫之地獲取熊爪和蜘蛛的眼球，另外有時食腐的鳥類也會掉落這兩種東西中的任何一種，這取決於它們上一頓吃了什麼東西……去吧，$N。","將靈魂圖騰所需的材料交給捕風者巴斯拉。","","去奧特蘭克山脈找冰風崗的捕風者巴斯拉。","","","","",0),
(8413,"zhTW","巫毒羽毛","靈魂圖騰還不夠。我們還需要一些巫毒魔法來讓它發揮效力。$B$B沉沒的神廟中的巨魔身上有巫毒羽毛。去殺掉加什爾、米杉、祖羅、胡庫、祖羅爾和洛若爾。這樣我們就能擁有一個真正的、具有魔法力量的靈魂圖騰了。","將巫毒羽毛交給捕風者巴斯拉。","","去奧特蘭克山脈找冰風崗的捕風者巴斯拉。","","","","",0),
(8414,"zhTW","驅散邪惡","你好，$C。在這片荒無人煙的土地上，像你這樣的十字軍是受到歡迎的。$B$B我們需要借助你神聖的力量來消滅這裡無窮無盡的亡靈。更重要的是，我們想讓你收集大量的天災石，將它們交給高階牧師賽爾鄧尼斯。賽爾鄧尼斯就在距離此地不遠的悔恨嶺守護烏瑟爾之墓。$B$B只有佩戴銀色黎明委任徽章的人可以找到天災石，如果你沒有徽章的話，就去跟軍官普爾哈特談談吧。","收集20個爪牙的天災石，並將它們交給西瘟疫之地的高階牧師賽爾鄧尼斯。","","去西瘟疫之地找烏瑟爾之墓的高階牧師賽爾鄧尼斯。","","","","",0),
(8415,"zhTW","冰風崗","指揮官阿什拉姆·瓦羅菲斯特需要你這樣純潔和勇敢的聖騎士，$N。你可以在西瘟疫之地南部的冰風崗找到他。以聖光的名義，去幫助他吧！","與冰風崗的指揮官阿什拉姆·瓦羅菲斯特談一談。","","","","","","",0),
(8416,"zhTW","惰性天災石","天災石上的邪惡力量已經被清除了，$N。$B$B我瞭解指揮官阿什拉姆的計畫，他還需要一塊惰性天災石。把惰性天災石帶給他，或許我們就能以正義之火消滅亡靈天災。","將惰性天災石交給冰風崗的指揮官阿什拉姆·瓦羅菲斯特。","","","","","","",0),
(8417,"zhTW","困擾的靈魂","在詛咒之地中有個受到困擾的靈魂，他生前曾是部落的一位偉大的英雄。戰士的榮耀絕不會隨著肉體的毀滅而消逝，如果可能的話，我希望你能幫幫他。","到詛咒之地的入口去，與部落英雄的靈魂談一談。","","","","","","",0),
(8418,"zhTW","鑄造力量之石","現在我們必須把惰性天災石組合起來，製造一件可以擊潰亡靈的武器。這不是一件輕鬆的任務，$n。只有沉沒的神廟中的那些巨魔身上攜帶著的魔法才擁有這種力量，正所謂以毒攻毒。。$B$B我需要沉沒的神廟裡那些巨魔的巫毒羽毛。加什爾、米杉、祖羅、胡庫、祖羅爾和洛若爾會掉落巫毒羽毛。不要為他們感到難過……他們是極端邪惡的存在。","轉至沉沒的神廟，從巨魔守護者們身上取得琥珀巫毒羽毛、藍色巫毒羽毛和綠色巫毒羽毛。","","去西瘟疫之地找寒風營地的指揮官阿什拉姆·瓦羅菲斯特。","","","","",0),
(8419,"zhTW","小鬼的要求","$N，費伍德森林有個名叫伊普斯的小鬼讓你去見他。這聽上去有些奇怪，因為他讓你帶上一塊惡魔布作為忠實的象徵。既然你已經是個強大的術士了，那我想不用說你也知道費伍德的薩特身上有時會帶著惡魔布吧？$B$B你可以在血毒瀑布以北找到伊普斯，我聽說這個季節血毒瀑布非常漂亮。","將一塊惡魔布交給費伍德森林的伊普斯。","","去費伍德森林找碎痕谷的伊普斯。","","","","",0),
(8420,"zhTW","灼熱的疼痛","或許一個小鬼說這話有些奇怪，但是我希望擁有自己的寵物。尼比把我當作寵物，我卻沒有寵物，這不公平！$B$B事實上，我並不需要什麼活物。如果你能給我一塊惡魔布的話，我就能製造一個寵物。這周圍的薩特身上經常帶著惡魔布，所以你可以去跟他們打打交道，你覺得如何？","將一塊惡魔布交給費伍德森林的伊普斯。","","去費伍德森林找碎痕谷的伊普斯。","","","","",0),
(8421,"zhTW","奇怪的材料","我已經有惡魔布啦，現在我可以開始製造*我的*寵物了。$B$B但是我還需要一些東西來製造寵物的眼睛。你能不能幫我從鐵樹上剝些腐爛的木頭來？這樣我才能雕刻出可愛的眼睛。我還需要血毒精華，讓我的寵物具有惡魔的氣息。被污染的軟泥怪具有這種精華，他們就在我們附近出沒。","將10塊腐爛的木頭和4個血毒精華交給費伍德森林的伊普斯。","","去費伍德森林找碎痕谷的伊普斯。","","","","",0),
(8422,"zhTW","巨魔的羽毛","我的寵物差不多要製作完成了。現在我需要一些填充物。$B$B我需要沉沒的神廟裡那些巨魔的巫毒羽毛。加什爾、米杉、祖羅、胡庫、祖羅爾和洛若爾會掉落巫毒羽毛。幹掉他們。全部。$B$B這項任務可不簡單，$N，我會送你一些尼比的東西——反正他似乎也用不著。","到沉沒的神廟去，從巨魔們身上獲得6支巫毒羽毛。","","去費伍德森林找碎痕谷的伊普斯。","","","","",0),
(8423,"zhTW","戰士的血脈","<英雄注視著你。>$B$B毫無疑問，你是一位$C。我要給你一項光榮的任務，但是首先，你必須證明自己的力量。$B$B據說雷克薩檢驗他的戰斧是否鋒利的標準，乃是它能否一下斬殺一頭地獄野豬。現在，我要通過讓你殺死它們來證明你擁有足夠的力量。","殺死7頭地獄野豬，然後回到部落英雄的靈魂那兒。","","去悲傷沼澤斷矛路口找部落英雄的靈魂。","","","","",0),
(8424,"zhTW","魔誓者之戰","我的存在本身就是個苦難，魔誓者更是為我帶來了無窮無盡的痛苦，他們的黑暗儀式讓我感到了比死亡還要可怕的苦楚。$B$B現在你可以幫我把痛苦帶給他們。去吧，成為我的憤怒的象徵。","殺死詛咒之地的魔誓者，然後回到部落英雄的靈魂那兒。","","去悲傷沼澤斷矛路口找部落英雄的靈魂。","","","","",0),
(8425,"zhTW","巫毒羽毛","你為我帶來一絲平靜。我得給你點什麼作為回報。$B$B我的武器和護甲陪我度過了光輝的歲月，現在它們對我來說都沒什麼用處了。還是送給你吧。$B$B去沉沒的神廟，殺死巨魔守衛加什爾、米杉、祖羅、胡庫、祖羅爾和洛若爾。他們的巫毒羽毛能使我的肉身重現一段時間，足夠給你獎勵了。將巫毒羽毛帶給我吧。","將你從沉沒的神廟的巨魔身上得到的巫毒羽毛交給部落英雄的靈魂。","","去悲傷沼澤斷矛路口找部落英雄的靈魂。","","","","",0),
(8426,"zhTW","峽谷中的戰鬥","我們在戰歌峽谷對銀翼哨兵展開攻勢，這一戰役至關重要。聯盟以保護這片不屬於他們的森林為由，妄圖從部落手中奪取我們最大的伐木場。$B$B別讓他們的妄想成為事實，$N！為了部落，證明你的價值！成功之後再回到我這兒來。","將3枚戰歌榮譽獎章交給戰場外的部落戰爭使者。","","去找部落戰爭使者。","","","","",0),
(8427,"zhTW","峽谷中的戰鬥","我們在戰歌峽谷對銀翼哨兵展開攻勢，這一戰役至關重要。聯盟以保護這片不屬於他們的森林為由，妄圖從部落手中奪取我們最大的伐木場。$B$B別讓他們的妄想成為事實，$N！為了部落，證明你的價值！成功之後再回到我這兒來。","將3枚戰歌榮譽獎章交給戰場外的部落戰爭使者。","","去找部落戰爭使者。","","","","",0),
(8428,"zhTW","峽谷中的戰鬥","我們在戰歌峽谷對銀翼哨兵展開攻勢，這一戰役至關重要。聯盟以保護這片不屬於他們的森林為由，妄圖從部落手中奪取我們最大的伐木場。$B$B別讓他們的妄想成為事實，$N！為了部落，證明你的價值！成功之後再回到我這兒來。","棒極了！你在戰歌峽谷保衛戰中表現突出！願你的英雄事蹟在我們的土地上流傳開來。","","去找部落戰爭使者。","","","","",0),
(8429,"zhTW","峽谷中的戰鬥","我們在戰歌峽谷對銀翼哨兵展開攻勢，這一戰役至關重要。聯盟以保護這片不屬於他們的森林為由，妄圖從部落手中奪取我們最大的伐木場。$B$B別讓他們的妄想成為事實，$N！為了部落，證明你的價值！成功之後再回到我這兒來。","將3枚戰歌榮譽獎章交給戰場外的部落戰爭使者。","","去找部落戰爭使者。","","","","",0),
(8430,"zhTW","峽谷中的戰鬥","我們在戰歌峽谷對銀翼哨兵展開攻勢，這一戰役至關重要。聯盟以保護這片不屬於他們的森林為由，妄圖從部落手中奪取我們最大的伐木場。$B$B別讓他們的妄想成為事實，$N！為了部落，證明你的價值！成功之後再回到我這兒來。","棒極了！你在戰歌峽谷保衛戰中表現很出色！願你的英雄事蹟在我們的土地上流傳開來。","","去找部落戰爭使者。","","","","",0),
(8431,"zhTW","峽谷中的戰鬥","","","","去找部落戰爭使者。","","","","",0),
(8432,"zhTW","峽谷中的戰鬥","","","","去找部落戰爭使者。","","","","",0),
(8433,"zhTW","峽谷中的戰鬥","","","","去找部落戰爭使者。","","","","",0),
(8434,"zhTW","峽谷中的戰鬥","","","","去找部落戰爭使者。","","","","",0),
(8435,"zhTW","峽谷中的戰鬥","","","","去找部落戰爭使者。","","","","",0),
(8436,"zhTW","資源競賽","我們和聯盟的衝突已經上升為一場真正的戰爭，不久之後戰爭就將全面打響。$B$B對於阿拉希盆地的爭奪就是一個很好的開戰理由。要麼就是聯盟佔據它，並用其對付我們；或者就是我們佔據它，然後用來對付聯盟。幫助污染者保持這場資源競賽上的優勢吧，$N！","將3枚阿拉希盆地榮譽獎章交給戰場外的部落戰爭使者。","","去找部落戰爭使者。","","","","",0),
(8437,"zhTW","資源競賽","我們與聯盟的衝突已經升級為真正的戰爭。在這個節骨眼上，雙方都不願意輕易開戰。$B$B阿拉希盆地的戰爭就是資源爭奪戰。不是聯盟奪得資源戰勝我們，就是我們奪得資源保持軍需供給。幫助污染者保護我們所需的戰爭資源，$N！","將3枚阿拉希盆地榮譽獎章交給戰場外的部落戰爭使者。","","去找部落戰爭使者。","","","","",0),
(8438,"zhTW","資源競賽","我們和聯盟的衝突已經上升為一場真正的戰爭，不久之後戰爭就將全面打響。$B$B對於阿拉希盆地的爭奪就是一個很好的開戰理由。要麼就是聯盟佔據它，並用其對付我們；或者就是我們佔據它，然後用來對付聯盟。幫助污染者保持這場資源競賽上的優勢吧，$N！","將3枚阿拉希盆地榮譽獎章交給戰場外的部落戰爭使者。","","去找部落戰爭使者。","","","","",0),
(8439,"zhTW","資源競賽","我們和聯盟的衝突已經上升為一場真正的戰爭，不久之後戰爭就將全面打響。$B$B對於阿拉希盆地的爭奪就是一個很好的開戰理由。要麼就是聯盟佔據它，並用其對付我們；或者就是我們佔據它，然後用來對付聯盟。幫助污染者保持這場資源競賽上的優勢吧，$N！","將3枚阿拉希盆地榮譽獎章交給戰場外的部落戰爭使者。","","去找部落戰爭使者。","","","","",0),
(8440,"zhTW","資源競賽","","","","去找部落戰爭使者。","","","","",0),
(8441,"zhTW","資源競賽","","","","去找部落戰爭使者。","","","","",0),
(8442,"zhTW","資源競賽","","","","去找部落戰爭使者。","","","","",0),
(8443,"zhTW","資源競賽","","","","去找部落戰爭使者。","","","","",0),
(8444,"zhTW","琥珀色的八卦陰影","","","","","","","","",0),
(8445,"zhTW","琥珀色的八卦陰影","","","","","","","","",0),
(8446,"zhTW","夢魘的纏繞","這東西了滲出墮落的力量。$B$B它和來自翡翠夢境的龍類或許有些關係。你必須找到能解讀這東西的人。或許月光林地或是塞納裡奧要塞的德魯伊能幫助你。","尋找能解讀夢魘包裹的物品中所隱藏的信息的人。$B$B或許擁有強大力量的德魯伊可以幫助你。","","","","","","",0),
(8447,"zhTW","喚醒傳說","月神湖的湖水可以融解這東西裡面的夢魘。給我點時間來淨化它吧，$N。","等待月光林地的守護者雷姆洛斯淨化夢魘包裹的物品。","喚醒傳說。","去月光林地找月神湖的守護者雷姆洛斯。","","","","",0),
(8448,"zhTW","神秘獎勵","","","","","","","","",0),
(8449,"zhTW","神秘獎勵","","","","","","","","",0),
(8450,"zhTW","神秘獎勵","","","","","","","","",0),
(8451,"zhTW","神秘獎勵","","","","","","","","",0),
(8452,"zhTW","神秘獎勵","","","","","","","","",0),
(8453,"zhTW","神秘獎勵","","","","","","","","",0),
(8454,"zhTW","神秘獎勵","","","","","","","","",0),
(8460,"zhTW","木喉熊怪的盟友","木喉部族是唯一沒有被墮落力量污染的熊怪部族。然而，許多其它的種族盲目地屠殺熊怪，卻並沒有搞清他們是敵是友。因此，木喉熊怪很少相信別人。$B$B你想要證明自己的立場嗎？去趕走腐化的死木部族，我們以後也許會接受你成為盟友。你可以在費伍德的南部找到死木戰士、探路者和園丁。","格拉茲要你去殺死6個死木戰士、6個死木探路者以及6個死木園丁。","","去費伍德森林找翡翠聖地的格拉茲。","","","","",0),
(8461,"zhTW","北方的死木熊怪","此地西南方向有一處死木熊怪的營地。我不清楚他們想要幹什麼，但是我希望能在他們開始搗亂之前就結果他們。$B$B死木部族非常邪惡，是惡魔的力量侵蝕了他們的心智。他們的天性並不壞，但是現在一切都無法挽回了。因此，我對被迫與自己的同胞作戰感到非常悲哀。$B$B$N，去結果他們吧，別對我說起戰鬥的具體過程，我不忍心聽到那些。","格拉茲要你去殺死6個死木守衛、6個死木復仇者和6個死木薩滿祭司。","","去費伍德森林找魔爪村附近的納菲恩。","","","","",0),
(8462,"zhTW","與納菲恩交談","也許你可以幫助我們木喉部族應付我們正在遭受著的更大的威脅。你一定可以在這裡展示自己的能力……$B$B在木喉要塞另一頭站著一個我的同類，就沿著這條路去背面。他的名字叫納菲恩；雖然他看上去是很兇猛和令人討厭的野獸，但是你不要害怕。他只是在尋求幫助來對抗那些威脅我們家園的力量。","沿著費伍德森林的路向北走，與一個名叫納菲恩的熊怪談談。他站在木喉要塞的入口處。","","","","","","",0),
(8463,"zhTW","不穩定的法力水晶","最近有一夥失心者從我們的奧術聖殿那邊劫走了一批極不穩定的法力水晶。如果不能妥善處置的話，那些水晶恐怕會引起爆炸，威力大得足以在城牆上開個洞出來。$B$B至於那些該死的傢伙們是否會在從水晶中抽取法力時被炸飛，我一點都不關心了，但整件事情仍然讓我臉面上很掛不住。$B$B把剩下的水晶給我找回來，它們或許還在原來的箱子裡。","給鷹翼廣場的艾爾杜·炙痕帶回6塊不穩定的法力水晶。","","去永歌森林找鷹翼廣場的艾爾杜·炙痕。","","","","",0),
(8464,"zhTW","冬泉熊怪的活動","木喉部族傾向於防守，$N。雖然我們允許那些值得信賴的朋友安全地通過，但我們還是盡可能地避開其它熊怪部族。$B$B最近我注意到冬泉部族與我們的敵對情緒有所增長。他們似乎處於極度憤怒的狀態，完全陷入了對一切他們無法理解的事物的恐慌和仇視。$B$B如果你能削減他們的數量，那對我們來說將是莫大的幫助，$N。","薩爾法要你去殺死8個冬泉薩滿祭司、8個冬泉巢穴守衛和8個冬泉巨熊怪。薩爾法就站在冬泉穀的木喉要塞入口處。","","去找冬泉穀的薩爾法。","","","","",0),
(8465,"zhTW","與薩爾法交談","除了來自南面的死木熊怪的墮落威脅之外，東面的冬泉熊怪同樣也同樣是我們的心頭大患。如果你願意繼續幫助我們的話，就去和要塞另外一頭的薩爾法談談吧。沿著左邊的這條路一直走下去。$B$B你要小心，如果我裡面的兄弟對你表示敵意，他們也許會攻擊你。儘快通過那裡，避免糾紛。你每殺死一個木喉熊怪——即便是出於自衛——都會極大地降低你在木喉熊怪中的聲望。","穿過木喉要塞去冬泉穀。和薩爾法談談，他就在木喉要塞另一頭的出口處。","","","","","","",0),
(8466,"zhTW","給格拉茲的羽毛","","","","去找費伍德森林的格拉茲。","","","","",0),
(8467,"zhTW","給納菲恩的羽毛","","","","去找費伍德森林的納菲恩。","","","","",0),
(8468,"zhTW","通緝：饑餓者泰裡斯","銀月城政府在此發佈公告，懸賞聲名狼籍的失心者團夥頭目，饑餓者泰裡斯。他因涉嫌參與包括謀殺兩名城市衛隊士兵在內的多起危害廣大銀月城人民群眾的惡性案件而被通緝。$B$B請向坎雷中士報告以領取賞金。","將泰裡斯的徽記交給永歌森林鷹翼廣場的坎雷中士。","","去永歌森林找鷹翼廣場的坎雷中士。","","","","",0),
(8469,"zhTW","給薩爾法的珠串","","","","去找費伍德森林的薩爾法。","","","","",0),
(8470,"zhTW","木喉熊怪的盟友","你找到了一根死木儀祭圖騰。圖騰本身沒有什麼雕刻的痕跡，但是一種讓人絕望的感覺卻在其中不斷地散發。如果有什麼東西導致了死木熊人的墮落的話，那麼這件東西貌似就是罪魁禍首了。$B$B木喉要塞中的某個熊人一定會用它……當然，你首先需要贏得和他們交談的聲望。","把死木儀祭圖騰帶到木喉要塞然後看看是否有熊人可以使用它。木喉要塞的熊人只有當你的聲望達到中立或者更高的時候才會和你說話。","","","","","","",0),
(8471,"zhTW","木喉熊怪的盟友","你找到了一根冬泉儀祭圖騰。圖騰本身沒有什麼雕刻的痕跡，但是它卻散發出一種讓人絕望的氣息。如果有什麼東西導致了冬泉熊怪的墮落的話，那麼這件東西應該就是罪魁禍首了。$B$B木喉要塞中的某個熊怪一定對它有興趣……當然，你首先需要在他們當中贏得一定的聲望。","把冬泉儀祭圖騰拿到木喉要塞去，看看是否有熊怪想要研究一下它。只有當你在木喉要塞的聲望達到中立或者更高級別的時候，木喉要塞的熊怪才會和你說話。","","","","","","",0),
(8472,"zhTW","失效的傀儡","在舊城區的廢墟裡，有一些原本負責保衛城市的奧術傀儡最近因為年久失修而失去了控制。它們已經無法辨認出自己的主人，只要見到我們就會立即對我們發起攻擊！$B$B儘管它們是很多年前製造出來的，但它們體內用於驅動機關運行的奧術核心仍然對我們很有價值。我希望你能為我回收這些奧術核心，我想它們還可以在某些地方派上用場。這些傀儡在西北方的銀月城廢墟中到處都是，很容易找到。","從遊蕩在銀月城遺跡中的奧術巡邏者身上獲取6枚奧術核心，把它們交給永歌森林鷹翼廣場的魔導師亞隆尼斯。","","去永歌森林找鷹翼廣場的魔導師亞隆尼斯。","","","","",0),
(8473,"zhTW","痛苦的抉擇","這些日子對我們來說，真是一段艱難的時刻，$N。為了防止天災軍團的擴張，我們必須燒毀永歌森林與幽魂之地邊境處的森林，這無疑是個艱難的抉擇。$B$B而最近，那些過去幾年中還曾是我們朋友的樹人，正在嘗試著重新培育焦痕谷周圍的樹木。$B$B這是個令人痛苦的抉擇，$c，但我們已經無法說服這些曾經的盟友放棄他們的做法了。我要求你立刻阻止他們，而你唯一可用的手段，就是武力。","在焦痕穀一帶殺死10名枯萎的護衛者，然後向永歌森林焦痕谷西北方的高塔內的拉莉亞娜·河風覆命。","","去永歌森林找金枝小徑的拉莉亞娜·河風。","","","","",0),
(8474,"zhTW","懷特巴克的墜飾","墜飾上刻著兩個字“河風”。\r\n 或許這兩個字可以告訴你誰是這個墜飾的製造者。","尋找製造懷特巴克的墜飾的人。他們或許會提供一些關於這件物品的線索。","","","","","","",0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_24_00' WHERE sql_rev = '1644944413701037300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
