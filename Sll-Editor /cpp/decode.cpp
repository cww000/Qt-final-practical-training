#include "decode.h"
#include <QDebug>
extern "C" {
    #include <libavutil/samplefmt.h>
    #include <libavutil/dict.h>
    #include <libavformat/avformat.h>
    #include <libavcodec/avcodec.h>
    #include <libswresample/swresample.h>

}
Decode::Decode(QObject *parent) : QObject(parent)
{

}

bool Decode::decode(QString filePath)
{
    qDebug()<<"开始解码"<<filePath;
    AVFormatContext *pFormat=avformat_alloc_context();
  //  QString filePath="/root/海阔天空1.mp3";
    QByteArray temp=filePath.toUtf8();
    const char *path=temp.constData();
    QString out="../out.pcm";
    QByteArray ou=out.toUtf8();
    const char *output=ou.constData();
    int ret=avformat_open_input(&pFormat,path,NULL,NULL);
    if(ret!=0 || pFormat==NULL) {
        qDebug()<<"无法打开文件！";
        return 0;
    }
//    //查看mp3文件的元信息
//    av_dict_set(&pFormat->metadata,"title","sky",AV_DICT_DONT_STRDUP_KEY);
//    AVDictionaryEntry *tag = NULL;
//    while ((tag =av_dict_get(pFormat->metadata, "", tag, AV_DICT_IGNORE_SUFFIX))) {
//        qDebug()<<tag->key<<": "<<tag->value;
//    }
    //获取文件流信息
    if(avformat_find_stream_info(pFormat,NULL)<0) {
        qDebug()<<"获取流信息失败！";
        return 0;
    }
//    qDebug()<<pFormat->duration/(1000*1000.0)<<"s";
//    qDebug()<<pFormat->iformat->name<<":"<<pFormat->iformat->long_name;
    int audio_stream_idx=-1;
    for(unsigned int i=0;i<pFormat->nb_streams;++i) {
        if(pFormat->streams[i]->codecpar->codec_type==AVMEDIA_TYPE_AUDIO) {
            audio_stream_idx=i;
            break;
        }
    }
    AVCodecParameters *codecpar=pFormat->streams[audio_stream_idx]->codecpar;
    //找到解码器
    AVCodec *dec=avcodec_find_decoder(codecpar->codec_id);
    //创建上下文
    AVCodecContext *codecContext=avcodec_alloc_context3(dec);
    avcodec_parameters_to_context(codecContext,codecpar);
    codecContext->pkt_timebase = pFormat->streams[audio_stream_idx]->time_base;
    avcodec_open2(codecContext,dec,NULL);
    SwrContext *swrContext=swr_alloc();

    //输入的这些参数
    AVSampleFormat in_sample=codecContext->sample_fmt;
    //输入采样率
    int in_sample_rate=codecContext->sample_rate;
    //输入声道布局
    uint64_t in_ch_layout=codecContext->channel_layout;

    //输出参数
    //输出采样格式
    AVSampleFormat out_sample=AV_SAMPLE_FMT_S16;
    //输出采样率
    int out_sample_rate=44100;
    uint64_t out_ch_layout=AV_CH_LAYOUT_STEREO;

    swr_alloc_set_opts(swrContext,out_ch_layout,out_sample,
                       out_sample_rate,in_ch_layout,in_sample,in_sample_rate,0,NULL);

    swr_init(swrContext);
    uint8_t *out_buffer=(uint8_t *)(av_malloc(2*44100));
    FILE *fp_pcm=fopen(output,"wb");
    AVPacket *packet=av_packet_alloc();
    while(av_read_frame(pFormat,packet)>=0) {
        avcodec_send_packet(codecContext,packet);
        //解压缩数据
        AVFrame *frame=av_frame_alloc();
        int ret=avcodec_receive_frame(codecContext,frame);
        if(ret==AVERROR(EAGAIN)) {
            continue;
        } else if(ret<0) {
            qDebug()<<"解码完成！";
            break;
        }
        if(packet->stream_index!=audio_stream_idx) {
            continue;
        }
        swr_convert(swrContext,&out_buffer,2*44100,(const uint8_t **)frame->data,frame->nb_samples);
        int out_channerl_nb=av_get_channel_layout_nb_channels(out_ch_layout);
        int out_buffer_size=av_samples_get_buffer_size(NULL,out_channerl_nb,frame->nb_samples,out_sample,1);
        fwrite(out_buffer,1,out_buffer_size,fp_pcm);
    }

    return true;
}
