// miniprogram/app.js
App({
  onLaunch: function () {
    // 1. 判断是否支持云开发（新版基础库都支持）
    if (!wx.cloud) {
      console.error('请使用 2.2.3 或以上的基础库以使用云能力')
    } else {
      // 2. 初始化云开发，环境ID就是刚才创建的 cloud1
      wx.cloud.init({
        // env 参数说明：
        //   env 决定你的小程序数据存到哪个云环境
        //   这里一定要和云开发控制台里的环境名一致！
        env: 'cloud1',
        // traceUser 设置为 true 会在云函数调用时记录用户信息
        traceUser: true,
      })
    }

    // 3. 获取用户手机信息等逻辑后面再写，这里先留空
  }
})