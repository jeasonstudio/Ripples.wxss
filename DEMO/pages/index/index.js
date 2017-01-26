//获取应用实例
let app = getApp()
Page({
	data: {
		expData: [],
		showName: ''
	},
	showThis: function (e) {
		let arr = this.data.expData
		let that = this
		for (let i in arr) {
			if (arr[i].name == e.currentTarget.id) {
				that.setData({
					showName: arr[i].name
				})
				setTimeout(function () {
					that.setData({
						showName: ''
					})
				}, 2000)
			}
		}
	},

	initData: function () {
		let v = [{"name":"bounce"},
		{"name":"flash"},
		{"name":"pulse"},
		{"name":"rubberBand"},
		{"name":"shake"},
		{"name":"headShake"},
		{"name":"swing"},
		{"name":"tada"},
		{"name":"wobble"},
		{"name":"jello"},
		{"name":"bounceIn"},
		{"name":"bounceInDown"},
		{"name":"bounceInLeft"},
		{"name":"bounceInRight"},
		{"name":"bounceInUp"},
		{"name":"bounceOut"},
		{"name":"bounceOutDown"},
		{"name":"bounceOutLeft"},
		{"name":"bounceOutRight"},
		{"name":"bounceOutUp"},
		{"name":"fadeIn"},
		{"name":"fadeInDown"},
		{"name":"fadeInDownBig"},
		{"name":"fadeInLeft"},
		{"name":"fadeInLeftBig"},
		{"name":"fadeInRight"},
		{"name":"fadeInRightBig"},
		{"name":"fadeInUp"},
		{"name":"fadeInUpBig"},
		{"name":"fadeOut"},
		{"name":"fadeOutDown"},
		{"name":"fadeOutDownBig"},
		{"name":"fadeOutLeft"},
		{"name":"fadeOutLeftBig"},
		{"name":"fadeOutRight"},
		{"name":"fadeOutRightBig"},
		{"name":"fadeOutUp"},
		{"name":"fadeOutUpBig"},
		{"name":"flipInX"},
		{"name":"flipInY"},
		{"name":"flipOutX"},
		{"name":"flipOutY"},
		{"name":"lightSpeedIn"},
		{"name":"lightSpeedOut"},
		{"name":"rotateIn"},
		{"name":"rotateInDownLeft"},
		{"name":"rotateInDownRight"},
		{"name":"rotateInUpLeft"},
		{"name":"rotateInUpRight"},
		{"name":"rotateOut"},
		{"name":"rotateOutDownLeft"},
		{"name":"rotateOutDownRight"},
		{"name":"rotateOutUpLeft"},
		{"name":"rotateOutUpRight"},
		{"name":"hinge"},
		{"name":"rollIn"},
		{"name":"rollOut"},
		{"name":"zoomIn"},
		{"name":"zoomInDown"},
		{"name":"zoomInLeft"},
		{"name":"zoomInRight"},
		{"name":"zoomInUp"},
		{"name":"zoomOut"},
		{"name":"zoomOutDown"},
		{"name":"zoomOutLeft"},
		{"name":"zoomOutRight"},
		{"name":"zoomOutUp"},
		{"name":"slideInDown"},
		{"name":"slideInLeft"},
		{"name":"slideInRight"},
		{"name":"slideInUp"},
		{"name":"slideOutDown"},
		{"name":"slideOutLeft"},
		{"name":"slideOutRight"},
		{"name":"slideOutUp"}]
		this.setData({
			expData: v
		})
	},
	onLoad: function () {
		console.log('onLoad')
		this.initData()
	},
})