/*
Navicat MySQL Data Transfer

Source Server         : 拾柒比赛
Source Server Version : 50505
Source Host           : 101.42.251.172:3306
Source Database       : sq_book

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2023-05-04 14:47:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for asq_applaud
-- ----------------------------
DROP TABLE IF EXISTS `asq_applaud`;
CREATE TABLE `asq_applaud` (
  `applaud_id` int(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(20) DEFAULT NULL COMMENT '用户',
  `book_id` int(20) DEFAULT NULL COMMENT '书籍',
  `cread_data` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`applaud_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COMMENT='用户喜欢文章列表';

-- ----------------------------
-- Records of asq_applaud
-- ----------------------------
INSERT INTO `asq_applaud` VALUES ('55', '1', '16', '2023-04-25 19:30:12');

-- ----------------------------
-- Table structure for asq_books
-- ----------------------------
DROP TABLE IF EXISTS `asq_books`;
CREATE TABLE `asq_books` (
  `book_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `book_writer_name` varchar(20) DEFAULT NULL COMMENT '书籍作者姓名',
  `book_name` varchar(20) DEFAULT NULL COMMENT '书籍名',
  `book_type` varchar(20) DEFAULT NULL COMMENT '书籍类型',
  `book_pub_date` datetime DEFAULT NULL COMMENT '出版日期',
  `book_up_date` datetime DEFAULT NULL COMMENT '上传日期',
  `book_press` varchar(20) DEFAULT NULL COMMENT '出版社',
  `book_cover` varchar(255) DEFAULT NULL COMMENT '书籍封面',
  `book_pdf_url` varchar(255) DEFAULT NULL COMMENT '书籍pdf',
  `book_audit` int(6) DEFAULT 0 COMMENT '0 待审核 1 审核成功 2 审核失败',
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='书籍';

-- ----------------------------
-- Records of asq_books
-- ----------------------------
INSERT INTO `asq_books` VALUES ('13', 'Sheldon Axler', '线性代数应该这样学', '学习', '1992-03-05 00:00:00', '2023-04-25 00:00:00', '中国工信出版集团', '/profile/upload/2023/05/04/b82116e3-95c9-46db-8db6-0d80d85b1165.jpg', '/profile/upload/2023/05/04/0d697359-f0b4-446a-b5e4-6ef11de9bd5c.pdf', '1');
INSERT INTO `asq_books` VALUES ('14', '刘慈欣', '三体', '科幻', '2010-04-23 00:00:00', '2023-04-25 00:00:00', '重庆出版社', '/profile/upload/2023/05/04/7285db79-8456-4328-8d30-3d81773c771e.png', '/profile/upload/2023/05/04/0d697359-f0b4-446a-b5e4-6ef11de9bd5c.pdf', '1');
INSERT INTO `asq_books` VALUES ('15', '陈磊', '半小时漫画宋词', '生活', '2020-04-15 00:00:00', '2023-04-25 00:00:00', '上海文艺出版社', '/profile/upload/2023/05/04/bc152714-7677-4c42-a3b3-eca6b8e4b266.jpg', '/profile/upload/2023/05/04/0d697359-f0b4-446a-b5e4-6ef11de9bd5c.pdf', '1');
INSERT INTO `asq_books` VALUES ('16', '周伟洲', '十六国史新编', '学习', '2016-07-22 00:00:00', '2023-04-25 00:00:00', '社会科学文献出版社', '/profile/upload/2023/05/04/8baf2c28-a741-4307-aee4-9ca9043fd888.jpg', '/profile/upload/2023/05/04/0d697359-f0b4-446a-b5e4-6ef11de9bd5c.pdf', '1');
INSERT INTO `asq_books` VALUES ('17', 'Letme', '从Letme到严君泽', '游戏', '2010-02-17 00:00:00', '2023-04-25 00:00:00', '芜湖出版社', '/profile/upload/2023/05/04/c8186804-62c3-419e-8908-aac6b3c96416.jpg', '/profile/upload/2023/05/04/0d697359-f0b4-446a-b5e4-6ef11de9bd5c.pdf', '1');
INSERT INTO `asq_books` VALUES ('18', '宗承灏', '中国历史中的生存游戏与权力博弈', '历史', '2015-03-03 00:00:00', '2023-04-25 00:00:00', '四川出版社', '/profile/upload/2023/05/04/f3847cbe-0d76-4bca-8d19-2b4543d1dfd6.jpg', '/profile/upload/2023/05/04/0d697359-f0b4-446a-b5e4-6ef11de9bd5c.pdf', '1');

-- ----------------------------
-- Table structure for asq_chat
-- ----------------------------
DROP TABLE IF EXISTS `asq_chat`;
CREATE TABLE `asq_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(64) DEFAULT NULL COMMENT '发送人id',
  `from_id` int(64) DEFAULT NULL COMMENT '接收方id',
  `content` text DEFAULT NULL COMMENT '聊天内容',
  `time` datetime DEFAULT current_timestamp() COMMENT '聊天时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=389 DEFAULT CHARSET=utf8 COMMENT='用户聊天表\r\n';

-- ----------------------------
-- Records of asq_chat
-- ----------------------------

-- ----------------------------
-- Table structure for asq_collect
-- ----------------------------
DROP TABLE IF EXISTS `asq_collect`;
CREATE TABLE `asq_collect` (
  `collect_id` int(20) NOT NULL AUTO_INCREMENT,
  `book_id` int(20) DEFAULT NULL COMMENT '书籍id',
  `user_id` int(20) DEFAULT NULL COMMENT '用户id',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`collect_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='加入书架';

-- ----------------------------
-- Records of asq_collect
-- ----------------------------
INSERT INTO `asq_collect` VALUES ('12', '16', '1', '2023-04-25 19:30:08');

-- ----------------------------
-- Table structure for asq_comment
-- ----------------------------
DROP TABLE IF EXISTS `asq_comment`;
CREATE TABLE `asq_comment` (
  `comment_id` int(20) NOT NULL AUTO_INCREMENT,
  `comment_parent_id` int(20) DEFAULT 0 COMMENT '父级id',
  `user_id` int(20) DEFAULT NULL,
  `com_body_id` int(20) DEFAULT NULL COMMENT '评论体',
  `comment_text` varchar(255) DEFAULT NULL COMMENT '评论内容',
  `com_body_type` int(1) DEFAULT NULL COMMENT '评论主体类型，1书，2社区',
  `create_date` datetime DEFAULT NULL,
  `like_num` int(20) DEFAULT 0 COMMENT '点赞数',
  `is_vio` int(1) DEFAULT 1 COMMENT '是否违规',
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- Records of asq_comment
-- ----------------------------
INSERT INTO `asq_comment` VALUES ('173', '0', '1', '13', '太好了，博主写的很好，期待你的更新', '2', '2023-04-25 17:47:38', '0', '1');
INSERT INTO `asq_comment` VALUES ('174', '0', '1', '13', '学的我头皮发麻！', '1', '2023-04-25 19:28:11', '0', '1');
INSERT INTO `asq_comment` VALUES ('175', '0', '1', '14', '中国科幻的巅峰！！！', '1', '2023-04-25 19:28:57', '0', '1');
INSERT INTO `asq_comment` VALUES ('176', '0', '1', '16', '中华文化源远流长，一本好书~~~~', '1', '2023-04-25 19:29:48', '1', '1');
INSERT INTO `asq_comment` VALUES ('177', '176', '1', '16', '推荐啊', '1', '2023-04-25 19:30:02', '0', '1');
INSERT INTO `asq_comment` VALUES ('178', '0', '1', '13', '你好', '1', '2023-04-25 20:36:00', '0', '1');
INSERT INTO `asq_comment` VALUES ('179', '174', '1', '13', '还行吧', '1', '2023-04-25 20:36:20', '0', '1');

-- ----------------------------
-- Table structure for asq_ppt
-- ----------------------------
DROP TABLE IF EXISTS `asq_ppt`;
CREATE TABLE `asq_ppt` (
  `ppt_id` int(20) NOT NULL AUTO_INCREMENT,
  `ppt_name` varchar(50) DEFAULT NULL COMMENT '幻灯片名称',
  `ppt_pic` varchar(255) DEFAULT NULL COMMENT '图片',
  `ppt_url` varchar(255) DEFAULT NULL COMMENT '跳转路径',
  `ppt_desc` int(20) DEFAULT NULL COMMENT '排序',
  `ppt_type` int(20) DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`ppt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='首页幻灯片广告位';

-- ----------------------------
-- Records of asq_ppt
-- ----------------------------
INSERT INTO `asq_ppt` VALUES ('4', '《半小时漫画宋词》荣登热榜！', '/profile/upload/2023/05/04/d2e84ae8-44d8-48c1-a0a1-ed67de8506e0.jpg', '15', '1', '1');
INSERT INTO `asq_ppt` VALUES ('5', '欢迎知名up “泡面拌饭” 加入拾柒爱阅读', '/profile/upload/2023/05/04/cad08f22-ff83-4193-a81c-781c7b72f26f.jpg', 'http://116.62.233.231/cms/main/cmsUserPage?userID=4', '2', '3');
INSERT INTO `asq_ppt` VALUES ('6', '网络小说大纲可以写到多细？', '/profile/upload/2023/05/04/2775a408-e237-469f-9349-75deb0e1144b.jpg', 'https://www.zhihu.com/question/313652396', '3', '3');

-- ----------------------------
-- Table structure for asq_rank_parm
-- ----------------------------
DROP TABLE IF EXISTS `asq_rank_parm`;
CREATE TABLE `asq_rank_parm` (
  `rank_parm_id` int(20) NOT NULL AUTO_INCREMENT,
  `book_id` int(20) DEFAULT NULL COMMENT '书籍id',
  `read_num` int(255) DEFAULT 0 COMMENT '阅读数',
  `applaud_num` int(255) DEFAULT 0 COMMENT '赞同数',
  `comment_num` int(255) DEFAULT 0 COMMENT '评论数',
  `collect_num` int(255) DEFAULT 0 COMMENT '加入书架数',
  PRIMARY KEY (`rank_parm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='排名参数';

-- ----------------------------
-- Records of asq_rank_parm
-- ----------------------------
INSERT INTO `asq_rank_parm` VALUES ('24', '15', '1', '0', '0', '0');
INSERT INTO `asq_rank_parm` VALUES ('25', '13', '8', '0', '3', '0');
INSERT INTO `asq_rank_parm` VALUES ('26', '14', '3', '0', '1', '0');
INSERT INTO `asq_rank_parm` VALUES ('27', '16', '6', '1', '2', '1');
INSERT INTO `asq_rank_parm` VALUES ('28', '17', '3', '0', '0', '0');
INSERT INTO `asq_rank_parm` VALUES ('29', '18', '13', '0', '0', '0');

-- ----------------------------
-- Table structure for asq_topic
-- ----------------------------
DROP TABLE IF EXISTS `asq_topic`;
CREATE TABLE `asq_topic` (
  `topic_id` int(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(20) DEFAULT NULL,
  `topic_name` varchar(255) DEFAULT NULL COMMENT '话题',
  `topic_content` text DEFAULT NULL COMMENT '文章',
  `topic_cover` varchar(255) DEFAULT NULL COMMENT '封面',
  `topic_createdate` datetime DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`topic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='话题表';

-- ----------------------------
-- Records of asq_topic
-- ----------------------------
INSERT INTO `asq_topic` VALUES ('11', '4', '如何评价《从 Letme 到严君泽》这本书？', '<p>现在这本书《从 Letme 到严俊泽》已经被粉丝调侃成了赵本山小品《昨天今天明天》中白云写的月子了，比喻书本内容毫无营养，成为厕纸了。</p><p><img src=\"http://116.62.233.231/prod-api/profile/upload/2023/04/25/17b00495-3adc-4e1d-8cf5-0be047aff321.png\"></p><p>另一方面是，他的职业亮点也不多，没有拿到S赛冠军，只有季中赛冠军和亚运会金牌。</p><p><br></p><p>荣誉偏少同时，Letme也不是担任主C的重任，他在场上多数都是充当工具人的作用，没有拿过什么MVP。</p><p><br></p><p>而且Letme本身也没有非常传奇的经历。唯一能让人称道的是，天赋一般但靠努力打出来一些。</p><p><br></p><p>现在谈起Letme更多是想到“众生平等”，选个坦克上单，把对面上单拉过来一起混。让玩家印象深刻从不是打出什么挽狂澜于既倒扶大厦之将倾的操作。</p><p><br></p><p>因此，职业生涯履历不足导致了在《从 Letme 到严俊泽》这本书上里有大量的注水，可写的内容不多，比如这本书名称看起来应该是主要讲Letme电竞生涯，但这部分内容一半都不到。</p><p><br></p><p>有一部分介绍英雄联盟还有奥恩、一部分提到他对上单对手的看法、还有比较多的部分说的是退役后，开服装店，养猫的生活，还有大量有的没的插图，可阅读的信息不多。</p><p><br></p><p>而且如果是这几年在看LPL的粉丝，对于RNG和Letme生涯一些事情和战绩都了解的话，这样条件下，书里内容无疑就是无聊在无聊了。</p><p><br></p><p>可能唯一有点营养的，就是提到当初征战雅加达亚运会电竞表演项目《英雄联盟》一些事情。这个因为当时一些特殊原因，国内粉丝能了解到亚运会上英雄联盟赛事信息有限，但这部分内容占的篇幅也不多。</p><p><br></p><p>最后，可能还有比较有乐子的是提到了RNG著名“惨案”，在S8世界赛八强赛惜败G2事情，提到了赛前的膨胀行为，Letme自己也表示担忧啦这些。但事实上，当初他也笑得很开心。</p><p><br></p><p><span style=\"color: rgb(18, 18, 18);\">只能说，Letme出书是一个很迷的操作，还是好好直播不是来的更好吗</span></p>', '/profile/upload/2023/05/04/439b7a34-acb1-4cae-843c-72bbb5c591ae.jpg', '2023-04-25 17:03:13');
INSERT INTO `asq_topic` VALUES ('12', '4', '哪本《数据结构与算法》最好？', '<p>有的同学还在读大学，代码还没写过几行；有的同学已经工作数十年，这之间的差别还是挺大的。而不同基础的人，适宜看的书是完全不一样的。因此，针对不同层次、不同语言的同学，分别推荐了不同的书。</p><p><strong class=\"ql-size-large\">针对入门的趣味书</strong></p><p>入门的同学，我建议你不要过度追求上去就看经典书。像《算法导论》《算法》这些书，虽然比较经典、比较权威，但是非常厚。初学就去啃这些书肯定会很费劲。而一旦啃不下来，挫败感就会很强。所以，入门的同学，我建议你找一些比较容易看的书来看，比如《大话数据结构》和《算法图解》。你不要太在意书写得深浅，重要的是能不能坚持看完。</p><p><br></p><p><br></p><p>《大话数据结构》这本书最大的特点是，它把理论讲得很有趣，不枯燥。而且每个数据结构和算法，作者都结合生活中的例子进行了讲解， 能让你有非常直观的感受。虽然这本书有400多页，但是花两天时间读完，应该是没问题的。如果你之前完全不懂数据结构和算法，可以先从这本书看起。</p><p><br></p><p>《算法图解》跟《大话数据结构》走的是同样的路线，就像这本书副标题写的那样，“像小说一样有趣的算法入门书”，主打“图解”，通俗易懂。它只有不到200页，所以内容比较少。作为入门，看看这本书，能让你对数据结构和算法有个大概的认识。</p><p><br></p><p>这些入门书共同的问题是，缺少细节，不够系统，也不够严谨。所以，如果你想要系统地学数据结构和算法，看这两本书肯定是不够的。</p><p>针对特定编程语言的教科书</p><p>讲数据结构和算法，肯定会跟代码实现挂钩。所以，很多人就很关心，某某书籍是用什么语言实现的，是不是自己熟悉的语言。市面大部分数据结构和算法书籍都是用C、C++、Java语言实现的，还有些是用伪代码。而使用Python、Go、PHP、JavaScript、Objective-C这些编程语言实现的就更少了。</p><p><br></p><p>我这里推荐《数据结构和算法分析》。国内外很多大学都拿这本书当作教材。这本书非常系统、全面、严谨，而且又不是特别难，适合对数据结构和算法有些了解，并且掌握了至少一门编程语言的同学。而且，这个作者也很用心。他用了三种语言，写了三个版本，分别是：《数据结构与算法分析 : C语言描述》《数据结构与算法分析 : C++描述》《数据结构与算法分析 : Java语言描述》。</p><p>。</p><p><br></p><p>如果你熟悉的是Python或者JavaScript，可以参考《数据结构与算法JavaScript描述》《数据结构与算法：Python语言描述》。至于其他语言的算法书籍，确实比较少。如果你有推荐，可以在留言区补充一下。</p><p>面试必刷的宝典</p><p>算法对面试很重要，很多人也很关心。我这里推荐几本有益于面试的书籍，分别是：《剑指offer》《编程珠玑》《编程之美》。</p><p><br></p><p>从《剑指offer》这本书的名字就可以看出，作者的写作目的非常明确，就是为了面试。这本书几乎包含了所有常见的、经典的面试题。如果能搞懂这本书里的内容，应付一般公司的面试应该不成问题。</p><p><br></p><p>《编程珠玑》这本书的豆瓣评分非常高，有9分。这本书最大的特色就是讲了很多针对海量数据的处理技巧。这个可能是其他算法书籍很少涉及的。面试的时候，海量数据处理的问题也是经常会问的，特别是校招面试。不管是开拓眼界，还是应付面试，这本书都很值得一看。</p><p><br></p><p>《编程之美》这本书有多位作者，其中绝大部分是微软的工程师，所以书的质量很有保证。不过，这里面的算法题目稍微有点难，也不是很系统，这也是我把它归到面试这一部分的原因。如果你有一定基础，也喜欢钻研些算法问题，或者要面试Google、Facebook这样的公司，可以拿这本书里的题，先来自测一下。</p><p>经典大部头</p><p>很多人一提到算法书就会搬出《算法导论》和《算法》。这两本确实非常经典，但是都太厚了，看起来比较费劲，我估计很少有人能坚持全部看下来。如果你想更加深入地学一学数据结构和算法，我还是强烈建议你看看。</p><p><br></p><p>我个人觉得，《算法导论》这本书的章节安排不是循序渐进的，里面充斥着各种算法的正确性、复杂度的证明、推导，数学公式比较多，一般人看起来会比较吃力。所以，作为入门书籍，并不是很推荐。</p><p><br></p><p>《算法》这本书也是一本经典大部头，不过它比起《算法导论》来要友好很多，更容易看懂，更适合初学者入门。但是这本书的缺点也很明显，就是内容不够全面，比如动态规划这么重要的知识点，这本书就没有讲。对于数据结构的东西，它讲的也不多，基本就是偏重讲算法。</p><p>殿堂级经典</p><p>说到殿堂级经典书，如果《计算机程序设计艺术》称第二，我想没人敢称第一。这本书包括很多卷。说实话，我也只看过比较简单的几卷，比如《基本算法》《排序和查找》。</p><p><br></p><p>这套书的深度、广度、系统性、全面性是其他所有数据结构和算法书籍都无法相比的。但是，如果你对算法和数据结构不是特别感兴趣，没有很好的数学、算法、计算机基础，想要把这套书读完、读懂是比较难的。你可以把它当作你算法学习的终极挑战。</p><p>闲暇阅读</p><p>算法无处不在。我这里再推荐几本适合闲暇时间阅读的书：《算法帝国》《数学之美》《算法之美》。</p><p><br></p><p>这些书共同的特点是，都列举了大量的例子，非常通俗易懂。夸张点说，像《算法帝国》，文科生都能读懂。当你看这些书的时候，你常常会深深感受到算法的力量，被算法的优美之处折服。即便不是从事IT工作的人，看完这几本书也可以开拓眼界。</p><p>这张手绘图是不是很好看？囊括了我以上列举的所有书籍，图片和推荐均来源于：《数据结构与算法之美》，除了书籍，这门专栏也极力推荐给你，这个专栏是市面上唯一一门真正适用于工程师的专栏，专栏中列举大量实际软件开发中的场景，给你展示如何利用数据结构和算法解决真实的问题。整个专栏会涵盖100 多个算法真实项目场景案例，更难得的是它跟市面上晦涩的算法书籍不同的是，还手绘了一些清晰易懂的详解图（总共有 300 多张）。</p><p>不管是不是科班出身，每一个程序员都应该花时间了解和学习计算机科学相关的基础知识，因为所有关于如何编程的底层逻辑和原理都在那里了。</p><p><br></p><p>这里有4本手册，全网累积下载100w次，几乎程序员人手一套，包含数据结构与算法、操作系统、计算机组成原理、计算机网络等硬核基础知识，图文+实战案例，平时开发+搞定面试，帮你快速建立对计算机科学的大局观，夯实计算机基本功，瞬间起飞～</p>', '/profile/upload/2023/05/04/028c04d4-7f03-418a-8947-de40d3d0b5c2.jpg', '2023-04-25 17:14:26');
INSERT INTO `asq_topic` VALUES ('13', '4', '刘慈欣的《三体》三部曲中哪一部最精彩？', '<p>哪一部最精彩，是一个见仁见智的问题</p><p><br></p><p>就我个人观感来说</p><p><br></p><p>第一部和第二部同级，都很精彩，顶级的阅读体验</p><p><br></p><p>第三部很差</p><p><br></p><p>前两部都是看的连载版，当年每个月最期待的就是学校图书馆杂志更新</p><p><br></p><p>第三部是很多年以后才看</p><p><br></p><p>出现以上两个评价差异主要有两个原因</p><p><br></p><p>第一，看前两部时刚开始接触科幻没几年，顶多是买过几本科幻世界</p><p><br></p><p>但是上了大学以后，有了电脑，白嫖了很多科幻经典，这就出现一个问题</p><p><br></p><p>同一类点子，第一次看很惊艳，第二次就很乏味</p><p><br></p><p>看前两部时，里面的点子对我来说，几乎都是第一次接触，观感就非常好</p><p><br></p><p>但是看第三部时，由于科幻的阅读量上来了，所以很多点子都是似曾相识的感觉，显得没有那么惊艳</p><p><br></p><p>比如程心的多次冬眠，一秒出戏到查尔斯·斯菲尔德的《末世》，特别是最后都是“质量”导致的宇宙末日，难绷</p><p><br></p><p>光速黑域那里，初看就有点像《猎户座防线》，到书尾提出宇宙规律当武器，实锤了，就是这玩意</p><p><br></p><p>神级文明大战导致宇宙改变，看起来就像黑暗版《宇宙创世新论》</p><p><br></p><p>总之，第三部的缝合感很严重，就像是把很多前人用过的点子修修改改，最后在强行串起来</p><p><br></p><p>第二，前两部也有串点子的问题，但是串的非常有意思，就算我现在重新回读，也不会觉得乏味</p><p><br></p><p>比如，多恒星导致的恶劣行星生态，在科幻小说中不少见，但刘慈欣用三体游戏，写出了本格推理的感觉，所有的证据都摆在眼前，但你猜不到是怎么一回事，直到谜底揭晓才恍然大悟</p><p><br></p><p>这种写法真是绝了，完爆《海利科尼亚》，在加上刘慈欣别出新材的用古代历史套壳，代入感一流，看着比《星之继承者》都爽</p><p><br></p><p>第二部，最精彩的莫过于章北海的反转，我看了那么多科幻小说，不得不说，这个反转无出其右</p><p><br></p><p>再说面壁者的设计，四个人都特色鲜明，你再看安迪威尔在《挽救计划》里设计的类似面壁者形象，那才是真·工具人，明显比刘慈欣差一截</p><p>整个三体系列，我最喜欢的就是三体2这一段</p><p><br></p><p>“刷子！”将军惊叫道。 外行往往更适合给专业对象命名，其实专家在进行这种命名时也总是从外行的视角进行的，“刷子”这个名称就这样固定下来，将军的描述很准确，那就是宇宙中的一把刷子，更准确地说只有刷毛，没刷柄。当然，也可以把它看做一排竖起的头发。 “是贴面划痕！在可行性研究阶段我就提出，镜片的粘贴组装方式必然出问题。”林格摇摇头说。 “所有贴面都经过严格检验，不可能存在这样的划痕，也不可能是镜片的其他瑕疵产生的，在已经传回的几万张测试图像中，从来没有出现过这个。”镜片制造方蔡司公司的专家说。</p><p>我最开始接触科幻小说，看的就是《猎户座防线》，所以这部小说在我心中的地位很高，以至于在此之后很久都没有初入科幻坑那种头皮发麻的感觉</p><p><br></p><p>直到在某一期科幻世界上看到上面这一段，熟悉的感觉又来了</p><p><br></p><p><br></p><p><br></p><p>但是三体3给我的感觉就是在刘慈欣划水，故事安排能力大幅度倒退，没有一个能让我拍案叫绝的情节</p><p><br></p><p>而且双主角的塑造有很大的问题</p><p><br></p><p>第一部，叶文洁的形象很完整，挑不出什么毛病，汪三水就是个摄像头，无视就好</p><p><br></p><p>第二部，双主角依然挑不出毛病，当然我有一点小怨念，这一部一开始就应该把罗辑塑造成一个十恶不赦的混蛋，当一个“混蛋”却是“救世主”，这种反差一定带感，不过书里的罗辑依然出色，以上不过是我的一点恶趣味</p><p><br></p><p>第三部，程心这个人就让我感觉很拧巴，让我感觉前后根本不是同一个人，一开始是一个智慧女科学家的形象，转头就成了坏事的圣母，转折积极生硬</p><p><br></p><p>维德刚好反过来，前面一直是不择手段前进的硬茬，最后突然就妥协，光速下线</p><p><br></p><p>三体有一个很有意思的地方，就是副主角手上沾血，最后会有一个不算好的结局，叶文洁的结局算正常水准，章北海的“都一样”是神来之笔</p><p><br></p><p>但维德妥协后突然下线，又让我感觉前后根本不是同一个人</p><p><br></p><p><br></p><p><br></p><p>一些次要原因是，三体3精准的踩了我的雷点</p><p><br></p><p>比如看三体3之前我还看了“安德”和“孤儿”两个系列</p><p><br></p><p>两个英雄，一个被利用，然后被当成种族灭绝的凶手，一个虽然被承认，但混的不像救世主，还要受别人的气</p><p><br></p><p>总之就是，让主角受点委屈，反应民众或者其他角色的无知</p><p><br></p><p>由于不喜欢安德系列，导致我对此类情节非常反感</p><p><br></p><p>当然这种在科幻小说里算常规操作了，只是我每次看到都觉得安排这种情节是闲的蛋疼</p><p><br></p><p>读到三体3的时候</p><p><br></p><p>“人类不感谢罗辑”</p><p><br></p><p>读到这里，我心里只想骂娘，又来这一套</p><p><br></p><p>不过这只是我个人的爱好，刘慈欣这么想本身没有任何问题</p><p><br></p><p>当然第三部也有我很喜欢的部分，尤其是云天明的童话</p>', '/profile/upload/2023/05/04/e62377c4-afe2-4a64-9148-b22b4b3139b5.png', '2023-04-25 17:18:48');
INSERT INTO `asq_topic` VALUES ('14', '1', '《半小时漫画宋词》简评', '<p>    上个月看完了《半小时漫画宋词（上）》，还写了一篇书评《<a href=\"https://www.zhihu.com/search?q=%E5%8D%8A%E5%B0%8F%E6%97%B6%E6%BC%AB%E7%94%BB%E5%AE%8B%E8%AF%8D&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A%22185034932%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\">半小时漫画宋词</a>》——开开心心学宋词。今天又把《下》看完了，简单发表些评论吧，就不写长书评了。</p><p>如果满分10分的话，《上》我会给5分，而《下》我可以给到8分。对于《上》，我的评价还是比较低的。千篇一律，内容不够丰富，漫画段子创新性不够。不知道是不是主创团队看到了我的心声，这个《下》将短板都补上了，给我一种惊艳的感觉。</p><p>《上》涵盖的历史从五代到北宋末期，而《下》是从北宋末期到南宋。全书让我记忆最深刻的一句话就是“国家不幸诗家幸”，正是因为北宋被金所灭，引发诗人的爱国情怀，才有《下》中一批词人的千古绝唱。如岳飞的《满江红》：</p><p><br></p><p><br></p><p><br></p><blockquote>满江红·怒发冲冠</blockquote><blockquote>怒发冲冠，凭栏处、潇潇雨歇。抬望眼、仰天长啸，壮怀激烈。</blockquote><blockquote><a href=\"https://www.zhihu.com/search?q=%E4%B8%89%E5%8D%81%E5%8A%9F%E5%90%8D%E5%B0%98%E4%B8%8E%E5%9C%9F&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A%22185034932%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\">三十功名尘与土</a>，<a href=\"https://www.zhihu.com/search?q=%E5%85%AB%E5%8D%83%E9%87%8C%E8%B7%AF%E4%BA%91%E5%92%8C%E6%9C%88&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A%22185034932%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\">八千里路云和月</a>。莫等闲、白了少年头，空悲切。</blockquote><blockquote>靖康耻，犹未雪。臣子恨，何时灭。驾长车，踏破贺兰山缺。</blockquote><blockquote>壮志饥餐胡虏肉，笑谈渴饮匈奴血。待从头、收拾旧山河，朝天阙。</blockquote><p>陆游的《书愤》：</p><p><br></p><p><br></p><p><br></p><blockquote>书愤</blockquote><blockquote>早岁那知世事艰，<a href=\"https://www.zhihu.com/search?q=%E4%B8%AD%E5%8E%9F%E5%8C%97%E6%9C%9B&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A%22185034932%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\">中原北望</a>气如山。</blockquote><blockquote>楼船夜雪瓜洲渡，铁马秋风大散关。</blockquote><blockquote>塞上长城空自许，镜中衰鬓已先斑。</blockquote><blockquote>出师一表真名世，千载谁堪伯仲间。</blockquote><p>还有辛弃疾的《破阵子》</p><p><br></p><p><br></p><p><br></p><blockquote>破阵子·为<a href=\"https://www.zhihu.com/search?q=%E9%99%88%E5%90%8C%E7%94%AB&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A%22185034932%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\">陈同甫</a>赋壮词以寄之</blockquote><blockquote>醉里挑灯看剑，<a href=\"https://www.zhihu.com/search?q=%E6%A2%A6%E5%9B%9E%E5%90%B9%E8%A7%92%E8%BF%9E%E8%90%A5&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A%22185034932%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\">梦回吹角连营</a>。八百里分麾下炙，五十弦翻塞外声，<a href=\"https://www.zhihu.com/search?q=%E6%B2%99%E5%9C%BA%E7%A7%8B%E7%82%B9%E5%85%B5&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A%22185034932%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\">沙场秋点兵</a>。</blockquote><blockquote>马作的卢飞快，弓如霹雳弦惊。了却君王天下事，赢得生前身后名。可怜白发生！</blockquote><p>在这本书中，你会认识到“苏门头号弟子黄庭坚”、“词中老杜<a href=\"https://www.zhihu.com/search?q=%E5%91%A8%E9%82%A6%E5%BD%A6&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A%22185034932%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\">周邦彦</a>”、“绝代才女李清照”、“尽忠报国岳飞”、“理学宗师朱熹”、“谁敢跟我比爱国：陆游（要我说，吴京敢）”、“中兴四大诗人：陆游&amp;<a href=\"https://www.zhihu.com/search?q=%E6%9D%A8%E4%B8%87%E9%87%8C&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A%22185034932%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\">杨万里</a>&amp;范成大&amp;尤袤”、“名将词人辛弃疾”、“全能音乐人姜夔”。</p><p>这里面几个人的诗词我们小时候都学过，然而印象中对于朱熹讲的几乎没有，他是怎样的人，为当时的社会带来怎样的贡献，很少有人知道。可以通过这本书简单了解一下。近来，我和儿子背古诗，也背过了朱熹的诗，很有哲学韵味在里面。如他的《<a href=\"https://www.zhihu.com/search?q=%E8%A7%82%E4%B9%A6%E6%9C%89%E6%84%9F&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A%22185034932%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\">观书有感</a>》：</p><p><br></p><p><br></p><p><br></p><blockquote>观书有感·其一</blockquote><blockquote>半亩方塘一鉴开，<a href=\"https://www.zhihu.com/search?q=%E5%A4%A9%E5%85%89%E4%BA%91%E5%BD%B1%E5%85%B1%E5%BE%98%E5%BE%8A&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A%22185034932%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\">天光云影共徘徊</a>。</blockquote><blockquote><a href=\"https://www.zhihu.com/search?q=%E9%97%AE%E6%B8%A0%E9%82%A3%E5%BE%97%E6%B8%85%E5%A6%82%E8%AE%B8&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A%22185034932%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\">问渠那得清如许</a>？为有源头活水来。</blockquote><p>上半年，疫情在家期间，我看过辛弃疾的一部电影《<a href=\"https://www.zhihu.com/search?q=%E8%BE%9B%E5%BC%83%E7%96%BE1162&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A%22185034932%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\">辛弃疾1162</a>》。里面辛弃疾的事迹很是传奇。他加入起义军，引荐之前的一位和尚朋友参加起义。而这位朋友却是金国派来的奸细，盗走了辛弃疾掌管的公章。辛弃疾发现后立誓3天追回叛徒。结果真的让他追到了并杀死了对方。我一直认为这是为了电影效果，瞎编乱造的，原来真有其事。这本书就叙述了这一段情节。</p><p>总之，《下》是非常值得一看的书，花费了我3小时的时间。半小时系列名不副实，应改为“<a href=\"https://www.zhihu.com/search?q=%E4%B8%89%E5%B0%8F%E6%97%B6%E6%BC%AB%E7%94%BB&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A%22185034932%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\">三小时漫画</a>”才对，然而这样内容丰富，老少皆宜，图文并茂的优秀作品，姑且原谅它吧！</p>', '/profile/upload/2023/05/04/633a97bf-86cd-48c3-b5d9-1f799ee5cb53.jpg', '2023-04-25 18:50:55');
INSERT INTO `asq_topic` VALUES ('15', '1', '《线性代数应该这样学》（《Linear Algebra Done Right》）这本书到底好在哪儿？', '<p>	<span class=\"ql-size-large\">	因为大家的评论反响还不错, 所以我在这放心地自荐一下, 相信题主会对这本书有一个全新的认识. 而且题主想要的信息在这个视频的评论区里基本都有.</span></p><p>		<span style=\"background-color: rgb(255, 235, 204);\">既然题主已经学过一遍线代, 那就满足了作者在前言中写的条件: 本书是给第二遍学线代的人准备的. 因为这本书的观点非常不同: 在线性空间这个舞台上研究</span><a href=\"https://www.zhihu.com/search?q=%E7%BA%BF%E6%80%A7%E6%98%A0%E5%B0%84&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A%221886414383%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 235, 204);\">线性映射</a><span style=\"background-color: rgb(255, 235, 204);\">, 而不会关注一些第一遍学线代时的内容(比如解</span><a href=\"https://www.zhihu.com/search?q=%E7%BA%BF%E6%80%A7%E6%96%B9%E7%A8%8B%E7%BB%84&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A%221886414383%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 235, 204);\">线性方程组</a><span style=\"background-color: rgb(255, 235, 204);\">的具体过程这些). 本书最重要的是第三章: Linear map, 只有这章熟练掌握之后才能保证后面几章学懂, 而第三章也是全书中最精彩的一章, 作者证明行秩=列秩时使用了</span><a href=\"https://www.zhihu.com/search?q=%E5%AF%B9%E5%81%B6%E7%A9%BA%E9%97%B4&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A%221886414383%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 235, 204);\">对偶空间</a><span style=\"background-color: rgb(255, 235, 204);\">, 对偶映射, 转置的知识, 最后仅仅通过6个\"等于号\"就证出了结果, 属实非常精彩. </span></p><p>		<span style=\"color: rgb(230, 0, 0);\">第五章~第八章则专门研究一个问题: 在什么样的基之下, 一个线性映射对应的矩阵具有比较简单的形式, 其中包括了非常重要的spectral theorem. </span></p><p><span style=\"color: rgb(230, 0, 0);\">行列式则放在了最后一章, 在讲行列式的应用时, 作者举了许多分析学中的例子, 比如重积分的</span><a href=\"https://www.zhihu.com/search?q=%E6%8D%A2%E5%85%83%E5%85%AC%E5%BC%8F&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A%221886414383%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(230, 0, 0);\">换元公式</a><span style=\"color: rgb(230, 0, 0);\">, 这里作者极力避开测度的定义去\"证明\"的样子也十分可爱(Axler最近出了一本Real </span><a href=\"https://www.zhihu.com/search?q=analysis%3A%20measure%20and%20integration&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A%221886414383%22%7D\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(230, 0, 0);\">analysis: measure and integration</a><span style=\"color: rgb(230, 0, 0);\">好像).</span></p>', '/profile/upload/2023/05/04/65bcddd2-04cd-44e0-928d-e26052cef3e5.jpg', '2023-04-25 18:56:43');
INSERT INTO `asq_topic` VALUES ('16', '1', '如今计算机是否还要读研？', '<p>		来写一个自己有趣的观察，不限于后端开发。</p><p>我今天在知乎搜了一些计算机学习路线，然后发现一件很有意思的事情：</p><p>百分之九十的高赞都是在毫无意义的堆砌大量的书单和一些公开课。名校公开课还好，毕竟基础架构这边确实有本科同学靠着扎实的公开课直接进入各个大厂的<a href=\"https://www.zhihu.com/search?q=%E5%9F%BA%E7%A1%80%E6%9E%B6%E6%9E%84&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A2878438672%7D\" rel=\"noopener noreferrer\" target=\"_blank\">基础架构</a>部门实习。如果他们有幸可以亲自参与一些对应的核心feature的开发的话，那么他们自然而然知道后面要怎么学习，要怎么进阶。考虑到这群本科同学已经卷到人手15445+6.824+若干其它名校lab，这要是放在去年的秋招环境下简直是大sp起步，如果还系统研读过824论文的话冲击ssp也是有可能的。</p><p>		现在这群小朋友真的很有意思，我当时大三还在玩<a href=\"https://www.zhihu.com/search?q=%E6%B3%A5%E5%B7%B4&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A2878438672%7D\" rel=\"noopener noreferrer\" target=\"_blank\">泥巴</a>，他们就已经卷到这个地步了。不过考虑到做基础架构这些lab的极大耐心（这些lab就算是抄都不好抄的），已经坚持做下来了，我觉得这批人完全不用读研。但本科卷成这样真的挺少的（不过今年部门简历情况真的很离谱，敢投基础架构部门后端的<a href=\"https://www.zhihu.com/search?q=%E5%AE%9E%E4%B9%A0%E7%94%9F&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A2878438672%7D\" rel=\"noopener noreferrer\" target=\"_blank\">实习生</a>基本人手15445+6.824+非打杂实习，这里面<a href=\"https://www.zhihu.com/search?q=%E6%9C%AC%E7%A7%91%E7%94%9F&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A2878438672%7D\" rel=\"noopener noreferrer\" target=\"_blank\">本科生</a>数量远超去年）。</p><p>		接着聊大部头堆砌的书单以及各种B站<a href=\"https://www.zhihu.com/search?q=%E5%89%8D%E5%90%8E%E7%AB%AF%E6%A1%86%E6%9E%B6&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A2878438672%7D\" rel=\"noopener noreferrer\" target=\"_blank\">前后端框架</a>学习课。怎么说呢，某种角度来说这种知识其实是没有门槛的。相对来说也是非科班<a href=\"https://www.zhihu.com/search?q=%E8%BD%AC%E7%A0%81&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A2878438672%7D\" rel=\"noopener noreferrer\" target=\"_blank\">转码</a>的同学，<a href=\"https://www.zhihu.com/search?q=%E7%A0%94%E7%A9%B6%E7%94%9F&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A2878438672%7D\" rel=\"noopener noreferrer\" target=\"_blank\">研究生</a>时期实验室不够给力转开发的同学，以及本科就业的同学学习最多的东西。我有个好朋友在隔壁坐<a href=\"https://www.zhihu.com/search?q=%E5%95%86%E4%B8%9A%E5%8C%96&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A2878438672%7D\" rel=\"noopener noreferrer\" target=\"_blank\">商业化</a>的部门，他和我吐槽说没实习的同学基本上人均谷粒商场，固然谷粒商场技术栈很深，然而应届真的不知道选用这些技术的前因后果，以及简历<a href=\"https://www.zhihu.com/search?q=%E5%90%8C%E8%B4%A8%E5%8C%96&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A2878438672%7D\" rel=\"noopener noreferrer\" target=\"_blank\">同质化</a>严重后其实真的很难脱颖而出。写这么多主要原因是以上这些都是被公开的课程，而且由于不像名校lab课那么劝退（好吧，22年开始也不劝退了，但确实比这些课难度简单很多），大家一股脑往这发力，其实没有什么行业壁垒，总体素质和潜力也没有公开课那群卷王厉害（防杠：总体）。以及再次吐槽，我甚至面过一个	本科写了6.828操作系统，15445数据库，6.824分布式kv，cs144tcp，以及cs61c cpu还阅读过leveldb同时1段大厂核心基础架构实习的卷王，对比起我曾经的大三大四，真的无地自容。这小哥换去年起码大sp，但可惜今年因为众所周知的hc问题，他遇到了同样卷的硕士卷王然后被比较掉了。不过这种究极卷王肯定不会失业，初创和<a href=\"https://www.zhihu.com/search?q=%E7%8B%AC%E8%A7%92%E5%85%BD&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A2878438672%7D\" rel=\"noopener noreferrer\" target=\"_blank\">独角兽</a>是非常欢迎这类基础扎实的<a href=\"https://www.zhihu.com/search?q=%E4%BC%98%E7%A7%80%E6%AF%95%E4%B8%9A%E7%94%9F&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A2878438672%7D\" rel=\"noopener noreferrer\" target=\"_blank\">优秀毕业生</a>的。</p><p>		那么本科水平这么废材的我，以及我组里大部分同事在本科的水平肯定要被今年敢投基础架构的简历的本科<a href=\"https://www.zhihu.com/search?q=%E5%BA%94%E5%B1%8A%E7%94%9F&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A2878438672%7D\" rel=\"noopener noreferrer\" target=\"_blank\">应届生</a>吊打的。但是为什么我之前能够进来呢？因为像这种纯system方向只有几所有限的985的top实验室才可能开设。进组之后贴心的<a href=\"https://www.zhihu.com/search?q=%E5%A4%A7%E5%B8%88%E5%85%84&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A2878438672%7D\" rel=\"noopener noreferrer\" target=\"_blank\">大师兄</a>会列出一系列论文+一系列公开课的project，以及组里的一些更早之前的师兄攒的项目（不然怎么发system方向的论文啊）。在这点上，<a href=\"https://www.zhihu.com/search?q=%E7%AE%97%E6%B3%95&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A2878438672%7D\" rel=\"noopener noreferrer\" target=\"_blank\">算法</a>方向也一样的。以上这些东西都是保密的。如果你读研想进入一些门槛更高的方向比如存储/数据库/芯片/<a href=\"https://www.zhihu.com/search?q=%E7%BC%96%E8%AF%91%E5%99%A8&amp;search_source=Entity&amp;hybrid_search_source=Entity&amp;hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A2878438672%7D\" rel=\"noopener noreferrer\" target=\"_blank\">编译器</a>/算法领域，争取保研然后进入这些顶级实验室是通选思路。本科刷公开课也是个路子，但今年批量的本科应届生刷课简历趋势下，我觉得这个思路已经逐渐过时了。</p><p>以上，希望对大家有所帮助。</p><p>		</p>', '/profile/upload/2023/05/04/4c860e8d-a2bd-44ff-84c0-0bea6cfbc602.jpg', '2023-04-25 19:00:50');

-- ----------------------------
-- Table structure for asq_writer
-- ----------------------------
DROP TABLE IF EXISTS `asq_writer`;
CREATE TABLE `asq_writer` (
  `writer_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `writer_name` varchar(20) DEFAULT NULL COMMENT '作者姓名',
  `writer_info` text DEFAULT NULL COMMENT '作者详情',
  `writer_intro` varchar(255) DEFAULT NULL COMMENT '作者座右铭',
  `writer_pic` varchar(255) DEFAULT NULL COMMENT '作者头像',
  PRIMARY KEY (`writer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='作者';

-- ----------------------------
-- Records of asq_writer
-- ----------------------------
INSERT INTO `asq_writer` VALUES ('9', 'Sheldon Axler', '<pre class=\"ql-syntax\" spellcheck=\"false\">1975年毕业于加州大学伯克利分校，现为旧金山州立大学理工学院院长。《美国数学月刊》的编委，*Mathematical Intelligencer*主编，同时还是Springer的GTM研究生数学教材系列等多个系列丛书的主编。\n</pre>', 'Life is challenge!', '/profile/upload/2023/05/04/7804a0a2-067d-480c-a1c1-ea8929f8f8c6.jpg');
INSERT INTO `asq_writer` VALUES ('11', '刘慈欣', '<p>刘慈欣，1963年6月出生于北京，祖籍河南省信阳市罗山县，山西阳泉人&nbsp;[62]&nbsp;&nbsp;，本科学历，高级工程师，&nbsp;[1]&nbsp;&nbsp;科幻作家，中国作家协会会员、第九届、第十届全委会委员，&nbsp;[2]&nbsp;&nbsp;[72]&nbsp;&nbsp;中国科普作家协会会员，山西省作家协会副主席&nbsp;[3-4]&nbsp;&nbsp;，阳泉市作家协会副主席，同时也是中国科幻小说代表作家之一。</p>', '时间不在于你拥有多少而在于你怎样使用', '/profile/upload/2023/05/04/83584c6b-8ffb-4edc-8e83-a97ae1323587.jpg');
INSERT INTO `asq_writer` VALUES ('12', 'Letme', '<p>严君泽，游戏ID：Letme，前中国电子竞技职业选手，司职上单。他曾效力于RNG战队、RYL战队。在职业生涯中，共帮助队伍获2017年LPL春季赛亚军、</p><p>2017年LPL夏季赛亚军、</p><p>2017年全球总决赛四强、</p><p>2018年LPL春季赛冠军、</p><p>2018年LPL夏季赛冠军、</p><p>2018年MSI世界赛冠军。</p><p>2018年8月29日，代表</p><p>中国队获得2018年</p><p>雅加达亚运会冠军等荣誉。2019年5月22日，正式退役。</p>', '希望能够得到你的反馈，这样我的手就不会抖', '/profile/upload/2023/05/04/039e57ef-6799-4e30-b2ed-d3f3ef7f45e9.png');
INSERT INTO `asq_writer` VALUES ('13', '陈磊', '<p>	<span style=\"color: rgb(51, 51, 51);\">陈磊以及其组创的半小时漫画团队，致力用漫画语言普及通识教育，无论学习哪个领域知识，这套书都将成为你学习路上的头一个“半小时”。</span></p>', '翻开本书，了解伟大词人一生的悲欢离合，感受千古名句背后的喜怒哀乐。', '/profile/upload/2023/05/04/2d13d7d1-f874-47d0-879c-1a0f51b065b0.jpg');
INSERT INTO `asq_writer` VALUES ('14', '周伟洲', '<p>周伟洲，男，1940年2月生，广东开平人，汉族，中共党员。1962年毕业于	西北大学	历史系考古专业，1965年西北大学民族史专业研究生毕业。1986年由讲师破格晋升为教授。现任	陕西师范大学	西北民族研究中心主任、博士生导师；兼任西北大学中国民族史团队首席专家、	中国魏晋南北朝史学会	会长、中国民族文学会副会长、	中国中外关系史学会	副会长、中国中亚文化研究协会副会长等。</p>', '历史时期新疆民族的发展与变迁', '/profile/upload/2023/05/04/aa2d22f4-d6f6-4f21-b05b-694760cae43d.jpg');
INSERT INTO `asq_writer` VALUES ('15', '宗承灏', '<p>	<span style=\"color: rgb(51, 51, 51);\">宗承灏，新一代非虚构历史作品领军人物；专栏作家。已出版《《出轨的盛唐》系列、《跑偏的帝国：大明王朝谁当家》、《灰章程》、《官家定律》、《生存的逻辑》等多部畅销作品。“中国好书榜年度好书”获奖作家。</span></p>', '真正的大师永远都怀着一颗学徒的心', '/profile/upload/2023/05/04/75defcfb-1440-4a38-829b-798a620437f2.jpg');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES ('3', 'asq_books', '图书管理', null, null, 'AsqBooks', 'crud', 'com.ruoyi', 'bookM', 'books', '图书管理', 'ruoyi', '0', '/', '{\"parentMenuId\":\"2015\"}', 'admin', '2022-03-22 10:54:19', '', '2022-05-02 17:21:38', null);
INSERT INTO `gen_table` VALUES ('4', 'asq_writer', '作者', null, null, 'AsqWriter', 'crud', 'com.ruoyi', 'writer', 'writer', '作者管理', 'liefox', '0', '/', '{\"parentMenuId\":\"2022\"}', 'admin', '2022-04-25 21:22:42', '', '2022-04-25 21:47:32', null);
INSERT INTO `gen_table` VALUES ('5', 'asq_ppt', '前台首页幻灯片', null, null, 'AsqPpt', 'crud', 'com.ruoyi', 'ppt', 'ppt', '前台首页幻灯片', 'ruoyi', '0', '/', '{\"parentMenuId\":2029}', 'admin', '2022-07-24 18:17:52', '', '2022-07-24 18:25:03', null);
INSERT INTO `gen_table` VALUES ('6', 'asq_rank_parm', '排名参数', null, null, 'AsqRankParm', 'crud', 'com.ruoyi', 'rankParm', 'rankParm', '排名参数', 'ruoyi', '0', '/', '{}', 'admin', '2022-07-28 08:57:08', '', '2022-07-28 09:08:00', null);
INSERT INTO `gen_table` VALUES ('7', 'asq_applaud', '用户喜欢文章列表', null, null, 'AsqApplaud', 'crud', 'com.ruoyi', 'applaud', 'applaud', '用户喜欢', 'zjh', '0', '/', '{}', 'admin', '2022-10-24 21:32:51', '', '2022-10-25 19:27:07', null);
INSERT INTO `gen_table` VALUES ('9', 'asq_collect', '加入书架', null, null, 'AsqCollect', 'crud', 'com.ruoyi', 'collect', 'collect', '加入书架', 'zjh', '0', '/', '{}', 'admin', '2022-10-26 19:28:56', '', '2022-10-26 19:29:31', null);
INSERT INTO `gen_table` VALUES ('10', 'asq_comment', '评论表', null, null, 'AsqComment', 'crud', 'com.ruoyi', 'comment', 'comment', '评论', 'zjh', '0', '/', '{\"parentMenuId\":\"2036\"}', 'admin', '2022-10-27 21:58:47', '', '2022-10-27 22:39:22', null);
INSERT INTO `gen_table` VALUES ('11', 'asq_topic', '话题表', '', '', 'AsqTopic', 'crud', 'com.ruoyi', 'topic', 'topic', '话题', 'zjh', '0', '/', '{\"parentMenuId\":2043}', 'admin', '2022-10-29 19:54:57', '', '2022-10-29 20:00:11', null);
INSERT INTO `gen_table` VALUES ('12', 'asq_chat', '用户聊天表\r\n', null, null, 'AsqChat', 'crud', 'com.ruoyi', 'chat', 'chat', '用户聊天', 'zjh', '0', '/', '{\"parentMenuId\":\"2051\"}', 'admin', '2023-04-19 17:27:31', '', '2023-04-19 17:32:58', null);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES ('14', '3', 'book_id', null, 'bigint(20)', 'Long', 'bookId', '1', '1', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2022-03-22 10:54:20', '', '2022-05-02 17:21:38');
INSERT INTO `gen_table_column` VALUES ('15', '3', 'book_writer_name', '书籍作者姓名', 'varchar(20)', 'String', 'bookWriterName', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2022-03-22 10:54:20', '', '2022-05-02 17:21:38');
INSERT INTO `gen_table_column` VALUES ('16', '3', 'book_name', '书籍名', 'varchar(20)', 'String', 'bookName', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '3', 'admin', '2022-03-22 10:54:20', '', '2022-05-02 17:21:38');
INSERT INTO `gen_table_column` VALUES ('17', '3', 'book_type', '书籍类型', 'varchar(20)', 'String', 'bookType', '0', '0', null, '1', '1', '1', '1', 'EQ', 'select', 'book_type', '4', 'admin', '2022-03-22 10:54:20', '', '2022-05-02 17:21:38');
INSERT INTO `gen_table_column` VALUES ('18', '3', 'book_pub_date', '出版日期', 'datetime', 'Date', 'bookPubDate', '0', '0', null, '1', '1', '1', '1', 'BETWEEN', 'datetime', '', '5', 'admin', '2022-03-22 10:54:20', '', '2022-05-02 17:21:38');
INSERT INTO `gen_table_column` VALUES ('19', '3', 'book_up_date', '上传日期', 'datetime', 'Date', 'bookUpDate', '0', '0', null, '1', '1', '1', '1', 'BETWEEN', 'datetime', '', '6', 'admin', '2022-03-22 10:54:20', '', '2022-05-02 17:21:38');
INSERT INTO `gen_table_column` VALUES ('20', '3', 'book_press', '出版社', 'varchar(20)', 'String', 'bookPress', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '7', 'admin', '2022-03-22 10:54:20', '', '2022-05-02 17:21:38');
INSERT INTO `gen_table_column` VALUES ('21', '3', 'book_cover', '书籍封面', 'varchar(255)', 'String', 'bookCover', '0', '0', null, '1', '1', '1', null, 'EQ', 'imageUpload', '', '8', 'admin', '2022-03-22 10:54:20', '', '2022-05-02 17:21:38');
INSERT INTO `gen_table_column` VALUES ('22', '4', 'writer_id', null, 'bigint(20)', 'Long', 'writerId', '1', '1', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2022-04-25 21:22:42', '', '2022-04-25 21:47:32');
INSERT INTO `gen_table_column` VALUES ('23', '4', 'writer_name', '作者姓名', 'varchar(20)', 'String', 'writerName', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2022-04-25 21:22:42', '', '2022-04-25 21:47:32');
INSERT INTO `gen_table_column` VALUES ('24', '4', 'writer_info', '作者详情', 'varchar(255)', 'String', 'writerInfo', '0', '0', null, '1', '1', '1', null, 'EQ', 'editor', '', '3', 'admin', '2022-04-25 21:22:42', '', '2022-04-25 21:47:32');
INSERT INTO `gen_table_column` VALUES ('25', '4', 'writer_intro', '作者座右铭', 'varchar(255)', 'String', 'writerIntro', '0', '0', null, '1', '1', '1', null, 'EQ', 'input', '', '4', 'admin', '2022-04-25 21:22:42', '', '2022-04-25 21:47:32');
INSERT INTO `gen_table_column` VALUES ('26', '4', 'writer_pic', '作者头像', 'varchar(255)', 'String', 'writerPic', '0', '0', null, '1', '1', '1', null, 'EQ', 'imageUpload', '', '5', 'admin', '2022-04-25 21:22:42', '', '2022-04-25 21:47:32');
INSERT INTO `gen_table_column` VALUES ('27', '3', 'book_pdf_url', '书籍pdf', 'varchar(255)', 'String', 'bookPdfUrl', '0', '0', null, '1', '1', '1', null, 'EQ', 'fileUpload', '', '9', '', '2022-05-02 17:01:49', '', '2022-05-02 17:21:38');
INSERT INTO `gen_table_column` VALUES ('28', '3', 'book_audit', '审核状态', 'int(6)', 'Integer', 'bookAudit', '0', '0', null, '1', '1', '1', '1', 'EQ', 'select', 'book_audit', '10', '', '2022-05-02 17:01:49', '', '2022-05-02 17:21:38');
INSERT INTO `gen_table_column` VALUES ('29', '5', 'ppt_id', 'ID', 'int(20)', 'Long', 'pptId', '1', '1', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2022-07-24 18:17:53', '', '2022-07-24 18:25:03');
INSERT INTO `gen_table_column` VALUES ('30', '5', 'ppt_name', '名称', 'varchar(50)', 'String', 'pptName', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2022-07-24 18:17:53', '', '2022-07-24 18:25:03');
INSERT INTO `gen_table_column` VALUES ('31', '5', 'ppt_pic', '图片', 'varchar(255)', 'String', 'pptPic', '0', '0', null, '1', '1', '1', null, 'EQ', 'imageUpload', '', '3', 'admin', '2022-07-24 18:17:53', '', '2022-07-24 18:25:03');
INSERT INTO `gen_table_column` VALUES ('32', '5', 'ppt_url', '跳转路径', 'varchar(255)', 'String', 'pptUrl', '0', '0', null, '1', '1', '1', null, 'EQ', 'input', '', '4', 'admin', '2022-07-24 18:17:53', '', '2022-07-24 18:25:03');
INSERT INTO `gen_table_column` VALUES ('33', '5', 'ppt_desc', '排序', 'int(20)', 'Long', 'pptDesc', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '5', 'admin', '2022-07-24 18:17:53', '', '2022-07-24 18:25:03');
INSERT INTO `gen_table_column` VALUES ('34', '5', 'ppt_type', '类型', 'int(20)', 'Long', 'pptType', '0', '0', null, '1', '1', '1', '1', 'EQ', 'select', 'ppt_type', '6', 'admin', '2022-07-24 18:17:53', '', '2022-07-24 18:25:03');
INSERT INTO `gen_table_column` VALUES ('35', '6', 'rank_parm_id', null, 'int(20)', 'Long', 'rankParmId', '1', '1', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2022-07-28 08:57:08', '', '2022-07-28 09:08:00');
INSERT INTO `gen_table_column` VALUES ('36', '6', 'book_id', '书籍id', 'int(20)', 'Long', 'bookId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2022-07-28 08:57:08', '', '2022-07-28 09:08:00');
INSERT INTO `gen_table_column` VALUES ('37', '6', 'read_num', '阅读数', 'int(255)', 'Long', 'readNum', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2022-07-28 08:57:08', '', '2022-07-28 09:08:00');
INSERT INTO `gen_table_column` VALUES ('38', '6', 'applaud_num', '赞同数', 'int(255)', 'Long', 'applaudNum', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2022-07-28 08:57:08', '', '2022-07-28 09:08:00');
INSERT INTO `gen_table_column` VALUES ('39', '6', 'comment_num', '评论数', 'int(255)', 'Long', 'commentNum', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '5', 'admin', '2022-07-28 08:57:08', '', '2022-07-28 09:08:00');
INSERT INTO `gen_table_column` VALUES ('40', '6', 'collect_num', '加入书架数', 'int(255)', 'Long', 'collectNum', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '6', 'admin', '2022-07-28 08:57:08', '', '2022-07-28 09:08:00');
INSERT INTO `gen_table_column` VALUES ('41', '7', 'applaud_id', null, 'int(20)', 'Long', 'applaudId', '1', '0', null, '1', null, null, '1', 'EQ', 'input', '', '1', 'admin', '2022-10-24 21:32:51', '', '2022-10-25 19:27:07');
INSERT INTO `gen_table_column` VALUES ('42', '7', 'user_id', '用户', 'int(20)', 'Long', 'userId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2022-10-24 21:32:51', '', '2022-10-25 19:27:07');
INSERT INTO `gen_table_column` VALUES ('43', '7', 'book_id', '书籍', 'int(20)', 'Long', 'bookId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2022-10-24 21:32:51', '', '2022-10-25 19:27:07');
INSERT INTO `gen_table_column` VALUES ('44', '7', 'cread_data', '创建时间', 'datetime', 'Date', 'creadData', '0', '0', null, '1', '1', '1', '1', 'EQ', 'datetime', '', '4', 'admin', '2022-10-24 21:32:51', '', '2022-10-25 19:27:07');
INSERT INTO `gen_table_column` VALUES ('49', '9', 'collect_id', null, 'int(20)', 'Long', 'collectId', '1', '1', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2022-10-26 19:28:56', '', '2022-10-26 19:29:31');
INSERT INTO `gen_table_column` VALUES ('50', '9', 'book_id', '书籍id', 'int(20)', 'Long', 'bookId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2022-10-26 19:28:56', '', '2022-10-26 19:29:31');
INSERT INTO `gen_table_column` VALUES ('51', '9', 'user_id', '用户id', 'int(20)', 'Long', 'userId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2022-10-26 19:28:56', '', '2022-10-26 19:29:31');
INSERT INTO `gen_table_column` VALUES ('52', '9', 'create_date', '创建时间', 'datetime', 'Date', 'createDate', '0', '0', null, '1', '1', '1', '1', 'EQ', 'datetime', '', '4', 'admin', '2022-10-26 19:28:56', '', '2022-10-26 19:29:31');
INSERT INTO `gen_table_column` VALUES ('53', '10', 'comment_id', null, 'int(20)', 'Long', 'commentId', '1', '1', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2022-10-27 21:58:47', '', '2022-10-27 22:39:22');
INSERT INTO `gen_table_column` VALUES ('54', '10', 'comment_parent_id', '父级id', 'int(20)', 'Long', 'commentParentId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2022-10-27 21:58:47', '', '2022-10-27 22:39:22');
INSERT INTO `gen_table_column` VALUES ('55', '10', 'user_id', '用户id', 'int(20)', 'Long', 'userId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2022-10-27 21:58:47', '', '2022-10-27 22:39:22');
INSERT INTO `gen_table_column` VALUES ('56', '10', 'com_body_id', '评论体', 'int(20)', 'Long', 'comBodyId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2022-10-27 21:58:47', '', '2022-10-27 22:39:22');
INSERT INTO `gen_table_column` VALUES ('57', '10', 'comment_text', '评论内容', 'varchar(255)', 'String', 'commentText', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '5', 'admin', '2022-10-27 21:58:47', '', '2022-10-27 22:39:22');
INSERT INTO `gen_table_column` VALUES ('58', '10', 'com_body_type', '评论主体类型，1书，2社区', 'int(1)', 'Integer', 'comBodyType', '0', '0', null, '1', '1', '1', '1', 'EQ', 'select', '', '6', 'admin', '2022-10-27 21:58:47', '', '2022-10-27 22:39:22');
INSERT INTO `gen_table_column` VALUES ('59', '10', 'create_date', '创建时间', 'datetime', 'Date', 'createDate', '0', '0', null, '1', '1', '1', '1', 'BETWEEN', 'datetime', '', '7', 'admin', '2022-10-27 21:58:47', '', '2022-10-27 22:39:23');
INSERT INTO `gen_table_column` VALUES ('61', '10', 'is_vio', '是否违规', 'int(1)', 'Integer', 'isVio', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '9', '', '2022-10-27 22:04:14', '', '2022-10-27 22:39:23');
INSERT INTO `gen_table_column` VALUES ('62', '10', 'like_num', '点赞数', 'int(20)', 'Long', 'likeNum', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '8', '', '2022-10-27 22:37:32', '', '2022-10-27 22:39:23');
INSERT INTO `gen_table_column` VALUES ('63', '11', 'topic_id', null, 'int(20)', 'Long', 'topicId', '1', '1', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2022-10-29 19:54:57', '', '2022-10-29 20:00:11');
INSERT INTO `gen_table_column` VALUES ('64', '11', 'user_id', null, 'int(20)', 'Long', 'userId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2022-10-29 19:54:57', '', '2022-10-29 20:00:11');
INSERT INTO `gen_table_column` VALUES ('65', '11', 'topic_content', '文章', 'text', 'String', 'topicContent', '0', '0', null, '1', '1', '1', null, 'EQ', 'editor', '', '3', 'admin', '2022-10-29 19:54:57', '', '2022-10-29 20:00:11');
INSERT INTO `gen_table_column` VALUES ('66', '11', 'topic_cover', '封面', 'varchar(255)', 'String', 'topicCover', '0', '0', null, '1', '1', '1', null, 'EQ', 'imageUpload', '', '4', 'admin', '2022-10-29 19:54:57', '', '2022-10-29 20:00:11');
INSERT INTO `gen_table_column` VALUES ('67', '11', 'topic_createdate', '发布时间', 'datetime', 'Date', 'topicCreatedate', '0', '0', null, '1', '1', '1', '1', 'BETWEEN', 'datetime', '', '5', 'admin', '2022-10-29 19:54:57', '', '2022-10-29 20:00:11');
INSERT INTO `gen_table_column` VALUES ('68', '11', 'topic_name', '话题', 'varchar(255)', 'String', 'topicName', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '3', '', '2022-10-29 19:58:14', '', '2022-10-29 20:00:11');
INSERT INTO `gen_table_column` VALUES ('69', '12', 'id', null, 'int(11)', 'Long', 'id', '1', '1', null, null, null, null, null, 'EQ', 'input', '', '1', 'admin', '2023-04-19 17:27:31', '', '2023-04-19 17:32:58');
INSERT INTO `gen_table_column` VALUES ('70', '12', 'user_id', '发送人id', 'int(64)', 'Long', 'userId', '0', '0', null, null, null, '1', '1', 'EQ', 'input', '', '2', 'admin', '2023-04-19 17:27:31', '', '2023-04-19 17:32:58');
INSERT INTO `gen_table_column` VALUES ('71', '12', 'from_id', '接收方id', 'int(64)', 'Long', 'fromId', '0', '0', null, null, null, '1', '1', 'EQ', 'input', '', '3', 'admin', '2023-04-19 17:27:31', '', '2023-04-19 17:32:58');
INSERT INTO `gen_table_column` VALUES ('72', '12', 'content', '聊天内容', 'text', 'String', 'content', '0', '0', null, null, null, '1', '1', 'EQ', 'textarea', '', '4', 'admin', '2023-04-19 17:27:31', '', '2023-04-19 17:32:58');
INSERT INTO `gen_table_column` VALUES ('73', '12', 'time', '聊天时间', 'datetime', 'Date', 'time', '0', '0', null, null, null, '1', '1', 'EQ', 'datetime', '', '5', 'admin', '2023-04-19 17:27:31', '', '2023-04-19 17:32:58');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('1', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2022-03-21 21:33:13', '', null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES ('2', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2022-03-21 21:33:13', '', null, '初始化密码 123456');
INSERT INTO `sys_config` VALUES ('3', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2022-03-21 21:33:13', '', null, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES ('4', '账号自助-验证码开关', 'sys.account.captchaOnOff', 'true', 'Y', 'admin', '2022-03-21 21:33:13', '', null, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES ('5', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2022-03-21 21:33:13', 'admin', '2022-05-02 18:10:14', '是否开启注册用户功能（true开启，false关闭）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('100', '0', '0', '拾柒科技', '0', 'liefox', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-03-21 21:33:12', '', null);
INSERT INTO `sys_dept` VALUES ('101', '100', '0,100', '南昌总公司', '1', 'liefox', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-03-21 21:33:12', 'admin', '2023-04-25 16:56:01');
INSERT INTO `sys_dept` VALUES ('102', '100', '0,100', '杭州分公司', '2', 'liefox', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-03-21 21:33:12', 'admin', '2023-04-25 16:55:52');
INSERT INTO `sys_dept` VALUES ('103', '101', '0,100,101', '研发部门', '1', 'liefox', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-03-21 21:33:12', '', null);
INSERT INTO `sys_dept` VALUES ('104', '101', '0,100,101', '市场部门', '2', 'liefox', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-03-21 21:33:12', '', null);
INSERT INTO `sys_dept` VALUES ('105', '101', '0,100,101', '测试部门', '3', 'liefox', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-03-21 21:33:12', '', null);
INSERT INTO `sys_dept` VALUES ('106', '101', '0,100,101', '财务部门', '4', 'liefox', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-03-21 21:33:12', '', null);
INSERT INTO `sys_dept` VALUES ('107', '101', '0,100,101', '运维部门', '5', 'liefox', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-03-21 21:33:12', '', null);
INSERT INTO `sys_dept` VALUES ('108', '102', '0,100,102', '市场部门', '1', 'liefox', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-03-21 21:33:12', '', null);
INSERT INTO `sys_dept` VALUES ('109', '102', '0,100,102', '财务部门', '2', 'liefox', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-03-21 21:33:12', '', null);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8 COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES ('1', '1', '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-03-21 21:33:13', '', null, '性别男');
INSERT INTO `sys_dict_data` VALUES ('2', '2', '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '性别女');
INSERT INTO `sys_dict_data` VALUES ('3', '3', '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '性别未知');
INSERT INTO `sys_dict_data` VALUES ('4', '1', '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-03-21 21:33:13', '', null, '显示菜单');
INSERT INTO `sys_dict_data` VALUES ('5', '2', '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES ('6', '1', '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-03-21 21:33:13', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('7', '2', '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('8', '1', '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2022-03-21 21:33:13', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('9', '2', '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('10', '1', '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2022-03-21 21:33:13', '', null, '默认分组');
INSERT INTO `sys_dict_data` VALUES ('11', '2', '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '系统分组');
INSERT INTO `sys_dict_data` VALUES ('12', '1', '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-03-21 21:33:13', '', null, '系统默认是');
INSERT INTO `sys_dict_data` VALUES ('13', '2', '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '系统默认否');
INSERT INTO `sys_dict_data` VALUES ('14', '1', '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-03-21 21:33:13', '', null, '通知');
INSERT INTO `sys_dict_data` VALUES ('15', '2', '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '公告');
INSERT INTO `sys_dict_data` VALUES ('16', '1', '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-03-21 21:33:13', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('17', '2', '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '关闭状态');
INSERT INTO `sys_dict_data` VALUES ('18', '1', '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '新增操作');
INSERT INTO `sys_dict_data` VALUES ('19', '2', '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '修改操作');
INSERT INTO `sys_dict_data` VALUES ('20', '3', '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '删除操作');
INSERT INTO `sys_dict_data` VALUES ('21', '4', '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '授权操作');
INSERT INTO `sys_dict_data` VALUES ('22', '5', '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '导出操作');
INSERT INTO `sys_dict_data` VALUES ('23', '6', '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '导入操作');
INSERT INTO `sys_dict_data` VALUES ('24', '7', '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '强退操作');
INSERT INTO `sys_dict_data` VALUES ('25', '8', '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '生成操作');
INSERT INTO `sys_dict_data` VALUES ('26', '9', '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '清空操作');
INSERT INTO `sys_dict_data` VALUES ('27', '1', '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('28', '2', '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-03-21 21:33:13', '', null, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('100', '0', '编程', '编程', 'book_type', null, 'success', 'N', '0', 'admin', '2022-03-22 09:13:22', 'admin', '2023-04-25 17:13:44', null);
INSERT INTO `sys_dict_data` VALUES ('101', '0', '社会', '社会', 'book_type', null, 'success', 'N', '0', 'admin', '2022-03-22 09:13:39', 'admin', '2023-04-25 17:14:46', null);
INSERT INTO `sys_dict_data` VALUES ('102', '0', '生活', '生活', 'book_type', null, 'success', 'N', '0', 'admin', '2022-03-22 09:13:55', 'admin', '2022-03-22 09:14:01', null);
INSERT INTO `sys_dict_data` VALUES ('103', '0', '待审核', '0', 'book_audit', null, 'warning', 'N', '0', 'admin', '2022-05-02 17:03:53', 'admin', '2022-05-02 18:30:21', null);
INSERT INTO `sys_dict_data` VALUES ('104', '0', '审核成功', '1', 'book_audit', null, 'success', 'N', '0', 'admin', '2022-05-02 17:04:03', 'admin', '2022-05-02 18:30:29', null);
INSERT INTO `sys_dict_data` VALUES ('105', '0', '审核失败', '2', 'book_audit', null, 'danger', 'N', '0', 'admin', '2022-05-02 17:04:13', 'admin', '2022-05-02 18:30:35', null);
INSERT INTO `sys_dict_data` VALUES ('106', '0', '书籍', '1', 'ppt_type', null, 'default', 'N', '0', 'admin', '2022-07-24 18:23:22', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('107', '0', '文章', '2', 'ppt_type', null, 'default', 'N', '0', 'admin', '2022-07-24 18:23:37', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('108', '0', '第三方', '3', 'ppt_type', null, 'default', 'N', '0', 'admin', '2022-07-24 18:23:45', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('109', '0', '学习', '学习', 'book_type', null, 'success', 'N', '0', 'admin', '2023-04-25 17:16:15', 'admin', '2023-04-25 17:16:30', null);
INSERT INTO `sys_dict_data` VALUES ('110', '0', '科幻', '科幻', 'book_type', null, 'success', 'N', '0', 'lei', '2023-04-25 17:30:01', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('113', '0', '游戏', '游戏', 'book_type', null, 'success', 'N', '0', 'lei', '2023-04-25 20:03:31', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('114', '0', '历史', '历史', 'book_type', null, 'success', 'N', '0', 'lei', '2023-04-25 20:11:43', '', null, null);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES ('1', '用户性别', 'sys_user_sex', '0', 'admin', '2022-03-21 21:33:13', '', null, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES ('2', '菜单状态', 'sys_show_hide', '0', 'admin', '2022-03-21 21:33:13', '', null, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES ('3', '系统开关', 'sys_normal_disable', '0', 'admin', '2022-03-21 21:33:13', '', null, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES ('4', '任务状态', 'sys_job_status', '0', 'admin', '2022-03-21 21:33:13', '', null, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES ('5', '任务分组', 'sys_job_group', '0', 'admin', '2022-03-21 21:33:13', '', null, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES ('6', '系统是否', 'sys_yes_no', '0', 'admin', '2022-03-21 21:33:13', '', null, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES ('7', '通知类型', 'sys_notice_type', '0', 'admin', '2022-03-21 21:33:13', '', null, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES ('8', '通知状态', 'sys_notice_status', '0', 'admin', '2022-03-21 21:33:13', '', null, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES ('9', '操作类型', 'sys_oper_type', '0', 'admin', '2022-03-21 21:33:13', '', null, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES ('10', '系统状态', 'sys_common_status', '0', 'admin', '2022-03-21 21:33:13', '', null, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES ('100', '书籍类型', 'book_type', '0', 'admin', '2022-03-22 09:12:42', '', null, null);
INSERT INTO `sys_dict_type` VALUES ('101', '书籍审核状态', 'book_audit', '0', 'admin', '2022-05-02 17:03:26', '', null, null);
INSERT INTO `sys_dict_type` VALUES ('102', '幻灯片类型', 'ppt_type', '0', 'admin', '2022-07-24 18:22:44', 'admin', '2022-07-24 18:22:56', null);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES ('1', '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2022-03-21 21:33:13', '', null, '');
INSERT INTO `sys_job` VALUES ('2', '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2022-03-21 21:33:13', '', null, '');
INSERT INTO `sys_job` VALUES ('3', '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2022-03-21 21:33:13', '', null, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` text DEFAULT NULL COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101089 DEFAULT CHARSET=utf8 COMMENT='系统访问记录';


-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(1) DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2058 DEFAULT CHARSET=utf8 COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '0', '1', 'system', null, '', '1', '0', 'M', '0', '0', '', 'system', 'admin', '2022-03-21 21:33:12', '', null, '系统管理目录');
INSERT INTO `sys_menu` VALUES ('2', '系统监控', '0', '2', 'monitor', null, '', '1', '0', 'M', '0', '0', '', 'monitor', 'admin', '2022-03-21 21:33:12', '', null, '系统监控目录');
INSERT INTO `sys_menu` VALUES ('3', '系统工具', '0', '3', 'tool', null, '', '1', '0', 'M', '0', '0', '', 'tool', 'admin', '2022-03-21 21:33:12', '', null, '系统工具目录');
INSERT INTO `sys_menu` VALUES ('4', 'liefox官网', '0', '1024', 'http://cxq21.gitee.io', null, '', '0', '0', 'M', '0', '0', '', 'guide', 'admin', '2022-03-21 21:33:12', 'admin', '2022-10-27 22:41:04', 'liefox官网地址');
INSERT INTO `sys_menu` VALUES ('100', '用户管理', '1', '1', 'user', 'system/user/index', '', '1', '0', 'C', '0', '0', 'system:user:list', 'user', 'admin', '2022-03-21 21:33:12', '', null, '用户管理菜单');
INSERT INTO `sys_menu` VALUES ('101', '角色管理', '1', '2', 'role', 'system/role/index', '', '1', '0', 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2022-03-21 21:33:12', '', null, '角色管理菜单');
INSERT INTO `sys_menu` VALUES ('102', '菜单管理', '1', '3', 'menu', 'system/menu/index', '', '1', '0', 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2022-03-21 21:33:12', '', null, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES ('103', '部门管理', '1', '4', 'dept', 'system/dept/index', '', '1', '0', 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2022-03-21 21:33:12', '', null, '部门管理菜单');
INSERT INTO `sys_menu` VALUES ('104', '岗位管理', '1', '5', 'post', 'system/post/index', '', '1', '0', 'C', '0', '0', 'system:post:list', 'post', 'admin', '2022-03-21 21:33:12', '', null, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES ('105', '字典管理', '1', '6', 'dict', 'system/dict/index', '', '1', '0', 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2022-03-21 21:33:12', '', null, '字典管理菜单');
INSERT INTO `sys_menu` VALUES ('106', '参数设置', '1', '7', 'config', 'system/config/index', '', '1', '0', 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2022-03-21 21:33:12', '', null, '参数设置菜单');
INSERT INTO `sys_menu` VALUES ('107', '通知公告', '1', '8', 'notice', 'system/notice/index', '', '1', '0', 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2022-03-21 21:33:12', '', null, '通知公告菜单');
INSERT INTO `sys_menu` VALUES ('108', '日志管理', '1', '9', 'log', '', '', '1', '0', 'M', '0', '0', '', 'log', 'admin', '2022-03-21 21:33:12', '', null, '日志管理菜单');
INSERT INTO `sys_menu` VALUES ('109', '在线用户', '2', '1', 'online', 'monitor/online/index', '', '1', '0', 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2022-03-21 21:33:12', '', null, '在线用户菜单');
INSERT INTO `sys_menu` VALUES ('110', '定时任务', '2', '2', 'job', 'monitor/job/index', '', '1', '0', 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2022-03-21 21:33:12', '', null, '定时任务菜单');
INSERT INTO `sys_menu` VALUES ('111', '数据监控', '2', '3', 'druid', 'monitor/druid/index', '', '1', '0', 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2022-03-21 21:33:12', '', null, '数据监控菜单');
INSERT INTO `sys_menu` VALUES ('112', '服务监控', '2', '4', 'server', 'monitor/server/index', '', '1', '0', 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2022-03-21 21:33:12', '', null, '服务监控菜单');
INSERT INTO `sys_menu` VALUES ('113', '缓存监控', '2', '5', 'cache', 'monitor/cache/index', '', '1', '0', 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2022-03-21 21:33:12', '', null, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES ('114', '表单构建', '3', '1', 'build', 'tool/build/index', '', '1', '0', 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2022-03-21 21:33:12', '', null, '表单构建菜单');
INSERT INTO `sys_menu` VALUES ('115', '代码生成', '3', '2', 'gen', 'tool/gen/index', '', '1', '0', 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2022-03-21 21:33:12', '', null, '代码生成菜单');
INSERT INTO `sys_menu` VALUES ('116', '系统接口', '3', '3', 'swagger', 'tool/swagger/index', '', '1', '0', 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2022-03-21 21:33:12', '', null, '系统接口菜单');
INSERT INTO `sys_menu` VALUES ('500', '操作日志', '108', '1', 'operlog', 'monitor/operlog/index', '', '1', '0', 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2022-03-21 21:33:12', '', null, '操作日志菜单');
INSERT INTO `sys_menu` VALUES ('501', '登录日志', '108', '2', 'logininfor', 'monitor/logininfor/index', '', '1', '0', 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2022-03-21 21:33:12', '', null, '登录日志菜单');
INSERT INTO `sys_menu` VALUES ('1001', '用户查询', '100', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:user:query', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1002', '用户新增', '100', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:user:add', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1003', '用户修改', '100', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:user:edit', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1004', '用户删除', '100', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:user:remove', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1005', '用户导出', '100', '5', '', '', '', '1', '0', 'F', '0', '0', 'system:user:export', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1006', '用户导入', '100', '6', '', '', '', '1', '0', 'F', '0', '0', 'system:user:import', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1007', '重置密码', '100', '7', '', '', '', '1', '0', 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1008', '角色查询', '101', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:role:query', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1009', '角色新增', '101', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:role:add', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1010', '角色修改', '101', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:role:edit', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1011', '角色删除', '101', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:role:remove', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1012', '角色导出', '101', '5', '', '', '', '1', '0', 'F', '0', '0', 'system:role:export', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1013', '菜单查询', '102', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:query', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1014', '菜单新增', '102', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:add', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1015', '菜单修改', '102', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1016', '菜单删除', '102', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1017', '部门查询', '103', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:query', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1018', '部门新增', '103', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:add', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1019', '部门修改', '103', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1020', '部门删除', '103', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1021', '岗位查询', '104', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:post:query', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1022', '岗位新增', '104', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:post:add', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1023', '岗位修改', '104', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:post:edit', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1024', '岗位删除', '104', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:post:remove', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1025', '岗位导出', '104', '5', '', '', '', '1', '0', 'F', '0', '0', 'system:post:export', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1026', '字典查询', '105', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:query', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1027', '字典新增', '105', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:add', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1028', '字典修改', '105', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1029', '字典删除', '105', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1030', '字典导出', '105', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:export', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1031', '参数查询', '106', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:query', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1032', '参数新增', '106', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:add', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1033', '参数修改', '106', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:edit', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1034', '参数删除', '106', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:remove', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1035', '参数导出', '106', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:export', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1036', '公告查询', '107', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:query', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1037', '公告新增', '107', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:add', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1038', '公告修改', '107', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1039', '公告删除', '107', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1040', '操作查询', '500', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1041', '操作删除', '500', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1042', '日志导出', '500', '4', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1043', '登录查询', '501', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1044', '登录删除', '501', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1045', '日志导出', '501', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1046', '在线查询', '109', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1047', '批量强退', '109', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1048', '单条强退', '109', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1049', '任务查询', '110', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1050', '任务新增', '110', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1051', '任务修改', '110', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1052', '任务删除', '110', '4', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1053', '状态修改', '110', '5', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1054', '任务导出', '110', '7', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1055', '生成查询', '115', '1', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1056', '生成修改', '115', '2', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1057', '生成删除', '115', '3', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1058', '导入代码', '115', '2', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1059', '预览代码', '115', '4', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('1060', '生成代码', '115', '5', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_menu` VALUES ('2016', '图书管理', '2051', '1', 'books', 'bookM/books/index', null, '1', '1', 'C', '0', '0', 'bookM:books:list', 'education', 'admin', '2022-03-22 15:49:34', 'admin', '2023-04-19 17:19:48', '图书管理菜单');
INSERT INTO `sys_menu` VALUES ('2017', '图书管理查询', '2016', '1', '#', '', null, '1', '0', 'F', '0', '0', 'bookM:books:query', '#', 'admin', '2022-03-22 15:49:34', '', null, '');
INSERT INTO `sys_menu` VALUES ('2018', '图书管理新增', '2016', '2', '#', '', null, '1', '0', 'F', '0', '0', 'bookM:books:add', '#', 'admin', '2022-03-22 15:49:34', '', null, '');
INSERT INTO `sys_menu` VALUES ('2019', '图书管理修改', '2016', '3', '#', '', null, '1', '0', 'F', '0', '0', 'bookM:books:edit', '#', 'admin', '2022-03-22 15:49:34', '', null, '');
INSERT INTO `sys_menu` VALUES ('2020', '图书管理删除', '2016', '4', '#', '', null, '1', '0', 'F', '0', '0', 'bookM:books:remove', '#', 'admin', '2022-03-22 15:49:34', '', null, '');
INSERT INTO `sys_menu` VALUES ('2021', '图书管理导出', '2016', '5', '#', '', null, '1', '0', 'F', '0', '0', 'bookM:books:export', '#', 'admin', '2022-03-22 15:49:34', '', null, '');
INSERT INTO `sys_menu` VALUES ('2023', '作者管理', '2051', '1', 'writer', 'writer/writer/index', null, '1', '0', 'C', '0', '0', 'writer:writer:list', 'user', 'admin', '2022-04-25 21:28:35', 'admin', '2023-04-19 17:20:51', '作者管理菜单');
INSERT INTO `sys_menu` VALUES ('2024', '作者管理查询', '2023', '1', '#', '', null, '1', '0', 'F', '0', '0', 'writer:writer:query', '#', 'admin', '2022-04-25 21:28:36', '', null, '');
INSERT INTO `sys_menu` VALUES ('2025', '作者管理新增', '2023', '2', '#', '', null, '1', '0', 'F', '0', '0', 'writer:writer:add', '#', 'admin', '2022-04-25 21:28:37', '', null, '');
INSERT INTO `sys_menu` VALUES ('2026', '作者管理修改', '2023', '3', '#', '', null, '1', '0', 'F', '0', '0', 'writer:writer:edit', '#', 'admin', '2022-04-25 21:28:37', '', null, '');
INSERT INTO `sys_menu` VALUES ('2027', '作者管理删除', '2023', '4', '#', '', null, '1', '0', 'F', '0', '0', 'writer:writer:remove', '#', 'admin', '2022-04-25 21:28:37', '', null, '');
INSERT INTO `sys_menu` VALUES ('2028', '作者管理导出', '2023', '5', '#', '', null, '1', '0', 'F', '0', '0', 'writer:writer:export', '#', 'admin', '2022-04-25 21:28:38', '', null, '');
INSERT INTO `sys_menu` VALUES ('2030', '前台幻灯片管理', '2051', '1', 'ppt', 'ppt/ppt/index', null, '1', '0', 'C', '0', '0', 'ppt:ppt:list', 'row', 'admin', '2022-07-24 18:28:30', 'admin', '2023-04-19 17:22:01', '前台首页幻灯片菜单');
INSERT INTO `sys_menu` VALUES ('2031', '前台首页幻灯片查询', '2030', '1', '#', '', null, '1', '0', 'F', '0', '0', 'ppt:ppt:query', '#', 'admin', '2022-07-24 18:28:41', '', null, '');
INSERT INTO `sys_menu` VALUES ('2032', '前台首页幻灯片新增', '2030', '2', '#', '', null, '1', '0', 'F', '0', '0', 'ppt:ppt:add', '#', 'admin', '2022-07-24 18:28:44', '', null, '');
INSERT INTO `sys_menu` VALUES ('2033', '前台首页幻灯片修改', '2030', '3', '#', '', null, '1', '0', 'F', '0', '0', 'ppt:ppt:edit', '#', 'admin', '2022-07-24 18:28:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('2034', '前台首页幻灯片删除', '2030', '4', '#', '', null, '1', '0', 'F', '0', '0', 'ppt:ppt:remove', '#', 'admin', '2022-07-24 18:28:51', '', null, '');
INSERT INTO `sys_menu` VALUES ('2035', '前台首页幻灯片导出', '2030', '5', '#', '', null, '1', '0', 'F', '0', '0', 'ppt:ppt:export', '#', 'admin', '2022-07-24 18:28:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('2037', '图书/话题评论管理', '2051', '1', 'comment', 'comment/comment/index', null, '1', '0', 'C', '0', '0', 'comment:comment:list', 'message', 'admin', '2022-10-27 22:08:45', 'admin', '2023-04-19 17:23:45', '评论菜单');
INSERT INTO `sys_menu` VALUES ('2038', '评论查询', '2037', '1', '#', '', null, '1', '0', 'F', '0', '0', 'comment:comment:query', '#', 'admin', '2022-10-27 22:08:45', '', null, '');
INSERT INTO `sys_menu` VALUES ('2039', '评论新增', '2037', '2', '#', '', null, '1', '0', 'F', '0', '0', 'comment:comment:add', '#', 'admin', '2022-10-27 22:08:45', '', null, '');
INSERT INTO `sys_menu` VALUES ('2040', '评论修改', '2037', '3', '#', '', null, '1', '0', 'F', '0', '0', 'comment:comment:edit', '#', 'admin', '2022-10-27 22:08:45', '', null, '');
INSERT INTO `sys_menu` VALUES ('2041', '评论删除', '2037', '4', '#', '', null, '1', '0', 'F', '0', '0', 'comment:comment:remove', '#', 'admin', '2022-10-27 22:08:45', '', null, '');
INSERT INTO `sys_menu` VALUES ('2042', '评论导出', '2037', '5', '#', '', null, '1', '0', 'F', '0', '0', 'comment:comment:export', '#', 'admin', '2022-10-27 22:08:45', '', null, '');
INSERT INTO `sys_menu` VALUES ('2044', '社区话题管理', '2051', '1', 'topic', 'topic/topic/index', null, '1', '0', 'C', '0', '0', 'topic:topic:list', 'clipboard', 'admin', '2022-10-29 20:01:23', 'admin', '2023-04-19 17:22:55', '话题菜单');
INSERT INTO `sys_menu` VALUES ('2045', '话题查询', '2044', '1', '#', '', null, '1', '0', 'F', '0', '0', 'topic:topic:query', '#', 'admin', '2022-10-29 20:01:23', '', null, '');
INSERT INTO `sys_menu` VALUES ('2046', '话题新增', '2044', '2', '#', '', null, '1', '0', 'F', '0', '0', 'topic:topic:add', '#', 'admin', '2022-10-29 20:01:23', '', null, '');
INSERT INTO `sys_menu` VALUES ('2047', '话题修改', '2044', '3', '#', '', null, '1', '0', 'F', '0', '0', 'topic:topic:edit', '#', 'admin', '2022-10-29 20:01:23', '', null, '');
INSERT INTO `sys_menu` VALUES ('2048', '话题删除', '2044', '4', '#', '', null, '1', '0', 'F', '0', '0', 'topic:topic:remove', '#', 'admin', '2022-10-29 20:01:23', '', null, '');
INSERT INTO `sys_menu` VALUES ('2049', '话题导出', '2044', '5', '#', '', null, '1', '0', 'F', '0', '0', 'topic:topic:export', '#', 'admin', '2022-10-29 20:01:23', '', null, '');
INSERT INTO `sys_menu` VALUES ('2050', '拾柒爱阅读', '0', '1024', '/cms/main/cmsIndex', null, null, '1', '0', 'M', '0', '0', '', 'education', 'admin', '2023-04-19 17:11:06', 'admin', '2023-04-19 17:17:20', '');
INSERT INTO `sys_menu` VALUES ('2051', '图书社区管理', '0', '4', 'front', null, null, '1', '0', 'M', '0', '0', '', 'server', 'admin', '2023-04-19 17:12:52', 'admin', '2023-04-19 17:18:24', '');
INSERT INTO `sys_menu` VALUES ('2052', '用户聊天', '2051', '1', 'chat', 'chat/chat/index', null, '1', '0', 'C', '0', '0', 'chat:chat:list', 'peoples', 'admin', '2023-04-19 17:34:18', 'admin', '2023-04-19 18:01:55', '用户聊天菜单');
INSERT INTO `sys_menu` VALUES ('2053', '用户聊天查询', '2052', '1', '#', '', null, '1', '0', 'F', '0', '0', 'chat:chat:query', '#', 'admin', '2023-04-19 17:34:18', '', null, '');
INSERT INTO `sys_menu` VALUES ('2054', '用户聊天新增', '2052', '2', '#', '', null, '1', '0', 'F', '0', '0', 'chat:chat:add', '#', 'admin', '2023-04-19 17:34:18', '', null, '');
INSERT INTO `sys_menu` VALUES ('2055', '用户聊天修改', '2052', '3', '#', '', null, '1', '0', 'F', '0', '0', 'chat:chat:edit', '#', 'admin', '2023-04-19 17:34:18', '', null, '');
INSERT INTO `sys_menu` VALUES ('2056', '用户聊天删除', '2052', '4', '#', '', null, '1', '0', 'F', '0', '0', 'chat:chat:remove', '#', 'admin', '2023-04-19 17:34:18', '', null, '');
INSERT INTO `sys_menu` VALUES ('2057', '用户聊天导出', '2052', '5', '#', '', null, '1', '0', 'F', '0', '0', 'chat:chat:export', '#', 'admin', '2023-04-19 17:34:18', '', null, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob DEFAULT NULL COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES ('1', '温馨提醒：2018-07-01 liefox新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2022-03-21 21:33:13', '', null, '管理员');
INSERT INTO `sys_notice` VALUES ('2', '维护通知：2018-07-01 liefox系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2022-03-21 21:33:13', '', null, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int(1) DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=901 DEFAULT CHARSET=utf8 COMMENT='操作日志记录';

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES ('1', 'ceo', '董事长', '1', '0', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_post` VALUES ('2', 'se', '项目经理', '2', '0', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_post` VALUES ('3', 'hr', '人力资源', '3', '0', 'admin', '2022-03-21 21:33:12', '', null, '');
INSERT INTO `sys_post` VALUES ('4', 'user', '普通员工', '4', '0', 'admin', '2022-03-21 21:33:12', '', null, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 'admin', '1', '1', '1', '1', '0', '0', 'admin', '2022-03-21 21:33:12', '', null, '超级管理员');
INSERT INTO `sys_role` VALUES ('2', '普通角色', 'common', '2', '2', '1', '1', '0', '0', 'admin', '2022-03-21 21:33:12', '', null, '普通角色');
INSERT INTO `sys_role` VALUES ('3', '管理员', 'administrator', '0', '1', '1', '1', '0', '0', 'admin', '2023-04-25 16:51:40', '', null, null);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES ('2', '100');
INSERT INTO `sys_role_dept` VALUES ('2', '101');
INSERT INTO `sys_role_dept` VALUES ('2', '105');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('2', '1');
INSERT INTO `sys_role_menu` VALUES ('2', '2');
INSERT INTO `sys_role_menu` VALUES ('2', '3');
INSERT INTO `sys_role_menu` VALUES ('2', '4');
INSERT INTO `sys_role_menu` VALUES ('2', '100');
INSERT INTO `sys_role_menu` VALUES ('2', '101');
INSERT INTO `sys_role_menu` VALUES ('2', '102');
INSERT INTO `sys_role_menu` VALUES ('2', '103');
INSERT INTO `sys_role_menu` VALUES ('2', '104');
INSERT INTO `sys_role_menu` VALUES ('2', '105');
INSERT INTO `sys_role_menu` VALUES ('2', '106');
INSERT INTO `sys_role_menu` VALUES ('2', '107');
INSERT INTO `sys_role_menu` VALUES ('2', '108');
INSERT INTO `sys_role_menu` VALUES ('2', '109');
INSERT INTO `sys_role_menu` VALUES ('2', '110');
INSERT INTO `sys_role_menu` VALUES ('2', '111');
INSERT INTO `sys_role_menu` VALUES ('2', '112');
INSERT INTO `sys_role_menu` VALUES ('2', '113');
INSERT INTO `sys_role_menu` VALUES ('2', '114');
INSERT INTO `sys_role_menu` VALUES ('2', '115');
INSERT INTO `sys_role_menu` VALUES ('2', '116');
INSERT INTO `sys_role_menu` VALUES ('2', '500');
INSERT INTO `sys_role_menu` VALUES ('2', '501');
INSERT INTO `sys_role_menu` VALUES ('2', '1000');
INSERT INTO `sys_role_menu` VALUES ('2', '1001');
INSERT INTO `sys_role_menu` VALUES ('2', '1002');
INSERT INTO `sys_role_menu` VALUES ('2', '1003');
INSERT INTO `sys_role_menu` VALUES ('2', '1004');
INSERT INTO `sys_role_menu` VALUES ('2', '1005');
INSERT INTO `sys_role_menu` VALUES ('2', '1006');
INSERT INTO `sys_role_menu` VALUES ('2', '1007');
INSERT INTO `sys_role_menu` VALUES ('2', '1008');
INSERT INTO `sys_role_menu` VALUES ('2', '1009');
INSERT INTO `sys_role_menu` VALUES ('2', '1010');
INSERT INTO `sys_role_menu` VALUES ('2', '1011');
INSERT INTO `sys_role_menu` VALUES ('2', '1012');
INSERT INTO `sys_role_menu` VALUES ('2', '1013');
INSERT INTO `sys_role_menu` VALUES ('2', '1014');
INSERT INTO `sys_role_menu` VALUES ('2', '1015');
INSERT INTO `sys_role_menu` VALUES ('2', '1016');
INSERT INTO `sys_role_menu` VALUES ('2', '1017');
INSERT INTO `sys_role_menu` VALUES ('2', '1018');
INSERT INTO `sys_role_menu` VALUES ('2', '1019');
INSERT INTO `sys_role_menu` VALUES ('2', '1020');
INSERT INTO `sys_role_menu` VALUES ('2', '1021');
INSERT INTO `sys_role_menu` VALUES ('2', '1022');
INSERT INTO `sys_role_menu` VALUES ('2', '1023');
INSERT INTO `sys_role_menu` VALUES ('2', '1024');
INSERT INTO `sys_role_menu` VALUES ('2', '1025');
INSERT INTO `sys_role_menu` VALUES ('2', '1026');
INSERT INTO `sys_role_menu` VALUES ('2', '1027');
INSERT INTO `sys_role_menu` VALUES ('2', '1028');
INSERT INTO `sys_role_menu` VALUES ('2', '1029');
INSERT INTO `sys_role_menu` VALUES ('2', '1030');
INSERT INTO `sys_role_menu` VALUES ('2', '1031');
INSERT INTO `sys_role_menu` VALUES ('2', '1032');
INSERT INTO `sys_role_menu` VALUES ('2', '1033');
INSERT INTO `sys_role_menu` VALUES ('2', '1034');
INSERT INTO `sys_role_menu` VALUES ('2', '1035');
INSERT INTO `sys_role_menu` VALUES ('2', '1036');
INSERT INTO `sys_role_menu` VALUES ('2', '1037');
INSERT INTO `sys_role_menu` VALUES ('2', '1038');
INSERT INTO `sys_role_menu` VALUES ('2', '1039');
INSERT INTO `sys_role_menu` VALUES ('2', '1040');
INSERT INTO `sys_role_menu` VALUES ('2', '1041');
INSERT INTO `sys_role_menu` VALUES ('2', '1042');
INSERT INTO `sys_role_menu` VALUES ('2', '1043');
INSERT INTO `sys_role_menu` VALUES ('2', '1044');
INSERT INTO `sys_role_menu` VALUES ('2', '1045');
INSERT INTO `sys_role_menu` VALUES ('2', '1046');
INSERT INTO `sys_role_menu` VALUES ('2', '1047');
INSERT INTO `sys_role_menu` VALUES ('2', '1048');
INSERT INTO `sys_role_menu` VALUES ('2', '1049');
INSERT INTO `sys_role_menu` VALUES ('2', '1050');
INSERT INTO `sys_role_menu` VALUES ('2', '1051');
INSERT INTO `sys_role_menu` VALUES ('2', '1052');
INSERT INTO `sys_role_menu` VALUES ('2', '1053');
INSERT INTO `sys_role_menu` VALUES ('2', '1054');
INSERT INTO `sys_role_menu` VALUES ('2', '1055');
INSERT INTO `sys_role_menu` VALUES ('2', '1056');
INSERT INTO `sys_role_menu` VALUES ('2', '1057');
INSERT INTO `sys_role_menu` VALUES ('2', '1058');
INSERT INTO `sys_role_menu` VALUES ('2', '1059');
INSERT INTO `sys_role_menu` VALUES ('2', '1060');
INSERT INTO `sys_role_menu` VALUES ('3', '1');
INSERT INTO `sys_role_menu` VALUES ('3', '2');
INSERT INTO `sys_role_menu` VALUES ('3', '3');
INSERT INTO `sys_role_menu` VALUES ('3', '4');
INSERT INTO `sys_role_menu` VALUES ('3', '100');
INSERT INTO `sys_role_menu` VALUES ('3', '101');
INSERT INTO `sys_role_menu` VALUES ('3', '102');
INSERT INTO `sys_role_menu` VALUES ('3', '103');
INSERT INTO `sys_role_menu` VALUES ('3', '104');
INSERT INTO `sys_role_menu` VALUES ('3', '105');
INSERT INTO `sys_role_menu` VALUES ('3', '106');
INSERT INTO `sys_role_menu` VALUES ('3', '107');
INSERT INTO `sys_role_menu` VALUES ('3', '108');
INSERT INTO `sys_role_menu` VALUES ('3', '109');
INSERT INTO `sys_role_menu` VALUES ('3', '110');
INSERT INTO `sys_role_menu` VALUES ('3', '111');
INSERT INTO `sys_role_menu` VALUES ('3', '112');
INSERT INTO `sys_role_menu` VALUES ('3', '113');
INSERT INTO `sys_role_menu` VALUES ('3', '114');
INSERT INTO `sys_role_menu` VALUES ('3', '115');
INSERT INTO `sys_role_menu` VALUES ('3', '116');
INSERT INTO `sys_role_menu` VALUES ('3', '500');
INSERT INTO `sys_role_menu` VALUES ('3', '501');
INSERT INTO `sys_role_menu` VALUES ('3', '1001');
INSERT INTO `sys_role_menu` VALUES ('3', '1002');
INSERT INTO `sys_role_menu` VALUES ('3', '1003');
INSERT INTO `sys_role_menu` VALUES ('3', '1004');
INSERT INTO `sys_role_menu` VALUES ('3', '1005');
INSERT INTO `sys_role_menu` VALUES ('3', '1006');
INSERT INTO `sys_role_menu` VALUES ('3', '1007');
INSERT INTO `sys_role_menu` VALUES ('3', '1008');
INSERT INTO `sys_role_menu` VALUES ('3', '1009');
INSERT INTO `sys_role_menu` VALUES ('3', '1010');
INSERT INTO `sys_role_menu` VALUES ('3', '1011');
INSERT INTO `sys_role_menu` VALUES ('3', '1012');
INSERT INTO `sys_role_menu` VALUES ('3', '1013');
INSERT INTO `sys_role_menu` VALUES ('3', '1014');
INSERT INTO `sys_role_menu` VALUES ('3', '1015');
INSERT INTO `sys_role_menu` VALUES ('3', '1016');
INSERT INTO `sys_role_menu` VALUES ('3', '1017');
INSERT INTO `sys_role_menu` VALUES ('3', '1018');
INSERT INTO `sys_role_menu` VALUES ('3', '1019');
INSERT INTO `sys_role_menu` VALUES ('3', '1020');
INSERT INTO `sys_role_menu` VALUES ('3', '1021');
INSERT INTO `sys_role_menu` VALUES ('3', '1022');
INSERT INTO `sys_role_menu` VALUES ('3', '1023');
INSERT INTO `sys_role_menu` VALUES ('3', '1024');
INSERT INTO `sys_role_menu` VALUES ('3', '1025');
INSERT INTO `sys_role_menu` VALUES ('3', '1026');
INSERT INTO `sys_role_menu` VALUES ('3', '1027');
INSERT INTO `sys_role_menu` VALUES ('3', '1028');
INSERT INTO `sys_role_menu` VALUES ('3', '1029');
INSERT INTO `sys_role_menu` VALUES ('3', '1030');
INSERT INTO `sys_role_menu` VALUES ('3', '1031');
INSERT INTO `sys_role_menu` VALUES ('3', '1032');
INSERT INTO `sys_role_menu` VALUES ('3', '1033');
INSERT INTO `sys_role_menu` VALUES ('3', '1034');
INSERT INTO `sys_role_menu` VALUES ('3', '1035');
INSERT INTO `sys_role_menu` VALUES ('3', '1036');
INSERT INTO `sys_role_menu` VALUES ('3', '1037');
INSERT INTO `sys_role_menu` VALUES ('3', '1038');
INSERT INTO `sys_role_menu` VALUES ('3', '1039');
INSERT INTO `sys_role_menu` VALUES ('3', '1040');
INSERT INTO `sys_role_menu` VALUES ('3', '1041');
INSERT INTO `sys_role_menu` VALUES ('3', '1042');
INSERT INTO `sys_role_menu` VALUES ('3', '1043');
INSERT INTO `sys_role_menu` VALUES ('3', '1044');
INSERT INTO `sys_role_menu` VALUES ('3', '1045');
INSERT INTO `sys_role_menu` VALUES ('3', '1046');
INSERT INTO `sys_role_menu` VALUES ('3', '1047');
INSERT INTO `sys_role_menu` VALUES ('3', '1048');
INSERT INTO `sys_role_menu` VALUES ('3', '1049');
INSERT INTO `sys_role_menu` VALUES ('3', '1050');
INSERT INTO `sys_role_menu` VALUES ('3', '1051');
INSERT INTO `sys_role_menu` VALUES ('3', '1052');
INSERT INTO `sys_role_menu` VALUES ('3', '1053');
INSERT INTO `sys_role_menu` VALUES ('3', '1054');
INSERT INTO `sys_role_menu` VALUES ('3', '1055');
INSERT INTO `sys_role_menu` VALUES ('3', '1056');
INSERT INTO `sys_role_menu` VALUES ('3', '1057');
INSERT INTO `sys_role_menu` VALUES ('3', '1058');
INSERT INTO `sys_role_menu` VALUES ('3', '1059');
INSERT INTO `sys_role_menu` VALUES ('3', '1060');
INSERT INTO `sys_role_menu` VALUES ('3', '2016');
INSERT INTO `sys_role_menu` VALUES ('3', '2017');
INSERT INTO `sys_role_menu` VALUES ('3', '2018');
INSERT INTO `sys_role_menu` VALUES ('3', '2019');
INSERT INTO `sys_role_menu` VALUES ('3', '2020');
INSERT INTO `sys_role_menu` VALUES ('3', '2021');
INSERT INTO `sys_role_menu` VALUES ('3', '2023');
INSERT INTO `sys_role_menu` VALUES ('3', '2024');
INSERT INTO `sys_role_menu` VALUES ('3', '2025');
INSERT INTO `sys_role_menu` VALUES ('3', '2026');
INSERT INTO `sys_role_menu` VALUES ('3', '2027');
INSERT INTO `sys_role_menu` VALUES ('3', '2028');
INSERT INTO `sys_role_menu` VALUES ('3', '2030');
INSERT INTO `sys_role_menu` VALUES ('3', '2031');
INSERT INTO `sys_role_menu` VALUES ('3', '2032');
INSERT INTO `sys_role_menu` VALUES ('3', '2033');
INSERT INTO `sys_role_menu` VALUES ('3', '2034');
INSERT INTO `sys_role_menu` VALUES ('3', '2035');
INSERT INTO `sys_role_menu` VALUES ('3', '2037');
INSERT INTO `sys_role_menu` VALUES ('3', '2038');
INSERT INTO `sys_role_menu` VALUES ('3', '2039');
INSERT INTO `sys_role_menu` VALUES ('3', '2040');
INSERT INTO `sys_role_menu` VALUES ('3', '2041');
INSERT INTO `sys_role_menu` VALUES ('3', '2042');
INSERT INTO `sys_role_menu` VALUES ('3', '2044');
INSERT INTO `sys_role_menu` VALUES ('3', '2045');
INSERT INTO `sys_role_menu` VALUES ('3', '2046');
INSERT INTO `sys_role_menu` VALUES ('3', '2047');
INSERT INTO `sys_role_menu` VALUES ('3', '2048');
INSERT INTO `sys_role_menu` VALUES ('3', '2049');
INSERT INTO `sys_role_menu` VALUES ('3', '2050');
INSERT INTO `sys_role_menu` VALUES ('3', '2051');
INSERT INTO `sys_role_menu` VALUES ('3', '2052');
INSERT INTO `sys_role_menu` VALUES ('3', '2053');
INSERT INTO `sys_role_menu` VALUES ('3', '2054');
INSERT INTO `sys_role_menu` VALUES ('3', '2055');
INSERT INTO `sys_role_menu` VALUES ('3', '2056');
INSERT INTO `sys_role_menu` VALUES ('3', '2057');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '103', 'admin', 'liefox', '00', 'liefox@163.com', '15888888888', '1', '/profile/avatar/2023/05/04/95c46fc8-717a-483b-ba00-ba10613cea78.jpeg', '$2a$10$839iHXrjvBimMbxpQng.KOyXrziQSSRbt4KH/HWTLMSoqQw503.MG', '0', '0', '223.104.170.136', '2023-05-04 14:31:26', 'admin', '2022-03-21 21:33:12', '', '2023-05-04 14:31:26', '管理员');
INSERT INTO `sys_user` VALUES ('3', null, 'dev', 'dev', '00', '', '', '0', '/profile/avatar/2023/05/04/95c46fc8-717a-483b-ba00-ba10613cea78.jpeg', '$2a$10$eDeIfvIKlma9IvrVZ1P5GePxt6WPpJL3W3XnfpJ7fEmkzW0OPUaH6', '0', '0', '127.0.0.1', '2023-04-25 12:36:04', '', '2022-05-03 08:00:06', '', '2023-04-25 12:36:03', null);
INSERT INTO `sys_user` VALUES ('4', null, 'lei', '泡面拌饭', '00', '', '', '0', '/profile/avatar/2023/05/04/95c46fc8-717a-483b-ba00-ba10613cea78.jpeg', '$2a$10$3ZDCuWVFI9rPgNWPb5p3L.qCVxS87RResQ1r.tWGAmWZNUMRECN.q', '0', '0', '182.102.211.164', '2023-04-25 19:27:06', '', '2022-07-24 16:23:06', 'admin', '2023-04-25 19:27:05', null);
INSERT INTO `sys_user` VALUES ('5', null, 'l_lixu123', 'l_lixu123', '00', '', '', '0', '/profile/avatar/2023/05/04/95c46fc8-717a-483b-ba00-ba10613cea78.jpeg', '$2a$10$xmR.WfD.2eUAXSjSrbvCQujO.VEdoJn70/lFoyYCwyVUEiP9RKfDC', '0', '0', '117.136.57.179', '2023-04-25 20:32:22', '', '2023-04-25 20:30:20', '', '2023-04-25 20:32:21', null);
INSERT INTO `sys_user` VALUES ('6', null, 'lis', 'lis', '00', '', '', '0', '/profile/avatar/2023/05/04/95c46fc8-717a-483b-ba00-ba10613cea78.jpeg', '$2a$10$Pz.h9ectJNTVIeEeLI1zO.hiMAZGwnRMYB/eQwNc7qg8hijf11pUe', '0', '0', '220.197.163.72', '2023-04-25 20:34:28', '', '2023-04-25 20:34:09', '', '2023-04-25 20:34:27', null);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES ('1', '1');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('4', '3');
