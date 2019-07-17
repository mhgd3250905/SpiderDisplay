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

const HUXIU_DETAIL_STR = '''{
    "huxiu_news": {
        "title": "工作有益健康，一周上班一天就够了",
        "news_link": "https://www.huxiu.com/article/306541.html",
        "author": {
            "author_name": "果壳?",
            "author_img": "https://img.huxiucdn.com/auth/data/avatar/001/33/78/39_1529044281.jpg?imageView2/1/w/40/h/40/|imageMogr2/strip/interlace/1/quality/85/format/jpg",
            "author_id": "1872067"
        },
        "create_time": "201907/01/160402662180",
        "desc": "老板给不给放假，又是另一回事了",
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
                    "content_detail": "本文来自微信公众号：",
                    "text_style": 5,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "全媒派（ID：quanmeipai）",
                    "text_style": 6,
                    "extra": "https://mp.weixin.qq.com/s?__biz=MzA3MzQ1MzQzNA==&mid=2656951595&idx=1&sn=aecc5a12e69199421269a60d6027724b&chksm=84a7a73eb3d02e28df135dd525e0b58eb084239f2e2e7ae18b6a844a0a47065b176e1d36e7eb&mpshare=1&scene=1&srcid=#rd"
                },
                {
                    "content_type": 0,
                    "content_detail": "，作者： 腾讯传媒，标题图来自视觉中国",
                    "text_style": 5,
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "在这个数字时代，人们接受的信息要比以往任何一个时代都多。",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "无论何时何地，你都可以快速便捷地获得大量免费信息。",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "但你所接触的不仅是简单的符号和文字，而是从种族冲突到全球变暖，从流行文化再到家长里短的一切话题。",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "如果控制得当，这些内容能够为读者带来休闲消遣或知识增长的愉悦。",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "但是，越来越明显的趋势已经表明，现在的新闻并不总能给读者带来幸福。",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "快速发展的技术使得新闻更易获得，但也使得逃避新闻更加容易。",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "以至于，过去几年中，“新闻回避",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "（news avoidance）",
                    "text_style": 5,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "”成为了学界研究的新主题。",
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
                    "text_style": 3,
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
                    "extra": "https://img.huxiucdn.com/article/content/201907/10/091604959789.jpg?imageView2/2/w/1000/format/jpg/interlace/1/q/85"
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "本期全媒派独家编译，从宏观数据的整体角度和凸显细节的个体视角出发，和你聊聊现代人",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "逃避新闻",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "那些事儿。",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "数说“新闻回避”",
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
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "今年6月，路透新闻研究所联合牛津大学发布了最新一期数字新闻报道的相关数据。",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "在2017年，29%的全球受访者表示他们会“经常或有时避开新闻”",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "，具体到不同国家，在美国这一回避行为占比为38%，在英国为24%。而到了2019年，",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "这组数据在全球范围增加了3个百分点",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "，达到32%，在美国上升到41%，英国达到35%。",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "（即使拥有最忠实读者的日本，回避新闻的人群占比也从2017年的6%增加到了11%）",
                    "text_style": 5,
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
                    "text_style": 3,
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
                    "extra": "https://img.huxiucdn.com/article/content/201907/10/091604885732.jpg?imageView2/2/w/1000/format/jpg/interlace/1/q/85"
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "为什么人们会回避新闻？",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "第一个原因是大量新闻替代品的出现。",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "正如MarkusPrior在2007年出版的《Post-Broadcast Ddemocracy》一书中提到的那样，大众一直在调整对新闻的接触。随着媒介产品的丰富，人们开始更少地消费新闻而选择其他“食物”。",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "第二个原因是政治两极分化加剧，特别是情感的两极分化。",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "在美国，有35%的受访者表示，自己逃避阅读新闻的原因是“无法相信新闻的真实性”，而在一定程度上，新闻不信任与政治不信任之间存在着联系。在英国，新闻回避行为快速增长的重要原因正是“受挫于英国脱欧及随之出现的困局。”",
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
                    "text_style": 3,
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
                    "extra": "https://img.huxiucdn.com/article/content/201907/10/091604521343.jpg?imageView2/2/w/1000/format/jpg/interlace/1/q/85"
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "此外，读者避开新闻最常见的原因还与心理情绪相关。在美国，有57%的受访人表示，自己拒绝阅读新闻的原因是：“",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "（新闻）",
                    "text_style": 5,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "对我的情绪产生了负面影响”。",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "这些数据表明了新闻回避正在成为一个严重的问题。",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "但这些数据无法尽可能多地帮助我们解答“为何人们逃避新闻”这一复杂问题。LinkedIn高级编辑Isabelle Roughol向读者询问新闻回避的个体体验，以定性研究的方法对新闻回避这一现象的展开了研究。",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "读者说：新闻回避的定性分析",
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
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "Isabelle Roughol在自己的领英主页抛出“你如何看待新闻回避”这一话题，人们通过评论留下了自己的看法。这一调查虽然不够严谨、科学，",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "但倾听这些来自读者的心声，对了解非新闻从业人员如何看待当下的新闻业依然具有独特价值。",
                    "text_style": 7,
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
                    "text_style": 3,
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
                    "extra": "https://img.huxiucdn.com/article/content/201907/10/091604021237.jpg?imageView2/2/w/1000/format/jpg/interlace/1/q/85"
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "习得性无助",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "在不少读者看来，新闻虽然将他们与现实世界紧紧联结在一起，但是，这种了解对于个体而言，价值甚微。尤其在新闻日益热衷眼球经济和轰动效应的当下，与新闻时刻保持连接，只能让自己更加沮丧和无助。",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "是的，你了解了很多，但是然后呢？你对现实无能无力，无可奈何。",
                    "text_style": 7,
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "我不想再看川普正在做什么或者不做什么的新闻了。为什么？因为除了明年的投票，我什么也做不了。我期待明年，我可以投出那一票让他下台。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "我在十年前开始拒绝新闻，因为我对周围发生的这一切糟心事感到沮丧，并且我意识到除了感到无助外，我无能为力。而在此之前，我曾每天至少有一个小时都在贪婪地阅读报纸。",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "人类作为万物之长，我们明白自己的能力和才华，对自己的主观能动性抱有坚定的信念。",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "但是，大量的新闻报道，让我们处于“习得性无助”的状态，面对关于战乱饥馑或者人性悲凉的故事，我们除了一声叹息外无能为力。",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "没有人会喜欢这种无力感。",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "任何人都不应该对“改变”这件事感到无助。",
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
                    "content_detail": "",
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
                    "extra": "https://img.huxiucdn.com/article/content/201907/10/091604454652.jpg?imageView2/2/w/1000/format/jpg/interlace/1/q/85"
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "从媒体偏好的内容来看，坏消息就是好新闻。",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "但是大量的消极信息，除了对个人心理存在危害外，还会让人产生逃离的欲望。",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "从读者留言可以看出，人们虽然喜欢阅读坏消息，但是没有人想一直生活在充斥着消极信息的环境里。",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "这些消息既污浊又令人泄气，我想保护自己不受这个恐惧工厂的影响。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "我减少了新闻消费。通过自我探索和思考，我意识到新闻对我的情绪、心理健康有着巨大的负面影响，我还无法应对……那些真正重要的新闻总会有办法找到我。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "它很少有积极的东西，总是那么消极。我讨厌听到或者阅读一篇只有糟糕消息的文章。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "不只是消极的，而且没有任何明确的方法来有所作为。",
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
                    "content_detail": "",
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
                    "extra": "https://img.huxiucdn.com/article/content/201907/10/091604232693.jpg?imageView2/2/w/1000/format/jpg/interlace/1/q/85"
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "是的。",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "（新闻）",
                    "text_style": 5,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "有罪，我们需要数字排毒，远离这些有压力的内容。",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "读者们期待怎样的新闻呢？当我们的生活和世界被坏消息所包绕和扭曲，许多人正在呼唤有更多的“好消息”来进行平衡。",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "新闻已经变得格外依赖耸人听闻的内容。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "虽然我们的确需要揭示世界可怕的暴行，但是我们也需要正面事物来与之平衡。如果你要报道一则坏消息，那请告诉我们正在有哪些努力去改善，我们能怎么参与帮助。我的问题是，我为什么要损害我的精力和健康的心理去看那些奇形怪状的照片或者令人沮丧的新闻？我倒情愿去看一本满是广告，没有一则新闻的杂志。",
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
                    "content_detail": "",
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
                    "extra": "https://img.huxiucdn.com/article/content/201907/10/091604786538.jpg?imageView2/2/w/1000/format/jpg/interlace/1/q/85"
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "我觉得要对新闻接触有选择。我订阅了好消息新闻网",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "（the Good News Network）",
                    "text_style": 5,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "，每天都会有一些令人振奋的故事。",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "离开新闻 你会过得更好",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "“为什么要浪费时间精力，让自己的头脑充满那些有毒的、不真实的内容？我的建议是，不如集中精力在现实生活中多做些好事。”",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "作为有充分自信安排好自己生活的现代人，为了长久地保持内心的平静和自足，很多人选择离开新闻。新闻，已经像酒精毒品一样的东西，成为一群人戒断的对象。这种对新闻接触的成功自制，将是他们引以为豪的“美德”。",
                    "text_style": 7,
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "当我们清晰地思考，认真地过自己的生活时，我们就不会被那些永无止境的循环新闻打扰分心。我们头脑清醒时，我们会知道什么是重要的，什么是需要放弃的。",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "关闭这些白噪音",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "（新闻）",
                    "text_style": 5,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "有助于我们更好地过好自己的生活。",
                    "text_style": 7,
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
            "content_container_type": 2,
            "content_details": [
                {
                    "content_type": 1,
                    "content_detail": "",
                    "text_style": 4,
                    "extra": "https://img.huxiucdn.com/article/content/201907/10/091604927492.jpg?imageView2/2/w/1000/format/jpg/interlace/1/q/85"
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "一段时间前，我过得筋疲力尽。我收到的第一条医嘱是：“不要再看新闻了”。与新闻断开连接，消除了那些耸人听闻的内容和思虑过重带来的压力。让世界自行其是。",
                    "text_style": 0,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "我们的大脑总是向往那些令人震惊的新闻故事",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "（生存本能需要我们时常感受到恐惧在侧）",
                    "text_style": 5,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "，所以",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "戒掉新闻并不容易。但最为重要的是，能够保持自己内心的平静。",
                    "text_style": 7,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 1,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "我还在阅读和接触，但我绝不在社交媒体上发表有争议性的言论。要做到这一点，需要极大的自制力，但是得益于此，我感受到的压力已经在急剧下降。",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "启示录：面对新闻回避 我们还能做什么？",
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
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "应对日常中的信息爆炸是我们在这个数字时代最紧迫的挑战之一。",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "记者们需要努力应对来势汹涌的消息来源，读者们则需要应付屏幕上越来越多的媒体内容。对于越来越多的人而言，逃避新闻成为了自己重新掌控生活的重要方式。",
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
                    "text_style": 3,
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
                    "extra": "https://img.huxiucdn.com/article/content/201907/10/091604012027.jpg?imageView2/2/w/1000/format/jpg/interlace/1/q/85"
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "但是站在整个社会的角度来看，",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "新闻疲劳和新闻回避已经成为媒介系统和民主国家肌体上的重大病症。",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "在这样一个充满了挑衅观点和惊悚内容，却又严重缺乏事实和共识的世界里，如何保证人们享有知情权，又如何在知情权与日益增加的智力、情感负担之间取得平衡？",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "根据本文第二部分，读者对新闻逃避行为的自我披露，内容生产者们或许可以获得一些启发：",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "首先，在撰写报道中，新闻工作者应该努力提供问题的解决方案。",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "现在大多数新闻报道因为缺乏对解决问题的积极思考，而倍加让读者感到沮丧和无助。在这种情况下，新闻消费给人们带来了习得性无助，这降低了新闻的吸引力，让更多的人选择逃避。",
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
                    "text_style": 3,
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
                    "extra": "https://img.huxiucdn.com/article/content/201907/10/091604484718.jpg?imageView2/2/w/1000/format/jpg/interlace/1/q/85"
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "其次，新闻工作者需要重视读者的情感和心理体验。",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "在后特朗普时代，考虑到充斥在社交媒体和传统媒体上对“假新闻”的指摘，“新闻信任”是一个特别的流行词。但是，从上文中读者对新闻回避进行的自我报告来看，我们可能高估了信任在决定人们不阅读、不接触新闻报道中的作用。毕竟，与“我不相信新闻是真实的”相比，“",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "（新闻）",
                    "text_style": 5,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "对我的情绪会产生负面影响”才是人们新闻逃避的更重要因素。",
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "现在，由于社交媒体放大了“新闻信任”问题，我们也许只是把目光集中在了那些指责新闻媒体是“骗子”“魔术师”的群体上，反而忽视了更大的群体——对这一群体而言，他们逃避新闻是因为感受到了过多的压力和心理负担、感到时间和精力的无谓付出。",
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
                    "text_style": 3,
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
                    "extra": "https://img.huxiucdn.com/article/content/201907/10/091604173952.jpg?imageView2/2/w/1000/format/jpg/interlace/1/q/85"
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "</br>",
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "新闻阅读曾是我们生活中的重要仪式，从晨报到晚报，它陪伴人们更好地理解和应对我们所处的世界。",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "现在，过载的新闻资讯带给我们压力，",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "在技术提供了更多可能和媒介产品的日益丰富之下，拒绝新闻正在成为一个有吸引力的选项。",
                    "text_style": 7,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "在这种背景下，许多人认为，作为独立的理性经济人，没有新闻或者减少新闻，能够让他们过得更好。这种观点虽然有着基于现实的思辨价值，",
                    "text_style": 0,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "但是，对于新闻业乃至现代公共社会而言，这可能并不是一个好消息。",
                    "text_style": 7,
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
                    "text_style": 3,
                    "extra": ""
                }
            ]
        },
        {
            "content_container_type": 0,
            "content_details": [
                {
                    "content_type": 0,
                    "content_detail": "本文来自微信公众号：",
                    "text_style": 5,
                    "extra": ""
                },
                {
                    "content_type": 0,
                    "content_detail": "全媒派（ID：quanmeipai）",
                    "text_style": 6,
                    "extra": "https://mp.weixin.qq.com/s?__biz=MzA3MzQ1MzQzNA==&mid=2656951595&idx=1&sn=aecc5a12e69199421269a60d6027724b&chksm=84a7a73eb3d02e28df135dd525e0b58eb084239f2e2e7ae18b6a844a0a47065b176e1d36e7eb&mpshare=1&scene=1&srcid=#rd"
                },
                {
                    "content_type": 0,
                    "content_detail": "，作者： 腾讯传媒，标题图来自视觉中国",
                    "text_style": 5,
                    "extra": ""
                }
            ]
        }
    ]
}''';
