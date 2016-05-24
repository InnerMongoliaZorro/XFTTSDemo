//
//  ViewController.m
//  MoGoXFDemo
//
//  Created by MoGo on 16/5/23.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "ViewController.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"



#import "TXSoundPlayer.h"


static  NSString * dayweather =@"盼望着，盼望着，东风来了，春天的脚步近了。一切都像刚睡醒的样子，欣欣然张开了眼。山朗润起来了，水涨起来了，太阳的脸红起来了。小草偷偷地从土地里钻出来，嫩嫩的，绿绿的。园子里，田野里，瞧去，一大片一大片满是的。坐着，躺着，打两个滚，踢几脚球，赛几趟跑，捉几回迷藏。风轻俏俏的，草软绵绵的。桃树，杏树，梨树，你不让我，我不让你，都开满了花赶趟儿。红的像火，粉的像霞，白的像雪。花里带着甜味；闭了眼，树上仿佛已经满是桃儿，杏儿，梨儿。花下成千成百的蜜蜂嗡嗡的闹着，大小的蝴蝶飞来飞去。野花遍地是：杂样儿，有名字的，没名字的，散在草丛里像眼睛像星星，还眨呀眨。“吹面不寒杨柳风”，不错的，像母亲的手抚摸着你，风里带着些心翻的泥土的气息，混着青草味儿，还有各种花的香，都在微微润湿的空气里酝酿。鸟儿将巢安在繁花嫩叶当中，高兴起来，呼朋引伴的卖弄清脆的歌喉，唱出婉转的曲子，跟清风流水应和着。牛背上牧童的短笛，这时候也成天嘹亮的响着。雨是最寻常的，一下就是三两天。可别恼。看，像牛牦，像花针，像细丝，密密的斜织着，人家屋顶上全笼着一层薄烟。树叶却绿得发亮，小草也青得逼你的眼。傍晚时候，上灯了，一点点黄晕的光，烘托出一片安静而和平的夜。在乡下，小路上，石桥边，有撑着伞慢慢走着的人，地里还有工作的农民，披着所戴着笠。他们的房屋稀稀疏疏的，在雨里静默着。天上的风筝渐渐多了，地上的孩子也多了。城里乡下，家家户户，老老小小，也赶趟似的，一个个都出来了。舒活舒活筋骨，抖擞抖擞精神，各做各的一份事儿去。“一年之计在于春”，刚起头儿，有的是功夫，有的是希望春天像刚落地的娃娃，从头到脚都是新的，它生长着。春天像小姑娘，花枝招展的笑着走着。春天像健壮的青年，有铁一般的胳膊和腰脚，领着我们向前去。";
@interface ViewController ()<IFlySpeechSynthesizerDelegate>
{
    IFlySpeechSynthesizer * _iFlySpeechSynthesizer;
    TXSoundPlayer* _sound;
}
- (IBAction)XFSoundy:(UIButton *)sender;
- (IBAction)systemSoundy:(UIButton *)sender;
- (IBAction)outOfServiceAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *outOfServiceButton;
@property (weak, nonatomic) IBOutlet UIButton *continueSpeakingButton;
- (IBAction)continueSpeakingAction:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.outOfServiceButton setTitle:@"暂停" forState:UIControlStateNormal];
    [self.outOfServiceButton setTitle:@"继续" forState:UIControlStateSelected];
    [self.continueSpeakingButton setTitle:@"暂停" forState:UIControlStateNormal];
    [self.continueSpeakingButton setTitle:@"继续" forState:UIControlStateSelected];
_iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    _iFlySpeechSynthesizer.delegate =
    self;
    
    //设置在线工作方式
    [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                  forKey:[IFlySpeechConstant ENGINE_TYPE]];
    //音量,取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]]; //发音人,默认为”xiaoyan”,可以设置的参数列表可参考“合成发音人列表” [_iFlySpeechSynthesizer setParameter:@" xiaoyan " forKey: [IFlySpeechConstant VOICE_NAME]]; //保存合成文件名,如不再需要,设置设置为nil或者为空表示取消,默认目录位于 library/cache下
    [_iFlySpeechSynthesizer setParameter:@" tts.pcm" forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    
    
    /**
     *  系统方法
     */
    _sound=[TXSoundPlayer soundPlayerInstance];
    _sound.rate = 0.5;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//3.启动合成会话
- (IBAction)XFSoundy:(UIButton *)sender {
    [_iFlySpeechSynthesizer startSpeaking: dayweather];
}
//暂停
- (IBAction)outOfServiceAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [_iFlySpeechSynthesizer pauseSpeaking];
    }else{
        [_iFlySpeechSynthesizer resumeSpeaking];
    }
}
//结束代理
- (void) onCompleted:(IFlySpeechError *) error{
}
//合成开始
- (void) onSpeakBegin{
}
//合成缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg{
} //合成播放进度
- (void) onSpeakProgress:(int) progress{
}





- (IBAction)systemSoundy:(UIButton *)sender {
    
    [_sound play:dayweather];
}

- (IBAction)continueSpeakingAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [_sound stopSpeaking];
    }else{
        [_sound continueSpeaking];
    }

}
@end
