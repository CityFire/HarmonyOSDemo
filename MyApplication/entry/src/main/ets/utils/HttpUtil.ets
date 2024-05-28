import http from '@ohos.net.http'
import data from '@ohos.telephony.data';
import connection from '@ohos.net.connection';
import socket from '@ohos.net.socket';
// 每一个httpRequest对应一个HTTP请求任务，不可复用
let httpRequest = http.createHttp();
// 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
// 从API 8开始，使用on('headersReceive', Callback)替代on('headerReceive', AsyncCallback)。 8+
httpRequest.on('headersReceive', (header) => {
  console.info('header: ' + JSON.stringify(header));
});
httpRequest.request(
  // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
  "EXAMPLE_URL",
  {
    method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
    // 开发者根据自身业务需要添加header字段
    header: {
      'Content-Type': 'application/json'
    },
    // 当使用POST请求时此字段用于传递内容
    extraData: {
      "data": "data to send",
    },
    expectDataType: http.HttpDataType.STRING, // 可选，指定返回数据的类型
    usingCache: true, // 可选，默认为true
    priority: 1, // 可选，默认为1
    connectTimeout: 60000, // 可选，默认为60000ms
    readTimeout: 60000, // 可选，默认为60000ms
    usingProtocol: http.HttpProtocol.HTTP1_1, // 可选，协议类型默认值由系统自动指定
  }, (err, data) => {
     if (!err) {
       // data.result为HTTP响应内容，可根据业务需要进行解析
       console.info('Result:' + JSON.stringify(data.result));
       console.info('code:' + JSON.stringify(data.responseCode));
       // data.header为HTTP响应头，可根据业务需要进行解析
       console.info('header:' + JSON.stringify(data.header));
       console.info('cookies:' + JSON.stringify(data.cookies)); // 8+
       // 取消订阅HTTP响应头事件
       httpRequest.off('headersReceive');
       // 当该请求使用完毕时，调用destroy方法主动销毁
       httpRequest.destroy();
     } else {
       console.info('error:' + JSON.stringify(err));
       // 取消订阅HTTP响应头事件
       httpRequest.off('headersReceive');
       // 当该请求使用完毕时，调用destroy方法主动销毁。
       httpRequest.destroy();
     }
  }
)


httpRequest.request("EXAMPLE_URL", (err, data) => {
  if (!err) {
    console.info('Result:' + data.result);
    console.info('code:' + data.responseCode);
    console.info('header:' + JSON.stringify(data.header));
    console.info('cookies:' + data.cookies); // 8+
  } else {
    console.info('error:' + JSON.stringify(err));
  }
});

let promise = httpRequest.request("EXAMPLE_URL", {
  method: http.RequestMethod.GET,
  connectTimeout: 60000,
  readTimeout: 60000,
  header: {
    'Content-Type': 'application/json'
  }
});
promise.then((data) => {
  console.info('Result:' + data.result);
  console.info('code:' + data.responseCode);
  console.info('header:' + JSON.stringify(data.header));
  console.info('cookies:' + data.cookies); // 8+
  console.info('header.Content-Type:' + data.header['Content-Type']);
  console.info('header.Status-Line:' + data.header['Status-Line']);
}).catch((err) => {
  console.info('error:' + JSON.stringify(err));
});

httpRequest.once('headersReceive', (header) => {
  console.info('header: ' + JSON.stringify(header));
})

let httpResponseCache = http.createHttpResponseCache();
httpResponseCache.flush(err => {
  if (err) {
    console.info('flush fail');
    return;
  }
  console.info('flush success');
});

httpResponseCache.flush().then(() => {
  console.info('flush success');
}).catch(err => {
  console.info('flush fail');
})

httpResponseCache.delete(err => {
  if (err) {
    console.info('delete fail');
    return;
  }
  console.info('delete success');
});

httpResponseCache.delete().then(() => {
  console.info('delete success');
}).catch(err => {
  console.info('delete fail');
});

// 网络连接管理
// 关注默认网络
let netConnection = connection.createNetConnection()

// 关注蜂窝网络
let netConnectionCellular = connection.createNetConnection({
  netCapabilities: {
    bearerTypes: [connection.NetBearType.BEARER_CELLULAR]
  }
})

// 获取默认激活的数据网络，使用callback方式作为异步方法。
connection.getDefaultNet(function (error, data) {
  console.log(JSON.stringify(error))
  console.log(JSON.stringify(data))
})

// 获取默认激活的数据网络，使用Promise方式作为异步方法。
connection.getDefaultNet().then(function (data) {
  console.log(JSON.stringify(data))
})

let netHandle = connection.getDefaultNetSync();

// 获取App绑定的网络信息，使用callback方式作为异步方法。
connection.getAppNet(function(error, data) {
  console.log(JSON.stringify(error))
  console.log(JSON.stringify(data))
})

connection.getAppNet().then((data) => {
  console.info(JSON.stringify(data));
}).catch(error => {
  console.info(JSON.stringify(error));
})

connection.getDefaultNet(function (error, netHandle) {
  connection.setAppNet(netHandle, (error, data) => {
    console.log(JSON.stringify(error))
    console.log(JSON.stringify(data))
  });
})

connection.getDefaultNet().then(function (netHandle) {
  connection.setAppNet(netHandle).then((data) => {
    console.log(JSON.stringify(data))
  }).catch(error => {
    console.log(JSON.stringify(error))
  })
})


connection.getAllNets(function (error, data) {
  console.log(JSON.stringify(error))
  console.log(JSON.stringify(data))
})

connection.getAllNets().then(function (data) {
  console.log(JSON.stringify(data))
});

connection.getDefaultNet().then(function (netHandle) {
  connection.getConnectionProperties(netHandle, function (error, data) {
    console.log(JSON.stringify(error))
    console.log(JSON.stringify(data))
  })
})

connection.getDefaultNet().then(function (netHandle) {
  connection.getConnectionProperties(netHandle).then(function (data) {
    console.log(JSON.stringify(data))
  })
})

connection.getDefaultNet().then(function (netHandle) {
  connection.getNetCapabilities(netHandle, function (error, data) {
    console.log(JSON.stringify(error))
    console.log(JSON.stringify(data))
  })
})

connection.getDefaultNet().then(function (netHandle) {
  connection.getNetCapabilities(netHandle).then(function (data) {
    console.log(JSON.stringify(data))
  })
})



let host = "xxxx";
connection.getAddressesByName(host, function (error, data) {
  console.log(JSON.stringify(error))
  console.log(JSON.stringify(data))
})

connection.getAddressesByName(host).then(function (data) {
  console.log(JSON.stringify(data))
})

netConnection.register(function (error) {
  console.log(JSON.stringify(error))
})

netConnection.unregister(function (error) {
  console.log(JSON.stringify(error))
})

// 创建NetConnection对象
let netCon = connection.createNetConnection()

// 先使用register接口注册订阅事件
netCon.register(function (error) {
  console.log(JSON.stringify(error))
})

// 订阅网络可用事件。调用register后，才能接收到此事件通知
netCon.on('netAvailable', function (data) {
  console.log(JSON.stringify(data))
})

// 订阅网络阻塞状态事件。调用register后，才能接收到此事件通知
netCon.on('netBlockStatusChange', function (data) {
  console.log(JSON.stringify(data))
})

// 订阅网络能力变化事件。调用register后，才能接收到此事件通知
netCon.on('netCapabilitiesChange', function (data) {
  console.log(JSON.stringify(data))
})

// 订阅网络连接信息变化事件。调用register后，才能接收到此事件通知
netCon.on('netConnectionPropertiesChange', function (data) {
  console.log(JSON.stringify(data))
})

// 订阅网络丢失事件。调用register后，才能接收到此事件通知
netCon.on('netLost', function (data) {
  console.log(JSON.stringify(data))
})

// 订阅网络不可用事件。调用register后，才能接收到此事件通知
netCon.on('netUnavailable', function (data) {
  console.log(JSON.stringify(data))
})

// 使用unregister接口取消订阅
netCon.unregister(function (error) {
  console.log(JSON.stringify(error))
})

connection.getDefaultNet().then((netHandle) => {
  var tcp = socket.constructTCPSocketInstance();
  var udp = socket.constructTCPSocketInstance();
  let socketType = "TCPSocket";
  if (socketType == "TCPSocket") {
    tcp.bind({
      address: '192.168.0.1', port: 8080, family: 1
    }, error => {
      if (error) {
        console.log('bind fail');
      }
      netHandle.bindSocket(tcp, (error, data) => {
        if (error) {
          console.log(JSON.stringify(error));
        } else {
          console.log(JSON.stringify(data));
        }
      })
    })
  } else {
    let callback = value => {
      console.log("on message, message:" + value.message + ", remoteInfo:" + value.remoteInfo);
    }
    udp.on('message', callback);
    udp.bind({
      address: '192.168.0.1', port: 8080, family: 1
    }, error => {
      if (error) {
        console.log('bind fail');
      }
      udp.on('message', (data) => {
        console.log(JSON.stringify(data))
      });
      netHandle.bindSocket(udp, (error, data) => {
        if (error) {
          console.log(JSON.stringify(error));
        } else {
          console.log(JSON.stringify(data));
        }
      })
    })
  }
})

connection.getDefaultNet().then((netHandle) => {
  var tcp = socket.constructTCPSocketInstance();
  var udp = socket.constructUDPSocketInstance();
  let socketType = "TCPSocket";
  if (socketType == "TCPSocket") {
    tcp.bind({
      address: '192.168.xx.xxx', port: 8080, family: 1
    }, error => {
      if (error) {
        console.log('bind fail');
      }
      netHandle.bindSocket(tcp).then((data) => {
        console.log(JSON.stringify(data));
      }).catch(error => {
        console.log(JSON.stringify(error));
      })
    })
  } else {
    let callback = value => {
      console.log("on message, message:" + value.message + ", remoteInfo:" + value.remoteInfo);
    }
    udp.on('message', callback);
    udp.bind({
      address: '192.168.xx.xxx', port: 8080, family: 1
    }, error => {
      if (error) {
        console.log('bind fail');
      }
      udp.on('message', (data) => {
        console.log(JSON.stringify(data));
      })
      netHandle.bindSocket(udp).then((data) => {
        console.log(JSON.stringify(data));
      }).catch(error => {
        console.log(JSON.stringify(error));
      })
    })
  }
})

connection.getDefaultNet().then(function (netHandle) {
  let host = "xxxx";
  netHandle.getAddressesByName(host, function (error, data) {
    console.log(JSON.stringify(error))
    console.log(JSON.stringify(data))
  })
})

connection.getDefaultNet().then(function (netHandle) {
  let host = "xxxx";
  netHandle.getAddressesByName(host).then(function (data) {
    console.log(JSON.stringify(data))
  })
})

connection.getDefaultNet().then(function (netHandle) {
  let host = "xxxx";
  netHandle.getAddressByName(host, function (error, data) {
    console.log(JSON.stringify(error))
    console.log(JSON.stringify(data))
  })
})

connection.getDefaultNet().then(function (netHandle) {
  let host = "xxxx";
  netHandle.getAddressByName(host).then(function (data) {
    console.log(JSON.stringify(data))
  })
})
