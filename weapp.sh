#! /bin/bash
# set -o nounset
set -o errexit

send=`date '+%Y-%m-%d %H:%M'`
Author=${1}

echo "小程序主文件夹名："
read rootName
echo "名为${rootName}的小程序创建成功
==============================================
"
myPages=()
echo "输入预制的页面：(index,log默认存在，空格隔开，不加后缀，回车生成)"
read -a myPages

thPage="\"pages\": [
		\"pages/index/index\",
		\"pages/log/log\""

for item in ${myPages[@]}
do
	thPage="${thPage},
		\"pages/${item}/${item}\""
done

# 默认的文件目录，没卵用
defaultPages=(index log)

myPagesLen=${#myPages[@]}
defaultPagesLen=${#defaultPages[@]}

# 创建 主文件夹
if [ ! -d "${rootName}" ]; then
  mkdir ${rootName}
fi

cd ${rootName}

# 创建 app.json
echo "{
	${thPage}
	],
	\"window\": {
		\"navigationBarTextStyle\": \"\",
		\"navigationBarTitleText\": \"\",
		\"navigationBarBackgroundColor\": \"\",
		\"backgroundColor\": \"\"
	},
	\"networkTimeout\": {
		\"request\": 20000,
		\"connectSocket\": 20000,
		\"uploadFile\": 20000,
		\"downloadFile\": 20000
	},
	\"debug\": true
}" > app.json

# 创建 app.wxss
echo '/**app.wxss**/

.container {
	height: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: space-between;
	padding: 200rpx 0;
	box-sizing: border-box;
} ' > app.wxss

# 创建 app.js
echo "/****
  * ${send} By ${Author}
  * app.js
  */

App({
	onLaunch: function () {
		//调用API从本地缓存中获取数据
		var logs = wx.getStorageSync('logs') || []
		logs.unshift(Date.now())
		wx.setStorageSync('logs', logs)
	},
	getUserInfo: function (cb) {
		var that = this
		if (this.globalData.userInfo) {
			typeof cb == 'function' && cb(this.globalData.userInfo)
		} else {
			//调用登录接口
			wx.login({
				success: function () {
					wx.getUserInfo({
						success: function (res) {
							that.globalData.userInfo = res.userInfo
							typeof cb == 'function' && cb(that.globalData.userInfo)
						}
					})
				}
			})
		}
	},
	globalData: {
		userInfo: null
	}
})" > app.js

# 创建 utils
if [ ! -d "utils" ]; then
  mkdir utils
fi

cd utils
echo "/****
  * ${send} By ${1}
  * util.js
  */
  
function formatTime(date) {
	var year = date.getFullYear()
	var month = date.getMonth() + 1
	var day = date.getDate()

	var hour = date.getHours()
	var minute = date.getMinutes()
	var second = date.getSeconds()


	return [year, month, day].map(formatNumber).join('/') + ' ' + [hour, minute, second].map(formatNumber).join(':')
}

function formatNumber(n) {
	n = n.toString()
	return n[1] ? n : '0' + n
}

module.exports = {
	formatTime: formatTime
}" > util.js

cd ..

if [ ! -d "pages" ]; then
  mkdir pages
fi

echo "
==============================================
 😊 index目录创建成功
 😊 logs目录创建成功"
cd pages

for PagePath in ${myPages[@]}
do
  echo " 😊 ${PagePath}目录创建成功"
  if [ ! -d ${PagePath} ]; then
    mkdir ${PagePath}
  fi

  cd ${PagePath}
echo "/****
	* ${send} By ${1}
	* ${PagePath}.js
	*/

Page({
	data: {
	},
	onLoad: function () {
		console.log('${PagePath} Load Success');
	}
})" > ${PagePath}.js

echo "<!--${PagePath}.wxml-->" > ${PagePath}.wxml

echo "/****
	* ${send} By ${1}
	* ${PagePath}.wxss
	*/" > ${PagePath}.wxss

echo "{}" > ${PagePath}.json

cd ..

done

# index start
if [ ! -d "index" ]; then
  mkdir index
fi
cd index
echo "/****
	* ${send} By ${1}
	* index.js
	*/

var app = getApp()
Page({
    data: {
        motto: 'Hello World',
        userInfo: {}
    },
    //事件处理函数
    bindViewTap: function() {
        wx.navigateTo({
            url: '../logs/logs'
        })
    },
    onLoad: function() {
        console.log('onLoad')
        var that = this
        //调用应用实例的方法获取全局数据
        app.getUserInfo(function(userInfo) {
            //更新数据
            that.setData({
                userInfo: userInfo
            })
        })
    }
})" > index.js

echo '<!--index.wxml-->
<view class="container">Ï
	<view bindtap="bindViewTap" class="userinfo">
		<image class="userinfo-avatar" src="{{userInfo.avatarUrl}}" background-size="cover"></image>
		<text class="userinfo-nickname">{{userInfo.nickName}}</text>
	</view>
	<view class="usermotto">
		<text class="user-motto">{{motto}}</text>
	</view>
</view>' > index.wxml

echo "/****
	* ${send} By ${1}
	* index.wxss
	*/

.userinfo {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.userinfo-avatar {
	width: 128rpx;
	height: 128rpx;
	margin: 20rpx;
	border-radius: 50%;
}

.userinfo-nickname {
	color: #aaa;
}

.usermotto {
	margin-top: 200px;
}" > index.wxss

cd ..
# index end

# logs start
if [ ! -d "logs" ]; then
  mkdir logs
fi
cd logs

echo "/****
	* ${send} By ${1}
	* logs.js
	*/

var util = require('../../utils/util.js')
Page({
	data: {
		logs: []
	},
	onLoad: function () {
		this.setData({
			logs: (wx.getStorageSync('logs') || []).map(function (log) {
				return util.formatTime(new Date(log))
			})
		})
	}
})" > logs.js

echo '<!--logs.wxml-->
<view class="container log-list">
	<block wx:for="{{logs}}" wx:for-item="log" wx:key="*this">
		<text class="log-item">{{index + 1}}. {{log}}</text>
	</block>
</view>' > logs.wxml

echo "/****
	* ${send} By ${1}
	* logs.wxss
	*/

.log-list {
	display: flex;
	flex-direction: column;
	padding: 40rpx;
}
.log-item {
	margin: 10rpx;
}
" > logs.wxss

echo '{
	"navigationBarTitleText": "查看启动日志"
}' > logs.json

cd ..
# logs end

# 退回项目根目录
cd ..

# 放图片文件夹
if [ ! -d "images" ]; then
  mkdir images
fi

# 放字体和 iconfonts 的文件夹
# 不建议放中文字体
if [ ! -d "fonts" ]; then
  mkdir fonts
fi

# 结束
echo "
==============================================
"