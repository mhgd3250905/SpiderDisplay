const List<String> BOOK_LIST_IMG_URL_ARR = [
  "https://img.huxiucdn.com/article/cover/201812/07/084721455216.jpg?imageView2/1/w/400/h/225/|imageMogr2/strip/interlace/1/quality/85/format/jpg",
  "https://img.huxiucdn.com/article/cover/201907/01/123053984071.jpg?imageView2/1/w/400/h/225/|imageMogr2/strip/interlace/1/quality/85/format/jpg",
  "https://img.huxiucdn.com/article/cover/201907/01/121034837698.jpg?imageView2/1/w/400/h/225/|imageMogr2/strip/interlace/1/quality/85/format/jpg",
  "https://img.huxiucdn.com/article/cover/201907/01/115511134445.jpg?imageView2/1/w/400/h/225/|imageMogr2/strip/interlace/1/quality/85/format/jpg",
  "https://img.huxiucdn.com/article/cover/201907/01/113756189521.jpg?imageView2/1/w/400/h/225/|imageMogr2/strip/interlace/1/quality/85/format/jpg",
];

const String BOOK_LIST_JSON_STR = '''
{
    "err_code": 0,
    "error": "",
    "data": [
        {
            "title": "时间的礼物",
            "author": "[瑞典] 弗雷德里克·巴克曼",
            "time": "2019年1月1日",
            "image": "https://bookset.me/cover/s29951659.jpg",
            "douban_score": 7.5,
            "double_score_c_ount": 2786,
            "douban_link": "https://book.douban.com/subject/30390651/",
            "introduction": "【内容简介】世间的一切都有标价，除了时间，一秒就是一秒，谁都无法讨价还价。于是我总在出差，把生命中的每分每秒都贡献给工作，因为我坚信创造财富才是时间的正经归宿。45岁时，我成为一个有事业和资本的成功人士，但妻子和儿子离开了我。癌症将我送进医院，一周前，我认识了隔壁 病房的五岁女孩。她用蜡笔给椅子涂颜色，用牛奶盒做恐龙、给兔子玩偶讲故事，都是为了安慰妈妈和来看望她的人不要难过。死亡一天天临近，女孩却一如既往期待妈妈讲睡前故事，期待上学，期待着明年的生日会。她偷偷告诉我，穿白大褂的外星人会来治好她的病。她让我想起自己的儿子，以及那些我没有为他做的事情。死神要来带走女孩的那天晚上，我的心像被撕开了一个大口子，我向死神提出用我的命换女孩的命，但死神还要求抹去我在世间的一切痕迹。过去的45年，从父母的儿子，到儿子的父亲，我是如何度过的？一次对过往的清...",
            "download_link_epub": "http://download.bookset.me/d.php?f=2019/1/%5B瑞典%5D-弗雷德里克·巴克曼-时间的礼物-9787201142821.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2019/1/%5B瑞典%5D-弗雷德里克·巴克曼-时间的礼物-9787201142821.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2019/1/%5B瑞典%5D-弗雷德里克·巴克曼-时间的礼物-9787201142821.mobi"
        },
        {
            "title": "屠夫十字镇",
            "author": "[美] 约翰·威廉斯",
            "time": "2016年7月1日",
            "image": "https://bookset.me/cover/s28712182.jpg",
            "douban_score": 8.4,
            "double_score_c_ount": 1881,
            "douban_link": "https://book.douban.com/subject/26765928/",
            "introduction": "◆《斯通纳》作者约翰•威廉斯另一绝佳作品。一部年轻人带着寻找美好、摆脱庸俗日常生活的冲动，去旷野探寻世界源头的小说。一个关于寻找与梦想，信念、信仰和仪式，生存与改变的故事。◆《屠夫十字镇》比《斯通纳》更想了解世界的真实。它们同是一个有关面对无意义事物的坚忍，有关天真所致失败的故事。与坚守信念的斯通纳不同，这是一个带着激情、对未知充满好奇的年轻人，渴望寻求真实的世界：他所相信的，不是爱默生和梭罗等人的信念，而是相信背后的看见——除了旷野与经历，没有什么比内心的冲动更真诚、更迷人。同时，他在某种意义上又与斯通纳相同，他们做到了自我的实现。也许，我们每个人身上都有这样的冲动、激情，也造就了如今的自己。◆对年轻人的心灵进行的深入思索。作者约翰•威廉斯说，当一个从哈佛辍学的年轻人，来到西部看到了自然，看到了旷野的真实面貌，对他来说，会发生什么呢？这就是小说...",
            "download_link_epub": "http://download.bookset.me/d.php?f=2016/7/%5B美%5D-约翰·威廉斯-屠夫十字镇-9787208137189.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2016/7/%5B美%5D-约翰·威廉斯-屠夫十字镇-9787208137189.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2016/7/%5B美%5D-约翰·威廉斯-屠夫十字镇-9787208137189.mobi"
        },
        {
            "title": "我怎样毁了我的一生",
            "author": "[法] 贝尔当·桑帝尼 文",
            "time": "2011年1月1日",
            "image": "https://bookset.me/cover/s6380450.jpg",
            "douban_score": 8.4,
            "double_score_c_ount": 12569,
            "douban_link": "https://book.douban.com/subject/5366275/",
            "introduction": "一个男人言简意赅描写了自己的人生，长大之前他英俊、应有尽有、从不寂寞，堪称上帝的宠儿，长大之后他丑陋、贫穷、虚伪，过着谎话连篇和庸俗不堪的生活，他是怎样毁了自己的一生呢？成功和失败、幸福和悲哀，一段有如过山车般的人生。成功的标准是什么？怎样的人生又应该被定义为“失败”呢？一则简练而深刻的人生寓言。",
            "download_link_epub": "http://download.bookset.me/d.php?f=2011/1/%5B法%5D-贝尔当·桑帝尼-文-我怎样毁了我的一生-9787108035226.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2011/1/%5B法%5D-贝尔当·桑帝尼-文-我怎样毁了我的一生-9787108035226.mobi",
            "download_link_mobi": ""
        },
        {
            "title": "反套路",
            "author": "（美）大卫·迪萨沃",
            "time": "2019年4月19日",
            "image": "https://bookset.me/cover/s32297388.jpg",
            "douban_score": 8.5,
            "double_score_c_ount": 14,
            "douban_link": "https://book.douban.com/subject/33407293/",
            "introduction": "学点反套路，少走10年弯路。很多时候，大脑可能会成为我们的敌人。它会导致你陷入察觉不到的偏见、混乱和误区，容易被他人影响——也就是被“套路”，从而犯错。•很多时候，大脑会偷懒，不假思索地做出错误的决定。•你的记忆很容易就会被改变，一张照片就会让你想起很多根本不存在的事情。•在说话的过程中，比喻会以你想象不到的速度改变你对事物的看法。•遇到限时抢购的时候，明明自己并没有需求，却觉得不买就对不起自己。•手持一杯热饮，比一杯冷饮更容易产生亲和力；喝了一杯甜饮的人比喝白水的人更愿意原谅别人；算数学题时，拿着重物，更容易给出更高的估值。…………心理学家、跨界科学家大卫•迪萨沃为你揭示日常生活中存在的思维套路，用科学的方法帮你彻底掌控自己的人生！",
            "download_link_epub": "http://download.bookset.me/d.php?f=2019/4/（美）大卫·迪萨沃-反套路-9787559627452.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2019/4/（美）大卫·迪萨沃-反套路-9787559627452.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2019/4/（美）大卫·迪萨沃-反套路-9787559627452.mobi"
        },
        {
            "title": "启示录",
            "author": "[美] Marty Cagan",
            "time": "2011年5月1日",
            "image": "https://bookset.me/cover/s6474670.jpg",
            "douban_score": 8.5,
            "double_score_c_ount": 5852,
            "douban_link": "https://book.douban.com/subject/5914587/",
            "introduction": "为什么市场上那么多软件产品无人问津，成功的产品凤毛麟角？怎样发掘有价值的产品？拿什么说服开发团队接受你的产品设计？如何将敏捷方法融入产品开发？过去二十多年，Marty Cagan作为高级产品经理人为多家一流企业工作过，包括惠普、网景、美国在线、eBay。他亲历了个人电脑 、互联网、 电子商务的起落沉浮。《启示录：打造用户喜爱的产品》从人员、流程、产品三个角度介绍了现代软件（互联网）产品管理的实践经验和理念。七印部落正在翻译作者的博客和授课视频，欢迎访问微博：http://weibo.com/7seals-“Marty无疑是eBay最出色的产品经理，他对eBay的影响至今仍在。”— Frerk-Malte FellereBay德国区常务董事-“Marty是产品管理的行家里手。这本书如醍醐灌顶，让我茅塞顿开。”— Judy Gibbons...",
            "download_link_epub": "http://download.bookset.me/d.php?f=2011/5/%5B美%5D-Marty-Cagan-启示录-9787560970189.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2011/5/%5B美%5D-Marty-Cagan-启示录-9787560970189.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2011/5/%5B美%5D-Marty-Cagan-启示录-9787560970189.mobi"
        },
        {
            "title": "樱桃的滋味",
            "author": "[伊朗] 阿巴斯·基阿鲁斯达米",
            "time": "2017年9月1日",
            "image": "https://bookset.me/cover/s29529538.jpg",
            "douban_score": 9.3,
            "double_score_c_ount": 784,
            "douban_link": "https://book.douban.com/subject/27091427/",
            "introduction": "阿巴斯是伊朗新浪潮电影开创者、诗意电影大师，一生拍摄了22部电影，受到黑泽明、戈达尔等电影巨匠的一致推崇。1997年，阿巴斯凭借《樱桃的滋味》获得戛纳电影节金棕榈奖，之后《何处是我朋友家》《橄榄树下的情人》《随风而逝》等作品均获国际大奖。阿巴斯的电影，用镜头凝视平凡人世，纯粹、简朴的故事给人以*单纯的感动。影像风格简洁而富有诗意，洋溢着人文情怀与哲学思考。《樱桃的滋味》是阿巴斯一生导演历程的珍贵总结，详尽而深刻地呈现了阿巴斯的艺术观和人生观，是一部兼具实用价值与美学价值的电影沉思录。",
            "download_link_epub": "http://download.bookset.me/d.php?f=2017/9/%5B伊朗%5D-阿巴斯·基阿鲁斯达米-樱桃的滋味-9787508676982.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2017/9/%5B伊朗%5D-阿巴斯·基阿鲁斯达米-樱桃的滋味-9787508676982.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2017/9/%5B伊朗%5D-阿巴斯·基阿鲁斯达米-樱桃的滋味-9787508676982.mobi"
        },
        {
            "title": "时间的礼物",
            "author": "[瑞典] 弗雷德里克·巴克曼",
            "time": "2019年1月1日",
            "image": "https://bookset.me/cover/s29951659.jpg",
            "douban_score": 7.5,
            "double_score_c_ount": 2786,
            "douban_link": "https://book.douban.com/subject/30390651/",
            "introduction": "【内容简介】世间的一切都有标价，除了时间，一秒就是一秒，谁都无法讨价还价。于是我总在出差，把生命中的每分每秒都贡献给工作，因为我坚信创造财富才是时间的正经归宿。45岁时，我成为一个有事业和资本的成功人士，但妻子和儿子离开了我。癌症将我送进医院，一周前，我认识了隔壁 病房的五岁女孩。她用蜡笔给椅子涂颜色，用牛奶盒做恐龙、给兔子玩偶讲故事，都是为了安慰妈妈和来看望她的人不要难过。死亡一天天临近，女孩却一如既往期待妈妈讲睡前故事，期待上学，期待着明年的生日会。她偷偷告诉我，穿白大褂的外星人会来治好她的病。她让我想起自己的儿子，以及那些我没有为他做的事情。死神要来带走女孩的那天晚上，我的心像被撕开了一个大口子，我向死神提出用我的命换女孩的命，但死神还要求抹去我在世间的一切痕迹。过去的45年，从父母的儿子，到儿子的父亲，我是如何度过的？一次对过往的清...",
            "download_link_epub": "http://download.bookset.me/d.php?f=2019/1/%5B瑞典%5D-弗雷德里克·巴克曼-时间的礼物-9787201142821.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2019/1/%5B瑞典%5D-弗雷德里克·巴克曼-时间的礼物-9787201142821.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2019/1/%5B瑞典%5D-弗雷德里克·巴克曼-时间的礼物-9787201142821.mobi"
        },
        {
            "title": "屠夫十字镇",
            "author": "[美] 约翰·威廉斯",
            "time": "2016年7月1日",
            "image": "https://bookset.me/cover/s28712182.jpg",
            "douban_score": 8.4,
            "double_score_c_ount": 1881,
            "douban_link": "https://book.douban.com/subject/26765928/",
            "introduction": "◆《斯通纳》作者约翰•威廉斯另一绝佳作品。一部年轻人带着寻找美好、摆脱庸俗日常生活的冲动，去旷野探寻世界源头的小说。一个关于寻找与梦想，信念、信仰和仪式，生存与改变的故事。◆《屠夫十字镇》比《斯通纳》更想了解世界的真实。它们同是一个有关面对无意义事物的坚忍，有关天真所致失败的故事。与坚守信念的斯通纳不同，这是一个带着激情、对未知充满好奇的年轻人，渴望寻求真实的世界：他所相信的，不是爱默生和梭罗等人的信念，而是相信背后的看见——除了旷野与经历，没有什么比内心的冲动更真诚、更迷人。同时，他在某种意义上又与斯通纳相同，他们做到了自我的实现。也许，我们每个人身上都有这样的冲动、激情，也造就了如今的自己。◆对年轻人的心灵进行的深入思索。作者约翰•威廉斯说，当一个从哈佛辍学的年轻人，来到西部看到了自然，看到了旷野的真实面貌，对他来说，会发生什么呢？这就是小说...",
            "download_link_epub": "http://download.bookset.me/d.php?f=2016/7/%5B美%5D-约翰·威廉斯-屠夫十字镇-9787208137189.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2016/7/%5B美%5D-约翰·威廉斯-屠夫十字镇-9787208137189.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2016/7/%5B美%5D-约翰·威廉斯-屠夫十字镇-9787208137189.mobi"
        },
        {
            "title": "我怎样毁了我的一生",
            "author": "[法] 贝尔当·桑帝尼 文",
            "time": "2011年1月1日",
            "image": "https://bookset.me/cover/s6380450.jpg",
            "douban_score": 8.4,
            "double_score_c_ount": 12569,
            "douban_link": "https://book.douban.com/subject/5366275/",
            "introduction": "一个男人言简意赅描写了自己的人生，长大之前他英俊、应有尽有、从不寂寞，堪称上帝的宠儿，长大之后他丑陋、贫穷、虚伪，过着谎话连篇和庸俗不堪的生活，他是怎样毁了自己的一生呢？成功和失败、幸福和悲哀，一段有如过山车般的人生。成功的标准是什么？怎样的人生又应该被定义为“失败”呢？一则简练而深刻的人生寓言。",
            "download_link_epub": "http://download.bookset.me/d.php?f=2011/1/%5B法%5D-贝尔当·桑帝尼-文-我怎样毁了我的一生-9787108035226.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2011/1/%5B法%5D-贝尔当·桑帝尼-文-我怎样毁了我的一生-9787108035226.mobi",
            "download_link_mobi": ""
        },
        {
            "title": "反套路",
            "author": "（美）大卫·迪萨沃",
            "time": "2019年4月19日",
            "image": "https://bookset.me/cover/s32297388.jpg",
            "douban_score": 8.5,
            "double_score_c_ount": 14,
            "douban_link": "https://book.douban.com/subject/33407293/",
            "introduction": "学点反套路，少走10年弯路。很多时候，大脑可能会成为我们的敌人。它会导致你陷入察觉不到的偏见、混乱和误区，容易被他人影响——也就是被“套路”，从而犯错。•很多时候，大脑会偷懒，不假思索地做出错误的决定。•你的记忆很容易就会被改变，一张照片就会让你想起很多根本不存在的事情。•在说话的过程中，比喻会以你想象不到的速度改变你对事物的看法。•遇到限时抢购的时候，明明自己并没有需求，却觉得不买就对不起自己。•手持一杯热饮，比一杯冷饮更容易产生亲和力；喝了一杯甜饮的人比喝白水的人更愿意原谅别人；算数学题时，拿着重物，更容易给出更高的估值。…………心理学家、跨界科学家大卫•迪萨沃为你揭示日常生活中存在的思维套路，用科学的方法帮你彻底掌控自己的人生！",
            "download_link_epub": "http://download.bookset.me/d.php?f=2019/4/（美）大卫·迪萨沃-反套路-9787559627452.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2019/4/（美）大卫·迪萨沃-反套路-9787559627452.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2019/4/（美）大卫·迪萨沃-反套路-9787559627452.mobi"
        },
        {
            "title": "启示录",
            "author": "[美] Marty Cagan",
            "time": "2011年5月1日",
            "image": "https://bookset.me/cover/s6474670.jpg",
            "douban_score": 8.5,
            "double_score_c_ount": 5852,
            "douban_link": "https://book.douban.com/subject/5914587/",
            "introduction": "为什么市场上那么多软件产品无人问津，成功的产品凤毛麟角？怎样发掘有价值的产品？拿什么说服开发团队接受你的产品设计？如何将敏捷方法融入产品开发？过去二十多年，Marty Cagan作为高级产品经理人为多家一流企业工作过，包括惠普、网景、美国在线、eBay。他亲历了个人电脑 、互联网、 电子商务的起落沉浮。《启示录：打造用户喜爱的产品》从人员、流程、产品三个角度介绍了现代软件（互联网）产品管理的实践经验和理念。七印部落正在翻译作者的博客和授课视频，欢迎访问微博：http://weibo.com/7seals-“Marty无疑是eBay最出色的产品经理，他对eBay的影响至今仍在。”— Frerk-Malte FellereBay德国区常务董事-“Marty是产品管理的行家里手。这本书如醍醐灌顶，让我茅塞顿开。”— Judy Gibbons...",
            "download_link_epub": "http://download.bookset.me/d.php?f=2011/5/%5B美%5D-Marty-Cagan-启示录-9787560970189.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2011/5/%5B美%5D-Marty-Cagan-启示录-9787560970189.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2011/5/%5B美%5D-Marty-Cagan-启示录-9787560970189.mobi"
        },
        {
            "title": "樱桃的滋味",
            "author": "[伊朗] 阿巴斯·基阿鲁斯达米",
            "time": "2017年9月1日",
            "image": "https://bookset.me/cover/s29529538.jpg",
            "douban_score": 9.3,
            "double_score_c_ount": 784,
            "douban_link": "https://book.douban.com/subject/27091427/",
            "introduction": "阿巴斯是伊朗新浪潮电影开创者、诗意电影大师，一生拍摄了22部电影，受到黑泽明、戈达尔等电影巨匠的一致推崇。1997年，阿巴斯凭借《樱桃的滋味》获得戛纳电影节金棕榈奖，之后《何处是我朋友家》《橄榄树下的情人》《随风而逝》等作品均获国际大奖。阿巴斯的电影，用镜头凝视平凡人世，纯粹、简朴的故事给人以*单纯的感动。影像风格简洁而富有诗意，洋溢着人文情怀与哲学思考。《樱桃的滋味》是阿巴斯一生导演历程的珍贵总结，详尽而深刻地呈现了阿巴斯的艺术观和人生观，是一部兼具实用价值与美学价值的电影沉思录。",
            "download_link_epub": "http://download.bookset.me/d.php?f=2017/9/%5B伊朗%5D-阿巴斯·基阿鲁斯达米-樱桃的滋味-9787508676982.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2017/9/%5B伊朗%5D-阿巴斯·基阿鲁斯达米-樱桃的滋味-9787508676982.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2017/9/%5B伊朗%5D-阿巴斯·基阿鲁斯达米-樱桃的滋味-9787508676982.mobi"
        }
    ]
}
''';

const String BOOK_DETAIL_JSON_STR = '''{
    "err_code": 0,
    "error": "",
    "data": [
        {
            "title": "时间的礼物",
            "author": "[瑞典] 弗雷德里克·巴克曼",
            "time": "2019年1月1日",
            "image": "https://bookset.me/cover/s29951659.jpg",
            "douban_score": 7.5,
            "double_score_c_ount": 2786,
            "douban_link": "https://book.douban.com/subject/30390651/",
            "introduction": "【内容简介】世间的一切都有标价，除了时间，一秒就是一秒，谁都无法讨价还价。于是我总在出差，把生命中的每分每秒都贡献给工作，因为我坚信创造财富才是时间的正经归宿。45岁时，我成为一个有事业和资本的成功人士，但妻子和儿子离开了我。癌症将我送进医院，一周前，我认识了隔壁 病房的五岁女孩。她用蜡笔给椅子涂颜色，用牛奶盒做恐龙、给兔子玩偶讲故事，都是为了安慰妈妈和来看望她的人不要难过。死亡一天天临近，女孩却一如既往期待妈妈讲睡前故事，期待上学，期待着明年的生日会。她偷偷告诉我，穿白大褂的外星人会来治好她的病。她让我想起自己的儿子，以及那些我没有为他做的事情。死神要来带走女孩的那天晚上，我的心像被撕开了一个大口子，我向死神提出用我的命换女孩的命，但死神还要求抹去我在世间的一切痕迹。过去的45年，从父母的儿子，到儿子的父亲，我是如何度过的？一次对过往的清...",
            "download_link_epub": "http://download.bookset.me/d.php?f=2019/1/%5B瑞典%5D-弗雷德里克·巴克曼-时间的礼物-9787201142821.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2019/1/%5B瑞典%5D-弗雷德里克·巴克曼-时间的礼物-9787201142821.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2019/1/%5B瑞典%5D-弗雷德里克·巴克曼-时间的礼物-9787201142821.mobi"
        },
        {
            "title": "屠夫十字镇",
            "author": "[美] 约翰·威廉斯",
            "time": "2016年7月1日",
            "image": "https://bookset.me/cover/s28712182.jpg",
            "douban_score": 8.4,
            "double_score_c_ount": 1881,
            "douban_link": "https://book.douban.com/subject/26765928/",
            "introduction": "◆《斯通纳》作者约翰•威廉斯另一绝佳作品。一部年轻人带着寻找美好、摆脱庸俗日常生活的冲动，去旷野探寻世界源头的小说。一个关于寻找与梦想，信念、信仰和仪式，生存与改变的故事。◆《屠夫十字镇》比《斯通纳》更想了解世界的真实。它们同是一个有关面对无意义事物的坚忍，有关天真所致失败的故事。与坚守信念的斯通纳不同，这是一个带着激情、对未知充满好奇的年轻人，渴望寻求真实的世界：他所相信的，不是爱默生和梭罗等人的信念，而是相信背后的看见——除了旷野与经历，没有什么比内心的冲动更真诚、更迷人。同时，他在某种意义上又与斯通纳相同，他们做到了自我的实现。也许，我们每个人身上都有这样的冲动、激情，也造就了如今的自己。◆对年轻人的心灵进行的深入思索。作者约翰•威廉斯说，当一个从哈佛辍学的年轻人，来到西部看到了自然，看到了旷野的真实面貌，对他来说，会发生什么呢？这就是小说...",
            "download_link_epub": "http://download.bookset.me/d.php?f=2016/7/%5B美%5D-约翰·威廉斯-屠夫十字镇-9787208137189.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2016/7/%5B美%5D-约翰·威廉斯-屠夫十字镇-9787208137189.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2016/7/%5B美%5D-约翰·威廉斯-屠夫十字镇-9787208137189.mobi"
        },
        {
            "title": "我怎样毁了我的一生",
            "author": "[法] 贝尔当·桑帝尼 文",
            "time": "2011年1月1日",
            "image": "https://bookset.me/cover/s6380450.jpg",
            "douban_score": 8.4,
            "double_score_c_ount": 12569,
            "douban_link": "https://book.douban.com/subject/5366275/",
            "introduction": "一个男人言简意赅描写了自己的人生，长大之前他英俊、应有尽有、从不寂寞，堪称上帝的宠儿，长大之后他丑陋、贫穷、虚伪，过着谎话连篇和庸俗不堪的生活，他是怎样毁了自己的一生呢？成功和失败、幸福和悲哀，一段有如过山车般的人生。成功的标准是什么？怎样的人生又应该被定义为“失败”呢？一则简练而深刻的人生寓言。",
            "download_link_epub": "http://download.bookset.me/d.php?f=2011/1/%5B法%5D-贝尔当·桑帝尼-文-我怎样毁了我的一生-9787108035226.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2011/1/%5B法%5D-贝尔当·桑帝尼-文-我怎样毁了我的一生-9787108035226.mobi",
            "download_link_mobi": ""
        },
        {
            "title": "反套路",
            "author": "（美）大卫·迪萨沃",
            "time": "2019年4月19日",
            "image": "https://bookset.me/cover/s32297388.jpg",
            "douban_score": 8.5,
            "double_score_c_ount": 14,
            "douban_link": "https://book.douban.com/subject/33407293/",
            "introduction": "学点反套路，少走10年弯路。很多时候，大脑可能会成为我们的敌人。它会导致你陷入察觉不到的偏见、混乱和误区，容易被他人影响——也就是被“套路”，从而犯错。•很多时候，大脑会偷懒，不假思索地做出错误的决定。•你的记忆很容易就会被改变，一张照片就会让你想起很多根本不存在的事情。•在说话的过程中，比喻会以你想象不到的速度改变你对事物的看法。•遇到限时抢购的时候，明明自己并没有需求，却觉得不买就对不起自己。•手持一杯热饮，比一杯冷饮更容易产生亲和力；喝了一杯甜饮的人比喝白水的人更愿意原谅别人；算数学题时，拿着重物，更容易给出更高的估值。…………心理学家、跨界科学家大卫•迪萨沃为你揭示日常生活中存在的思维套路，用科学的方法帮你彻底掌控自己的人生！",
            "download_link_epub": "http://download.bookset.me/d.php?f=2019/4/（美）大卫·迪萨沃-反套路-9787559627452.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2019/4/（美）大卫·迪萨沃-反套路-9787559627452.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2019/4/（美）大卫·迪萨沃-反套路-9787559627452.mobi"
        },
        {
            "title": "启示录",
            "author": "[美] Marty Cagan",
            "time": "2011年5月1日",
            "image": "https://bookset.me/cover/s6474670.jpg",
            "douban_score": 8.5,
            "double_score_c_ount": 5852,
            "douban_link": "https://book.douban.com/subject/5914587/",
            "introduction": "为什么市场上那么多软件产品无人问津，成功的产品凤毛麟角？怎样发掘有价值的产品？拿什么说服开发团队接受你的产品设计？如何将敏捷方法融入产品开发？过去二十多年，Marty Cagan作为高级产品经理人为多家一流企业工作过，包括惠普、网景、美国在线、eBay。他亲历了个人电脑 、互联网、 电子商务的起落沉浮。《启示录：打造用户喜爱的产品》从人员、流程、产品三个角度介绍了现代软件（互联网）产品管理的实践经验和理念。七印部落正在翻译作者的博客和授课视频，欢迎访问微博：http://weibo.com/7seals-“Marty无疑是eBay最出色的产品经理，他对eBay的影响至今仍在。”— Frerk-Malte FellereBay德国区常务董事-“Marty是产品管理的行家里手。这本书如醍醐灌顶，让我茅塞顿开。”— Judy Gibbons...",
            "download_link_epub": "http://download.bookset.me/d.php?f=2011/5/%5B美%5D-Marty-Cagan-启示录-9787560970189.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2011/5/%5B美%5D-Marty-Cagan-启示录-9787560970189.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2011/5/%5B美%5D-Marty-Cagan-启示录-9787560970189.mobi"
        },
        {
            "title": "樱桃的滋味",
            "author": "[伊朗] 阿巴斯·基阿鲁斯达米",
            "time": "2017年9月1日",
            "image": "https://bookset.me/cover/s29529538.jpg",
            "douban_score": 9.3,
            "double_score_c_ount": 784,
            "douban_link": "https://book.douban.com/subject/27091427/",
            "introduction": "阿巴斯是伊朗新浪潮电影开创者、诗意电影大师，一生拍摄了22部电影，受到黑泽明、戈达尔等电影巨匠的一致推崇。1997年，阿巴斯凭借《樱桃的滋味》获得戛纳电影节金棕榈奖，之后《何处是我朋友家》《橄榄树下的情人》《随风而逝》等作品均获国际大奖。阿巴斯的电影，用镜头凝视平凡人世，纯粹、简朴的故事给人以*单纯的感动。影像风格简洁而富有诗意，洋溢着人文情怀与哲学思考。《樱桃的滋味》是阿巴斯一生导演历程的珍贵总结，详尽而深刻地呈现了阿巴斯的艺术观和人生观，是一部兼具实用价值与美学价值的电影沉思录。",
            "download_link_epub": "http://download.bookset.me/d.php?f=2017/9/%5B伊朗%5D-阿巴斯·基阿鲁斯达米-樱桃的滋味-9787508676982.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2017/9/%5B伊朗%5D-阿巴斯·基阿鲁斯达米-樱桃的滋味-9787508676982.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2017/9/%5B伊朗%5D-阿巴斯·基阿鲁斯达米-樱桃的滋味-9787508676982.mobi"
        },
        {
            "title": "打字机上的缪斯",
            "author": "[英]杰西·波顿",
            "time": "2019年5月1日",
            "image": "https://bookset.me/cover/s32299374.jpg",
            "douban_score": 8.7,
            "double_score_c_ount": 60,
            "douban_link": "https://book.douban.com/subject/33402237/",
            "introduction": "►即使每天不被理解一百次，我也要做自己喜欢的事！ ◄-►►►内容简介◄◄◄1幅画，2封信，3个女人，跨越30年的梦想……热爱写作的奥黛尔，来到梦想中的伦敦，却只能做个卖鞋女孩。她的写作梦想，被现实搁浅了整整五年，直到她收到了一个女人的来信……时间倒转回到三十年前，天 赋异禀的奥利芙来到西班牙度假。她早已收到应该艺术学院的录取信，却没有告诉任何人。但正是在这里，奥利芙坚定了自己一生的梦想。一幅神秘画作，两封改变人生的信件，串联起她们跨越三十年的梦想，也让这三个女人的命运紧密联系在了一起。-►►►编辑推荐◄◄◄►感动30国读者的年度暖心大作《打字机上的缪斯》！►稳居英国图书销售总榜，仅英国销量两年已突破50万册！►《出版人周刊》《书单》《卫报》等28家重磅媒体暖心推荐！►《打字机上的缪斯》是英国《星期日泰晤士报》畅销书、《纽约时报...",
            "download_link_epub": "http://download.bookset.me/d.php?f=2019/5/%5B英%5D杰西·波顿-打字机上的缪斯-9787532171187.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2019/5/%5B英%5D杰西·波顿-打字机上的缪斯-9787532171187.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2019/5/%5B英%5D杰西·波顿-打字机上的缪斯-9787532171187.mobi"
        },
        {
            "title": "时间旅行者的妻子",
            "author": "[美] 奥德丽·尼芬格",
            "time": "2007年4月1日",
            "image": "https://bookset.me/cover/s2375756.jpg",
            "douban_score": 8.1,
            "double_score_c_ount": 38382,
            "douban_link": "https://book.douban.com/subject/2056749/",
            "introduction": "相遇那年，她6岁，他36岁；结婚那年，她23岁，他31岁；离别后再度重逢时，她82岁，他43岁。相对于如此真实、强烈的感觉，时间，微不足道……亨利，一位年轻帅气、爱冒险的图书管理员，可是他有慢性时间错位症，会不知不觉地游离在时间之间。克莱尔，亨利的妻子，一位生活秩序很规律的艺术家。亨利以为他在28岁时第一次遇到他20岁的妻子克莱尔，而克莱尔却说：“我从小就认识你了”。和克莱尔结婚多年的亨利，却又突然发现自己回到了童年，遇见了他6岁的妻子。如果生命是一场旅行，亨利的旅程肯定比常人更迂回更深刻，那些不由自主地消失，不得不一再体验曾经遭受的经历，他只能旁观、重复品味着那些快乐、悲伤和痛苦。可是在时间的正常旅途中行走的克莱尔呢？她只能被亨利远远抛在了后面，渴望，焦急，等着爱人回到她的身边。她虽然拥有时间，却只能通过捉摸亨利来触摸时间。时间过滤...",
            "download_link_epub": "http://download.bookset.me/d.php?f=2007/4/%5B美%5D-奥德丽·尼芬格-时间旅行者的妻子-9787020060504.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2007/4/%5B美%5D-奥德丽·尼芬格-时间旅行者的妻子-9787020060504.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2007/4/%5B美%5D-奥德丽·尼芬格-时间旅行者的妻子-9787020060504.mobi"
        },
        {
            "title": "单向度的人",
            "author": "(美)赫伯特·马尔库塞",
            "time": "2006年4月1日",
            "image": "https://bookset.me/cover/s1659154.jpg",
            "douban_score": 8.5,
            "double_score_c_ount": 2134,
            "douban_link": "https://book.douban.com/subject/1787729/",
            "introduction": "赫伯特·尔库塞（Herbert Marcuse，1898-1979）是法兰克福学派左翼主要代表人物，本书是其最负盛名的著作，旨在揭示当代发达工业社会型的极权主义特征。此书在英国和美国出版后，先后在德国和法国出德文版和法文版，其后又译成多种文字在许多国家出版，被称为西方6 0年代末大学造反运动的教科书.全书除导言外包括“单向度社会”、“单向度的思想”和“进行替代性选择的机会”三部分。作者通过对政治、生活、思想、文化、语言等领域的分析、批判，指出发达工业社会是如何成功地压制了人们内心中的否定性、批判性、超越性的向度，使这个社会成为单向度的社会，而生活于其中的人成了单向度的人，这种人丧失了自由和创造力，不再想像或追求与现实生活不同的另一种生活。本书对现代资本主义社会作了较为深刻的揭露和探索，但暴露出其社会批判理论的乌托邦性质。本书对研究兰克福学派和马尔库...",
            "download_link_epub": "http://download.bookset.me/d.php?f=2006/4/(美)赫伯特·马尔库塞-单向度的人-9787532739103.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2006/4/(美)赫伯特·马尔库塞-单向度的人-9787532739103.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2006/4/(美)赫伯特·马尔库塞-单向度的人-9787532739103.mobi"
        },
        {
            "title": "事物的味道，我尝得太早了",
            "author": "[日] 石川啄木",
            "time": "2016年5月1日",
            "image": "https://bookset.me/cover/s28685720.jpg",
            "douban_score": 8.6,
            "double_score_c_ount": 3676,
            "douban_link": "https://book.douban.com/subject/26759579/",
            "introduction": "全书收录了石川啄木的四 部小集子。《一握砂》包含551首短歌，《可悲的玩具》包含194首短歌，这两部歌集诚恳地记录了诗人在贫病生活中的哀思和叹息。《叫子和口哨》为石川啄木创作的6首现代诗，着重在对现实世界的思考。《可以吃的诗》则是诗人针对诗歌创作而写的一篇自白文章，简述了自己的创作之路，剖析自己的心灵。",
            "download_link_epub": "http://download.bookset.me/d.php?f=2016/5/%5B日%5D-石川啄木-事物的味道，我尝得太早了-9787208136991.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2016/5/%5B日%5D-石川啄木-事物的味道，我尝得太早了-9787208136991.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2016/5/%5B日%5D-石川啄木-事物的味道，我尝得太早了-9787208136991.mobi"
        },
        {
            "title": "美国陷阱",
            "author": "[法] 弗雷德里克·皮耶鲁齐",
            "time": "2019年5月1日",
            "image": "https://bookset.me/cover/s32305312.jpg",
            "douban_score": 8.6,
            "double_score_c_ount": 936,
            "douban_link": "https://book.douban.com/subject/33379779/",
            "introduction": "2013年4月14日，美国纽约肯尼迪国际机场，法国阿尔斯通集团锅炉部全球负责人弗雷德里克•皮耶鲁齐，刚下飞机就被美国联邦调查局探员逮捕。 这场抓捕不仅仅是针对他个人的行为，而是美国政府针对法国阿尔斯通的系列行动之一。之后，美国司法部指控皮耶鲁齐涉嫌商业贿赂，并对阿尔斯通处以7.72亿美元罚款。阿尔斯通的电力业务，最终被行业内的主要竞争对手——美国通用电气公司收购。阿尔斯通这家曾经横跨全球电力能源与轨道交通行业的商业巨头，因此被美国人“肢解”。而皮耶鲁齐直到2018年9月才走出监狱，恢复自由。 在《美国陷阱》一书中，皮耶鲁齐以身陷囹圄的亲身经历披露了阿尔斯通被美国企业“强制”收购，以及美国利用《反海外腐败法》打击美国企业竞争对手的内幕。 这是一场隐秘的经济战争。",
            "download_link_epub": "http://download.bookset.me/d.php?f=2019/5/%5B法%5D-弗雷德里克·皮耶鲁齐-美国陷阱-9787521702415.epub",
            "download_link_azw3": "http://download.bookset.me/d.php?f=2019/5/%5B法%5D-弗雷德里克·皮耶鲁齐-美国陷阱-9787521702415.azw3",
            "download_link_mobi": "http://download.bookset.me/d.php?f=2019/5/%5B法%5D-弗雷德里克·皮耶鲁齐-美国陷阱-9787521702415.mobi"
        }
    ]
}''';

const String CHULE_DETAIL_JSON_STR = '''{
    "err_code": 0,
    "error": "",
    "data":[{
    "huxiu_news": {
        "news_id": "",
        "title": "工作有益健康，一周上班一天就够了",
        "news_link": "https://www.huxiu.com/article/306541.html",
        "author": {
            "author_name": "果壳?",
            "author_img": "https://img.huxiucdn.com/auth/data/avatar/001/33/78/39_1529044281.jpg?imageView2/1/w/40/h/40/|imageMogr2/strip/interlace/1/quality/85/format/jpg",
            "author_id": "1872067"
        },
        "create_time": "201907/01/160402662180",
        "desc": " 老板给不给放假，又是另一回事了",
        "image_link": "https://img.huxiucdn.com/article/cover/201907/01/160402662180.jpg?imageView2/1/w/400/h/225/|imageMogr2/strip/interlace/1/quality/85/format/jpg",
        "category": [
            {
                "category_name": "生活腔调",
                "category_id": "4"
            }
        ]
    },
    "contents": [
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "7月7日，NGA论坛的一位网友",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "发帖表示",
                    "text_style": 6,
                    "extra": "https://ngabbs.com/read.php?tid=17818033&rand=553"
                },
                {
                    "content_type": 0,
                    "content_detail": "，MIUI系统上的《刀塔霸业》被植入了奇怪的广告。具体的表现形式是，在打开《刀塔霸业》时，他发现游戏启动前插播了一条广告，广告内容来自拼多多和今日头条——它们都是国内知名的应用软件。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "■ 虽然名字很霸气，还是被人插了广告",
                    "text_style": 2,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "你当然听说过《刀塔霸业》，它是个正统的自走棋游戏——“自走棋”算是近半年来游戏行业里的明星，而《刀塔霸业》是Valve制作的自走棋游戏。《刀塔霸业》同时登陆PC端和移动端，并做到了数据共通，可以跨平台联机。相比此前《Artifact》的折戟沉沙，《刀塔霸业》的表现相当不错。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 2,
            "content_details": [
                {
                    "content_type": 1,
                    "content_detail": "",
                    "text_style": 4,
                    "extra": "http://img.chuapp.com/wp-content/Picture/2019-07-09/7395d246f417c5a1.jpg?imageView2/2/w/700"
                }
            ]
        },
        {
            "content_container_type": 3,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "或许是今年来最成功的V社游戏",
                    "text_style": 1,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "TapTap上的许多玩家也反馈了类似的问题。TapTap的一位玩家",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "提出了",
                    "text_style": 6,
                    "extra": "https://www.taptap.com/topic/6587126"
                },
                {
                    "content_type": 0,
                    "content_detail": "游戏“自带广告”的问题，他说，自己从多个渠道下载的游戏均有广告。随后，TapTap《刀塔霸业》讨论区的",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "版主发帖称",
                    "text_style": 6,
                    "extra": "https://www.taptap.com/topic/6587955"
                },
                {
                    "content_type": 0,
                    "content_detail": "：其他手机均未发现类似问题，“已经可以基本确定是由于玩家使用小米手机的缘故”。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "虽然也有一些小米用户表示没有看见广告，但在NGA论坛的相关帖子里，一些网友在回复中提供了来自小米用户的广告截图。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 2,
            "content_details": [
                {
                    "content_type": 1,
                    "content_detail": "",
                    "text_style": 4,
                    "extra": "http://img.chuapp.com/wp-content/Picture/2019-07-09/6875d246f4c1d590.jpg?imageView2/2/w/700"
                }
            ]
        },
        {
            "content_container_type": 3,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "广告的下方带有《刀塔霸业》标志（图片来自NGA）",
                    "text_style": 1,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "作为一款还未正式上架国内各大应用商店的游戏，《刀塔霸业》的确没有理由插入众多国内厂商的广告。不过，已经有不同的玩家进行了测试，他们的《刀塔霸业》安装包来自不同渠道，包括官方网站、谷歌商店、一些国内的应用商店或来自加速器平台、朋友提供……但都出现了类似的广告。所有这些广告的共同点是，它们出现在搭载MIUI系统的手机上。玩家们于是很自然地推测，小米从系统层面给《刀塔霸业》加上了广告。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "为了验证帖子中所述的真实性，7月8日下午，我利用小米手机（小米MIX 3，MIUI系统版本10.3，稳定版）在谷歌商店下载了《刀塔霸业》，并尝试进入游戏。经过反复试验，游戏并未弹出广告。差不多是同一时间，NGA的帖子中有玩家回复：此前的广告已经不再出现，可能是被“修复”了。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "尽管未能亲眼所见，但MIUI系统中插入类似广告的事件之前也曾发生过。作为一个MIUI使用者，我的确曾在其他程序中见到过布局相似的广告，部分程序甚至有两层广告——跳过疑似系统广告后还会进入App自带的广告。从设计角度上说，很难想象哪个App会设计两层启动广告。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 2,
            "content_details": [
                {
                    "content_type": 1,
                    "content_detail": "",
                    "text_style": 4,
                    "extra": "http://img.chuapp.com/wp-content/Picture/2019-07-09/8605d246f75b690a.jpg?imageView2/2/w/700"
                }
            ]
        },
        {
            "content_container_type": 3,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "疑似是系统添加的广告的布局：上半部分广告，下半部分显示App名称与跳过按钮。此前这类广告就出现过，当然这种广告可能来自App与MIUI的合作，但很难想象《刀塔霸业》会和小米有此类合作（图片来自NGA）",
                    "text_style": 1,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "我们当然已经熟悉了手机App广告。作为在商业社会中成长和浸泡的人，我们已经没有那么反感广告了，但在系统层面上强行添加广告则是另外一件事。不管你用什么，只要你还在这个系统上，就可能会被强制播放一段广告。这些广告不给你选择的机会，甚至不告诉你它们从何而来。它们如影随形、无可躲避、毫不讲理。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "小米陷入与广告有关的公关危机已经不是什么新鲜事了，在小米的官方论坛上，甚至有一篇“如何关闭MIUI的18种广告”的",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "教程贴",
                    "text_style": 6,
                    "extra": "http://www.miui.com/thread-15991867-1-1.html"
                },
                {
                    "content_type": 0,
                    "content_detail": "。网友们对这个教程贴反响热烈，一共回复了超过3.2万层。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "■ 乌龙霸业",
                    "text_style": 2,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "MIUI并不是在《刀塔霸业》中找到机会的唯一事物。早在6月24日，《刀塔霸业》就在国内平台",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "闹出过一场乌龙",
                    "text_style": 6,
                    "extra": "https://ngabbs.com/read.php?tid=17681968&rand=591"
                },
                {
                    "content_type": 0,
                    "content_detail": "，有玩家发现《刀塔霸业》在应用宝上线，并且应用宝还提示游戏有新版本更新，但更新之后，游戏却开始报错。回过头一看，他发现《刀塔霸业》的“开发商”一栏里写着“海沙工作室”。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 2,
            "content_details": [
                {
                    "content_type": 1,
                    "content_detail": "",
                    "text_style": 4,
                    "extra": "http://img.chuapp.com/wp-content/Picture/2019-07-09/8895d246f9c268ed.jpg?imageView2/2/w/700"
                }
            ]
        },
        {
            "content_container_type": 3,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "“开发者”往往容易被忽略（图片来自NGA）",
                    "text_style": 1,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "“海沙工作室”在业内算是小有名气的，除了《刀塔霸业》外，这家能够让人联想到椰林和海浪的工作室还出品过“Uplay手机版客户端”、《旅行青蛙》以及其他各式各样的手机游戏。其实你我都知道，无论是Uplay手机版客户端，还是《旅行青蛙》，都不是这家工作室开发的，他们不过是将这些App上传至各大应用商店，并在“开发者”一栏里冒名顶替。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "但这并不能阻止他们一次又一次地上传一些打着擦边球的玩意儿。在《刀塔霸业》这件事上，现在的进展是，应用宝随后将“开发商”一栏里的名称更改为Valve。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "《刀塔霸业》是一个必定会受欢迎的游戏，恐怕所有平台都不希望用户在自家的平台里无法玩到这个游戏——这可不是一件小事。那么，如果Valve自己不去上传《刀塔霸业》，这些平台会怎么做呢？",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "从另一个角度讲，就算是“海沙工作室”也可以在这场热闹中得到些什么。触乐曾经刊登过一篇关于",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "盗版游戏的文章",
                    "text_style": 6,
                    "extra": "http://www.chuapp.com/article/286368.html"
                },
                {
                    "content_type": 0,
                    "content_detail": "，其中提到了当前移动市场的种种乱象。这些平台有两个主要盈利点，最直接的是广告收入，包括平台本身的广告和在安装程序中插入SDK的广告。除此之外，平台也能从联合运营的游戏中获利。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "依据程序中插入的SDK，广告的获益可能交给平台方，也可能交给开发者。这恐怕也或多或少地解释了海沙工作室冒名顶替的动机，在安卓端，解包并插入自己的SDK并不困难，甚至就连游戏的内购数据都可以修改；同时，广告又意味着收入。因此，冒名者们不需要付出开发的成本，只需要对程序稍作修改，就可以获取程序的全部利益。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "■ 一个自走棋出现了，满世界的自走棋都来了",
                    "text_style": 2,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "对于V社而言，《刀塔霸业》的制作其实已经可以算得上神速了——它竟然没有比国内的一干仿冒者慢多少。V社迅速完成了这个游戏，甚至还把它弄成了多平台共通，这样，它甚至在移动端也没有落下风。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "V社超乎以往的紧迫感也许是有道理的。在中国市场，虽然厂商们很少拿出具有世界级影响力的产品，但在跟进速度方面却从来都不甘居人后。从MOBA到二次元，从“吃鸡”到自走棋，每当一个产品流行起来，你总能看到千万个流行游戏的同胞兄弟。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 2,
            "content_details": [
                {
                    "content_type": 1,
                    "content_detail": "",
                    "text_style": 4,
                    "extra": "http://img.chuapp.com/wp-content/Picture/2019-07-09/3335d246fdba3d8e.png?imageView2/2/w/700"
                }
            ]
        },
        {
            "content_container_type": 3,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "V社自走棋中的角色来自“Dota”游戏，其他自走棋当然要另选角色了",
                    "text_style": 1,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "还是拿自走棋来说，最初作为《Dota 2》Mod流行之后，大量热门游戏都推出了自走棋模式。新模式之外，“新”游戏更是层出不穷，就连“官方版本”都有3版：《Dota 2》游廊模式中的原版、巨鸟多多的手游，以及《刀塔霸业》。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "没有“官方”名号的“自走棋”就更多了，数不胜数。参与制作的既有大厂，也有许多不知名的小厂商，在众多的竞争者中，《刀塔霸业：云顶自走棋》极具特色。这个名字本身就很讲究：“自走棋”开篇明义，“刀塔霸业”中的“刀塔”和“霸业”对应Valve的游戏。与此同时，“云顶”则对应着《英雄联盟》的自走棋模式“云顶之弈”——这个游戏把什么都占全了。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 2,
            "content_details": [
                {
                    "content_type": 1,
                    "content_detail": "",
                    "text_style": 4,
                    "extra": "http://img.chuapp.com/wp-content/Picture/2019-07-09/9245d246fe6cc302.jpg?imageView2/2/w/700"
                }
            ]
        },
        {
            "content_container_type": 3,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "令人惊讶的是，这款游戏的评分高达4.8分",
                    "text_style": 1,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "游戏的介绍也颇具玄机，一句话介绍中写着“魔幻英雄多多战棋手游”。这句话其实又涵盖了多层意思，还将“巨鸟多多”名字的一部分包含进介绍界面，颇具迷惑性。游戏的商店介绍中写着，本作“融合时下热门塔防玩法，汇聚顶尖制作还原‘魔兽’经典，再创革新‘吃鸡’潮流，《魔法自走棋》致力于发扬竞技塔防，将端游军团战玩法呈现于手机端”。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "或许太多的人会惊叹于这句话的兼容并包，毕竟你很难在一句话里包含下“塔防”“魔幻”“魔兽”“吃鸡”“竞技”“还原端游”等所有关键词。在赞叹这句话的同时，可能只有很少的人会发现，介绍中游戏的名字都已经不一样了。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "市场上现在有多少个“自走棋”呢？统计起来有些麻烦，而且没什么必要——不久的将来，还会有更多自走棋。会出现多少模仿者，这已经成了鉴别热门品类的重要参考。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "这个数字非常有趣，它既可以说明一个类型有多火热，也可以用来说明市场有多扭曲——似乎这些开发者平时都无事可做，都在等待一个可供参照的热门游戏，一旦这个游戏出现，他们也全力开工了。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "■ 刀耕火种的市场环境",
                    "text_style": 2,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "“刀耕火种”指的是石器时代的农业生产方式。原始人类用石斧砍伐草木，然后用一把大火将草木烧尽。火烧的土地变得松软，草木灰也能增强土地肥力。原始人们在土地上播下种子，等待作物成熟。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "刀耕火种的最大特色就是糙，一场大火、随意播种、听天由命。有些时候，游戏行业，尤其是国内的游戏行业，就有那么点刀耕火种的意思。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "一个热门种类就是一场大火，它先是点起玩家的热情，使所有人都意识到一个种类（例如“吃鸡”“自走棋”）火了。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "随后，众多仿造者们纷纷登场，在大火的尘埃之上开始播种，将一个“吃鸡”变成千万盘鸡，将“自走棋”变成千万个“自走棋”。这些“播种”也不需要那么讲究，有的自生自灭，有的野蛮生长……",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "最有趣的是，到了收获季节，收获的人却未必是播种的人。最初放火的人能收获最多吗？播种最勤奋的人能收获最多吗？未必。就现在的市场环境来说，开发商是有死有活，平台或渠道总是稳赚不亏，区别无非是吃相罢了。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "诚然，玩法不受任何法律的保护，仿造也不意味着没有精品。事实上，我们所知的绝大多数优秀作品都早有珠玉在前，是在继承前人基础上的再创造，但这仍然不意味着这种蜂拥而上的市场氛围是合理的。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "我们都知道，总有一天“自走棋”会凉，但总会有下一个热门作品。而当下一个热门作品出现时，大小公司们仍然会将主要研发资源投放在“热门品类”上；渠道还是会利用已有的资源继续创收；玩家可能会满意、可能不会，但不管怎么说，海内海外他们总还有游戏玩。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "市场可能还是会欣欣向荣，但这种循环本身却有些漫无止境、惹人生厌。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        }
    ]
}]}''';

const String CHULE_LIST_JSON_STR = '''{
    "err_code": 0,
    "error": "",
    "data":[
    {
        "news_id": "286536",
        "title": "“BattleTech”：一个系列游戏的诞生、衰落与重生（下）",
        "news_link": "/article/286536.html",
        "author": {
            "author_name": "爱吃金萝卜的小灰兔",
            "author_img": "",
            "author_id": ""
        },
        "create_time": "1563465600",
        "desc": "“BattleTech”玩家将真正地再续17年来的机甲之梦。",
        "image_link": "http://img.chuapp.com//wp-content/Picture/2019-07-19/5d315e77e0b0d.jpg?imageView2/5/w/390/h/219",
        "category": null
    },
    {
        "news_id": "286533",
        "title": "“BattleTech”：一个系列游戏的诞生、衰落与重生（上）",
        "news_link": "/article/286533.html",
        "author": {
            "author_name": "爱吃金萝卜的小灰兔",
            "author_img": "",
            "author_id": ""
        },
        "create_time": "1563379200",
        "desc": "“机甲战士”系列回归的2019年，是“BattleTech”诞生的35周年。",
        "image_link": "http://img.chuapp.com//wp-content/Picture/2019-07-18/5d301bd0e36d2.jpg?imageView2/5/w/390/h/219",
        "category": null
    },
    {
        "news_id": "286530",
        "title": "游戏少年的职场漂流",
        "news_link": "/article/286530.html",
        "author": {
            "author_name": "池骋",
            "author_img": "",
            "author_id": ""
        },
        "create_time": "1563292800",
        "desc": "“创作行业本身就需要献祭掉99%的人，但真正热爱游戏的人，一辈子都不会屈服于这个现实。”",
        "image_link": "http://img.chuapp.com//wp-content/Picture/2019-07-17/5d2ef0956bd22.jpg?imageView2/5/w/390/h/219",
        "category": null
    },
    {
        "news_id": "286525",
        "title": "流光溢彩的毕业展与跃跃欲试的“反叛者们”",
        "news_link": "/article/286525.html",
        "author": {
            "author_name": "李应初",
            "author_img": "",
            "author_id": ""
        },
        "create_time": "1563206400",
        "desc": "毕业快乐，西西弗斯。",
        "image_link": "http://img.chuapp.com//wp-content/Picture/2019-07-16/5d2d7d84c7d0b.jpg?imageView2/5/w/390/h/219",
        "category": null
    },
    {
        "news_id": "286522",
        "title": "守护“姨夫”的遗产",
        "news_link": "/article/286522.html",
        "author": {
            "author_name": "陈静",
            "author_img": "",
            "author_id": ""
        },
        "create_time": "1563120000",
        "desc": "虽然自己玩游戏不多，但平井一夫正是那个把索尼变成“索大好”的人。",
        "image_link": "http://img.chuapp.com//wp-content/Picture/2019-07-15/5d2c247a0ba10.jpg?imageView2/5/w/390/h/219",
        "category": null
    },
    {
        "news_id": "286520",
        "title": "一场别开生面的新人编辑陷害大赛（下）",
        "news_link": "/article/286520.html",
        "author": {
            "author_name": "池骋",
            "author_img": "",
            "author_id": ""
        },
        "create_time": "1562947200",
        "desc": "在围观我被各种游戏吊打的时候，众人都哄笑起来——单位内外充满了快活的空气。",
        "image_link": "http://img.chuapp.com//wp-content/Picture/2019-07-13/5d298c642bb4d.jpg?imageView2/5/w/390/h/219",
        "category": null
    },
    {
        "news_id": "286517",
        "title": "一场别开生面的新人编辑陷害大赛（上）",
        "news_link": "/article/286517.html",
        "author": {
            "author_name": "池骋",
            "author_img": "",
            "author_id": ""
        },
        "create_time": "1562860800",
        "desc": "惊呼阵阵，怒骂连连，究竟是什么让新编辑如此激动？",
        "image_link": "http://img.chuapp.com//wp-content/Picture/2019-07-12/5d284b6a5f132.jpg?imageView2/5/w/390/h/219",
        "category": null
    },
    {
        "news_id": "286512",
        "title": "14年后，“爱神餐馆”等待重新开张",
        "news_link": "/article/286512.html",
        "author": {
            "author_name": "窦宇萌",
            "author_img": "",
            "author_id": ""
        },
        "create_time": "1562774400",
        "desc": "彭子杰今年快要50岁了，他还想做单机游戏。",
        "image_link": "http://img.chuapp.com//wp-content/Picture/2019-07-11/5d26fcd89dfb4.jpg?imageView2/5/w/390/h/219",
        "category": null
    },
    {
        "news_id": "286510",
        "title": "骚男和他的新世界",
        "news_link": "/article/286510.html",
        "author": {
            "author_name": "李应初",
            "author_img": "",
            "author_id": ""
        },
        "create_time": "1562688000",
        "desc": "且随疾风前行，身后亦须留心。",
        "image_link": "http://img.chuapp.com//wp-content/Picture/2019-07-10/5d2595d4a4742.jpg?imageView2/5/w/390/h/219",
        "category": null
    },
    {
        "news_id": "286508",
        "title": "刀耕火种“自走棋”",
        "news_link": "/article/286508.html",
        "author": {
            "author_name": "熊宇",
            "author_img": "",
            "author_id": ""
        },
        "create_time": "1562601600",
        "desc": "???????一盘自走棋，千万“卖棋人”。",
        "image_link": "http://img.chuapp.com//wp-content/Picture/2019-07-09/5d24706cc7e45.jpg?imageView2/5/w/390/h/219",
        "category": null
    }
]
}''';
