USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_basic_GetPinYin]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_basic_GetPinYin]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_basic_GetPinYin]
(
	@Str NVARCHAR(100),
	@Abbr TINYINT,
	@SkipRegion TINYINT
)
RETURNS VARCHAR(8000)
AS
BEGIN
	DECLARE @Re NVARCHAR(MAX), @Crs NVARCHAR(10);
	DECLARE @StrLen INT;
	DECLARE @tRe NVARCHAR(20);
	SELECT @StrLen = LEN(@Str), @Re = '', @tRe = '';
	DECLARE @StrAbbr NVARCHAR(2048);
	SET @StrAbbr = N'';
	
	WHILE @StrLen > 0
	BEGIN	
		SET @Crs = SUBSTRING(@Str, @StrLen, 1);
		SET @tRe= (CASE
		WHEN @SkipRegion = 1 AND @Crs = N'ʡ' THEN '' 
		WHEN @SkipRegion = 1 AND @Crs = N'��' THEN '' 
		WHEN @SkipRegion = 1 AND @Crs = N'��' THEN '' 
		WHEN @SkipRegion = 1 AND @Crs = N'��' THEN '' 
        WHEN @Crs<'߹' THEN @Crs 
        WHEN @Crs<='��' THEN 'A'
        WHEN @Crs<='�a' THEN 'Ai'
        WHEN @Crs<='��' THEN 'An'
        WHEN @Crs<='�l' THEN 'Ang'
        WHEN @Crs<='�' THEN 'Ao'
        WHEN @Crs<='��' THEN 'Ba'
        WHEN @Crs<='�B' THEN 'Bai'
        WHEN @Crs<='��' THEN 'Ban'
        WHEN @Crs<='�^' THEN 'Bang'
        WHEN @Crs<='�t' THEN 'Bao'
        WHEN @Crs<='��' THEN 'Bei'
        WHEN @Crs<='ݙ' THEN 'Ben'
        WHEN @Crs<='�a' THEN 'Beng'
        WHEN @Crs<='��' THEN 'Bi'
        WHEN @Crs<='׃' THEN 'Bian'
        WHEN @Crs<='�B' THEN 'Biao'
        WHEN @Crs<='��' THEN 'Bie'
        WHEN @Crs<='�W' THEN 'Bin'
        WHEN @Crs<='�h' THEN 'Bing'
        WHEN @Crs<='�N' THEN 'Bo'
        WHEN @Crs<='��' THEN 'Bu'
        WHEN @Crs<='��' THEN 'Ca'
        WHEN @Crs<='�k' THEN 'Cai'
        WHEN @Crs<='�|' THEN 'Can'
        WHEN @Crs<='ى' THEN 'Cang'
        WHEN @Crs<='��' THEN 'Cao'
        WHEN @Crs<='�u' THEN 'Ce'
        WHEN @Crs<='��' THEN 'Cen'
        WHEN @Crs<='�u' THEN 'Ceng'
        WHEN @Crs<='Ԍ' THEN 'Cha'
        WHEN @Crs<='��' THEN 'Chai'
        WHEN @Crs<='�' THEN 'Chan'
        WHEN @Crs<='�o' THEN 'Chang'
        WHEN @Crs<='�e' THEN 'Chao'
        WHEN @Crs<='��' THEN 'Che'
        WHEN @Crs<='׏' THEN 'Chen'
        WHEN @Crs<='��' THEN 'Cheng'
        WHEN @Crs<='�u' THEN 'Chi'
        WHEN @Crs<='�|' THEN 'Chong'
        WHEN @Crs<='��' THEN 'Chou'
        WHEN @Crs<='��' THEN 'Chu'
        WHEN @Crs<='��' THEN 'Chuai'
        WHEN @Crs<='�E' THEN 'Chuan'
        WHEN @Crs<='��' THEN 'Chuang'
        WHEN @Crs<='�q' THEN 'Chui'
        WHEN @Crs<='��' THEN 'Chun'
        WHEN @Crs<='�W' THEN 'Chuo'
        WHEN @Crs<='��' THEN 'Ci'
        WHEN @Crs<='ց' THEN 'Cong'
        WHEN @Crs<='ݏ' THEN 'Cou'
        WHEN @Crs<='�' THEN 'Cu'
        WHEN @Crs<='��' THEN 'Cuan'
        WHEN @Crs<='ě' THEN 'Cui'
        WHEN @Crs<='�v' THEN 'Cun'
        WHEN @Crs<='�e' THEN 'Cuo'
        WHEN @Crs<='�\' THEN 'Da'
        WHEN @Crs<='�^' THEN 'Dai'
        WHEN @Crs<='��' THEN 'Dan'
        WHEN @Crs<='�W' THEN 'Dang'
        WHEN @Crs<='��' THEN 'Dao'
        WHEN @Crs<='��' THEN 'De'
        WHEN @Crs<='�Y' THEN 'Den'
        WHEN @Crs<='�' THEN 'Deng'
        WHEN @Crs<='�E' THEN 'Di'
        WHEN @Crs<='��' THEN 'Dia'
        WHEN @Crs<='�' THEN 'Dian'
        WHEN @Crs<='�S' THEN 'Diao'
        WHEN @Crs<='��' THEN 'Die'
        WHEN @Crs<='�r' THEN 'Ding'
        WHEN @Crs<='�A' THEN 'Diu'
        WHEN @Crs<='�' THEN 'Dong'
        WHEN @Crs<='�a' THEN 'Dou'
        WHEN @Crs<='�' THEN 'Du'
        WHEN @Crs<='��' THEN 'Duan'
        WHEN @Crs<='�m' THEN 'Dui'
        WHEN @Crs<='�v' THEN 'Dun'
        WHEN @Crs<='�z' THEN 'Duo'
        WHEN @Crs<='�{' THEN 'E'
        WHEN @Crs<='��' THEN 'En'
        WHEN @Crs<='�E' THEN 'Eng'
        WHEN @Crs<='��' THEN 'Er'
        WHEN @Crs<='�' THEN 'Fa'
        WHEN @Crs<='�~' THEN 'Fan'
        WHEN @Crs<='��' THEN 'Fang'
        WHEN @Crs<='�]' THEN 'Fei'
        WHEN @Crs<='�a' THEN 'Fen'
        WHEN @Crs<='҅' THEN 'Feng'
        WHEN @Crs<='��' THEN 'Fo'
        WHEN @Crs<='�]' THEN 'Fou'
        WHEN @Crs<='�g' THEN 'Fu'
        WHEN @Crs<='�p' THEN 'Ga'
        WHEN @Crs<='�y' THEN 'Gai'
        WHEN @Crs<='��' THEN 'Gan'
        WHEN @Crs<='��' THEN 'Gang'
        WHEN @Crs<='�' THEN 'Gao'
        WHEN @Crs<='��' THEN 'Ge'
        WHEN @Crs<='�o' THEN 'Gei'
        WHEN @Crs<='�j' THEN 'Gen'
        WHEN @Crs<='��' THEN 'Geng'
        WHEN @Crs<='��' THEN 'Gong'
        WHEN @Crs<='ُ' THEN 'Gou'
        WHEN @Crs<='�' THEN 'Gu'
        WHEN @Crs<='ԟ' THEN 'Gua'
        WHEN @Crs<='�s' THEN 'Guai'
        WHEN @Crs<='�}' THEN 'Guan'
        WHEN @Crs<='��' THEN 'Guang'
        WHEN @Crs<='�i' THEN 'Gui'
        WHEN @Crs<='֏' THEN 'Gun'
        WHEN @Crs<='�B' THEN 'Guo'
        WHEN @Crs<='��' THEN 'Ha'
        WHEN @Crs<='��' THEN 'Hai'
        WHEN @Crs<='�[' THEN 'Han'
        WHEN @Crs<='��' THEN 'Hang'
        WHEN @Crs<='��' THEN 'Hao'
        WHEN @Crs<='�g' THEN 'He'
        WHEN @Crs<='��' THEN 'Hei'
        WHEN @Crs<='��' THEN 'Hen'
        WHEN @Crs<='��' THEN 'Heng'
        WHEN @Crs<='�\' THEN 'Hong'
        WHEN @Crs<='�c' THEN 'Hou'
        WHEN @Crs<='�I' THEN 'Hu'
        WHEN @Crs<='�s' THEN 'Hua'
        WHEN @Crs<='�|' THEN 'Huai'
        WHEN @Crs<='�d' THEN 'Huan'
        WHEN @Crs<='�w' THEN 'Huang'
        WHEN @Crs<='�' THEN 'Hui'
        WHEN @Crs<='՟' THEN 'Hun'
        WHEN @Crs<='��' THEN 'Huo'
        WHEN @Crs<='�K' THEN 'Ji'
        WHEN @Crs<='��' THEN 'Jia'
        WHEN @Crs<='�' THEN 'Jian'
        WHEN @Crs<='֘' THEN 'Jiang'
        WHEN @Crs<='�' THEN 'Jiao'
        WHEN @Crs<='�T' THEN 'Jie'
        WHEN @Crs<='��' THEN 'Jin'
        WHEN @Crs<='��' THEN 'Jing'
        WHEN @Crs<='�W' THEN 'Jiong'
        WHEN @Crs<='��' THEN 'Jiu'
        WHEN @Crs<='��' THEN 'Ju'
        WHEN @Crs<='�\' THEN 'Juan'
        WHEN @Crs<='�' THEN 'Jue'
        WHEN @Crs<='�h' THEN 'Jun'
        WHEN @Crs<='�l' THEN 'Ka'
        WHEN @Crs<='�f' THEN 'Kai'
        WHEN @Crs<='��' THEN 'Kan'
        WHEN @Crs<='�`' THEN 'Kang'
        WHEN @Crs<='��' THEN 'Kao'
        WHEN @Crs<='�S' THEN 'Ke'
        WHEN @Crs<='�y' THEN 'Ken'
        WHEN @Crs<='�H' THEN 'Keng'
        WHEN @Crs<='�W' THEN 'Kong'
        WHEN @Crs<='�d' THEN 'Kou'
        WHEN @Crs<='��' THEN 'Ku'
        WHEN @Crs<='�g' THEN 'Kua'
        WHEN @Crs<='�d' THEN 'Kuai'
        WHEN @Crs<='�U' THEN 'Kuan'
        WHEN @Crs<='�k' THEN 'Kuang'
        WHEN @Crs<='�^' THEN 'Kui'
        WHEN @Crs<='��' THEN 'Kun'
        WHEN @Crs<='�i' THEN 'Kuo'
        WHEN @Crs<='�B' THEN 'La'
        WHEN @Crs<='�[' THEN 'Lai'
        WHEN @Crs<='�h' THEN 'Lan'
        WHEN @Crs<='�}' THEN 'Lang'
        WHEN @Crs<='�~' THEN 'Lao'
        WHEN @Crs<='�E' THEN 'Le'
        WHEN @Crs<='Ú' THEN 'Lei'
        WHEN @Crs<='��' THEN 'Leng'
        WHEN @Crs<='��' THEN 'Li'
        WHEN @Crs<='�z' THEN 'Lia'
        WHEN @Crs<='�~' THEN 'Lian'
        WHEN @Crs<='�y' THEN 'Liang'
        WHEN @Crs<='�t' THEN 'Liao'
        WHEN @Crs<='�v' THEN 'Lie'
        WHEN @Crs<='�`' THEN 'Lin'
        WHEN @Crs<='��' THEN 'Ling'
        WHEN @Crs<='��' THEN 'Liu'
        WHEN @Crs<='�L' THEN 'Long'
        WHEN @Crs<='�U' THEN 'Lou'
        WHEN @Crs<='�' THEN 'Lu'
        WHEN @Crs<='�r' THEN 'Lv'
        WHEN @Crs<='�y' THEN 'Luan'
        WHEN @Crs<='�^' THEN 'Lue'
        WHEN @Crs<='Փ' THEN 'Lun'
        WHEN @Crs<='�w' THEN 'Luo'
        WHEN @Crs<='��' THEN 'Ma'
        WHEN @Crs<='�A' THEN 'Mai'
        WHEN @Crs<='�p' THEN 'Man'
        WHEN @Crs<='ϑ' THEN 'Mang'
        WHEN @Crs<='�x' THEN 'Mao'
        WHEN @Crs<='�Z' THEN 'Me'
        WHEN @Crs<='��' THEN 'Mei'
        WHEN @Crs<='��' THEN 'Men'
        WHEN @Crs<='�D' THEN 'Meng'
        WHEN @Crs<='�]' THEN 'Mi'
        WHEN @Crs<='�I' THEN 'Mian'
        WHEN @Crs<='�R' THEN 'Miao'
        WHEN @Crs<='�x' THEN 'Mie'
        WHEN @Crs<='��' THEN 'Min'
        WHEN @Crs<='Ԛ' THEN 'Ming'
        WHEN @Crs<='և' THEN 'Miu'
        WHEN @Crs<='��' THEN 'Mo'
        WHEN @Crs<='�E' THEN 'Mou'
        WHEN @Crs<='��' THEN 'Mu'
        WHEN @Crs<='��' THEN 'Na'
        WHEN @Crs<='�r' THEN 'Nai'
        WHEN @Crs<='�R' THEN 'Nan'
        WHEN @Crs<='�Q' THEN 'Nang'
        WHEN @Crs<='Ğ' THEN 'Nao'
        WHEN @Crs<='��' THEN 'Ne'
        WHEN @Crs<='��' THEN 'Nei'
        WHEN @Crs<='��' THEN 'Nen'
        WHEN @Crs<='��' THEN 'Neng'
        WHEN @Crs<='��' THEN 'Ni'
        WHEN @Crs<='ň' THEN 'Nian'
        WHEN @Crs<='�' THEN 'Niang'
        WHEN @Crs<='��' THEN 'Niao'
        WHEN @Crs<='�' THEN 'Nie'
        WHEN @Crs<='��' THEN 'Nin'
        WHEN @Crs<='��' THEN 'Ning'
        WHEN @Crs<='�' THEN 'Niu'
        WHEN @Crs<='�P' THEN 'Nong'
        WHEN @Crs<='�k' THEN 'Nou'
        WHEN @Crs<='�x' THEN 'Nu'
        WHEN @Crs<='��' THEN 'Nv'
        WHEN @Crs<='��' THEN 'Nue'
        WHEN @Crs<='�\' THEN 'Nuan'
        WHEN @Crs<='��' THEN 'Nuo'
        WHEN @Crs<='�M' THEN 'O'
        WHEN @Crs<='�a' THEN 'Ou'
        WHEN @Crs<='В' THEN 'Pa'
        WHEN @Crs<='�s' THEN 'Pai'
        WHEN @Crs<='�' THEN 'Pan'
        WHEN @Crs<='��' THEN 'Pang'
        WHEN @Crs<='�^' THEN 'Pao'
        WHEN @Crs<='�\' THEN 'Pei'
        WHEN @Crs<='��' THEN 'Pen'
        WHEN @Crs<='��' THEN 'Peng'
        WHEN @Crs<='�G' THEN 'Pi'
        WHEN @Crs<='�_' THEN 'Pian'
        WHEN @Crs<='�G' THEN 'Piao'
        WHEN @Crs<='��' THEN 'Pie'
        WHEN @Crs<='Ƹ' THEN 'Pin'
        WHEN @Crs<='�O' THEN 'Ping'
        WHEN @Crs<='��' THEN 'Po'
        WHEN @Crs<='�R' THEN 'Pou'
        WHEN @Crs<='��' THEN 'Pu'
        WHEN @Crs<='τ' THEN 'Qi'
        WHEN @Crs<='��' THEN 'Qia'
        WHEN @Crs<='�y' THEN 'Qian'
        WHEN @Crs<='��' THEN 'Qiang'
        WHEN @Crs<='�N' THEN 'Qiao'
        WHEN @Crs<='�]' THEN 'Qie'
        WHEN @Crs<='�C' THEN 'Qin'
        WHEN @Crs<='��' THEN 'Qing'
        WHEN @Crs<='��' THEN 'Qiong'
        WHEN @Crs<='��' THEN 'Qiu'
        WHEN @Crs<='�Y' THEN 'Qu'
        WHEN @Crs<='��' THEN 'Quan'
        WHEN @Crs<='�]' THEN 'Que'
        WHEN @Crs<='��' THEN 'Qun'
        WHEN @Crs<='�L' THEN 'Ran'
        WHEN @Crs<='׌' THEN 'Rang'
        WHEN @Crs<='�@' THEN 'Rao'
        WHEN @Crs<='��' THEN 'Re'
        WHEN @Crs<='�' THEN 'Ren'
        WHEN @Crs<='�' THEN 'Reng'
        WHEN @Crs<='�_' THEN 'Ri'
        WHEN @Crs<='�\' THEN 'Rong'
        WHEN @Crs<='�]' THEN 'Rou'
        WHEN @Crs<='�J' THEN 'Ru'
        WHEN @Crs<='�O' THEN 'Ruan'
        WHEN @Crs<='��' THEN 'Rui'
        WHEN @Crs<='��' THEN 'Run'
        WHEN @Crs<='�U' THEN 'Ruo'
        WHEN @Crs<='��' THEN 'Sa'
        WHEN @Crs<='̃' THEN 'Sai'
        WHEN @Crs<='�d' THEN 'San'
        WHEN @Crs<='��' THEN 'Sang'
        WHEN @Crs<='�' THEN 'Sao'
        WHEN @Crs<='�o' THEN 'Se'
        WHEN @Crs<='�d' THEN 'Sen'
        WHEN @Crs<='�L' THEN 'Seng'
        WHEN @Crs<='��' THEN 'Sha'
        WHEN @Crs<='��' THEN 'Shai'
        WHEN @Crs<='�X' THEN 'Shan'
        WHEN @Crs<='�y' THEN 'Shang'
        WHEN @Crs<='��' THEN 'Shao'
        WHEN @Crs<='��' THEN 'She'
        WHEN @Crs<='��' THEN 'Shen'
        WHEN @Crs<='ً' THEN 'Sheng'
        WHEN @Crs<='��' THEN 'Shi'
        WHEN @Crs<='�' THEN 'Shou'
        WHEN @Crs<='̠' THEN 'Shu'
        WHEN @Crs<='�X' THEN 'Shua'
        WHEN @Crs<='�i' THEN 'Shuai'
        WHEN @Crs<='�Y' THEN 'Shuan'
        WHEN @Crs<='��' THEN 'Shuang'
        WHEN @Crs<='˯' THEN 'Shui'
        WHEN @Crs<='�B' THEN 'Shun'
        WHEN @Crs<='�p' THEN 'Shuo'
        WHEN @Crs<='�r' THEN 'Si'
        WHEN @Crs<='�' THEN 'Song'
        WHEN @Crs<='��' THEN 'Sou'
        WHEN @Crs<='��' THEN 'Su'
        WHEN @Crs<='��' THEN 'Suan'
        WHEN @Crs<='�' THEN 'Sui'
        WHEN @Crs<='��' THEN 'Sun'
        WHEN @Crs<='�R' THEN 'Suo'
        WHEN @Crs<='�k' THEN 'Ta'
        WHEN @Crs<='�M' THEN 'Tai'
        WHEN @Crs<='�y' THEN 'Tan'
        WHEN @Crs<='�C' THEN 'Tang'
        WHEN @Crs<='�z' THEN 'Tao'
        WHEN @Crs<='�c' THEN 'Te'
        WHEN @Crs<='�Y' THEN 'Teng'
        WHEN @Crs<='ڌ' THEN 'Ti'
        WHEN @Crs<='�q' THEN 'Tian'
        WHEN @Crs<='�g' THEN 'Tiao'
        WHEN @Crs<='��' THEN 'Tie'
        WHEN @Crs<='�h' THEN 'Ting'
        WHEN @Crs<='�q' THEN 'Tong'
        WHEN @Crs<='͸' THEN 'Tou'
        WHEN @Crs<='�r' THEN 'Tu'
        WHEN @Crs<='щ' THEN 'Tuan'
        WHEN @Crs<='�D' THEN 'Tui'
        WHEN @Crs<='�d' THEN 'Tun'
        WHEN @Crs<='�X' THEN 'Tuo'
        WHEN @Crs<='�' THEN 'Wa'
        WHEN @Crs<='�' THEN 'Wai'
        WHEN @Crs<='�@' THEN 'Wan'
        WHEN @Crs<='�R' THEN 'Wang'
        WHEN @Crs<='�^' THEN 'Wei'
        WHEN @Crs<='�' THEN 'Wen'
        WHEN @Crs<='�N' THEN 'Weng'
        WHEN @Crs<='�}' THEN 'Wo'
        WHEN @Crs<='�F' THEN 'Wu'
        WHEN @Crs<='�a' THEN 'Xi'
        WHEN @Crs<='�]' THEN 'Xia'
        WHEN @Crs<='�E' THEN 'Xian'
        WHEN @Crs<='�P' THEN 'Xiang'
        WHEN @Crs<='��' THEN 'Xiao'
        WHEN @Crs<='��' THEN 'Xie'
        WHEN @Crs<='�' THEN 'Xin'
        WHEN @Crs<='�B' THEN 'Xing'
        WHEN @Crs<='��' THEN 'Xiong'
        WHEN @Crs<='�M' THEN 'Xiu'
        WHEN @Crs<='ޣ' THEN 'Xu'
        WHEN @Crs<='�K' THEN 'Xuan'
        WHEN @Crs<='�y' THEN 'Xue'
        WHEN @Crs<='�R' THEN 'Xun'
        WHEN @Crs<='��' THEN 'Ya'
        WHEN @Crs<='��' THEN 'Yan'
        WHEN @Crs<='��' THEN 'Yang'
        WHEN @Crs<='�' THEN 'Yao'
        WHEN @Crs<='��' THEN 'Ye'
        WHEN @Crs<='�~' THEN 'Yi'
        WHEN @Crs<='��' THEN 'Yin'
        WHEN @Crs<='�G' THEN 'Ying'
        WHEN @Crs<='��' THEN 'Yo'
        WHEN @Crs<='�k' THEN 'Yong'
        WHEN @Crs<='��' THEN 'You'
        WHEN @Crs<='��' THEN 'Yu'
        WHEN @Crs<='�' THEN 'Yuan'
        WHEN @Crs<='�V' THEN 'Yue'
        WHEN @Crs<='�' THEN 'Yun'
        WHEN @Crs<='�{' THEN 'Za'
        WHEN @Crs<='�f' THEN 'Zai'
        WHEN @Crs<='�' THEN 'Zan'
        WHEN @Crs<='�K' THEN 'Zang'
        WHEN @Crs<='�^' THEN 'Zao'
        WHEN @Crs<='��' THEN 'Ze'
        WHEN @Crs<='�e' THEN 'Zei'
        WHEN @Crs<='��' THEN 'Zen'
        WHEN @Crs<='ٛ' THEN 'Zeng'
        WHEN @Crs<='�m' THEN 'Zha'
        WHEN @Crs<='�' THEN 'Zhai'
        WHEN @Crs<='�' THEN 'Zhan'
        WHEN @Crs<='�d' THEN 'Zhang'
        WHEN @Crs<='�^' THEN 'Zhao'
        WHEN @Crs<='�p' THEN 'Zhe'
        WHEN @Crs<='�l' THEN 'Zhen'
        WHEN @Crs<='�C' THEN 'Zheng'
        WHEN @Crs<='�U' THEN 'Zhi'
        WHEN @Crs<='�A' THEN 'Zhong'
        WHEN @Crs<='�E' THEN 'Zhou'
        WHEN @Crs<='�T' THEN 'Zhu'
        WHEN @Crs<='צ' THEN 'Zhua'
        WHEN @Crs<='�J' THEN 'Zhuai'
        WHEN @Crs<='�M' THEN 'Zhuan'
        WHEN @Crs<='��' THEN 'Zhuang'
        WHEN @Crs<='�V' THEN 'Zhui'
        WHEN @Crs<='��' THEN 'Zhun'
        WHEN @Crs<='�m' THEN 'Zhuo'
        WHEN @Crs<='�n' THEN 'Zi'
        WHEN @Crs<='�v' THEN 'Zong'
        WHEN @Crs<='��' THEN 'Zou'
        WHEN @Crs<='֊' THEN 'Zu'
        WHEN @Crs<='߬' THEN 'Zuan'
        WHEN @Crs<='��' THEN 'Zui'
        WHEN @Crs<='�' THEN 'Zun'
        WHEN @Crs<='��' THEN 'Zuo'
        ELSE  @Crs END);
        SET @StrLen = @StrLen - 1 ;
        
        IF LEN(@tRe) > 0
        BEGIN
			SET @Re = @tRe + ' ' + @Re;

			SET @StrAbbr = SUBSTRING(UPPER(@tRe), 1, 1) + @StrAbbr;
		END
   END
   
   IF @Abbr = 1
   BEGIN
		SET @Re = @Re + '/' + @StrAbbr;
   END
   
   RETURN (@Re);
END
GO


