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

let udp = socket.constructUDPSocketInstance();
udp.bind({address: '192.168.1.1', port: 8888, family: 1}, err => {
  if (err) {
    console.log('bind fail');
    return;
  }
  console.log('bind success');
  udp.getState((err, data) => {
    if (err) {
      console.log('getState fail');
      return;
    }
    console.log('getState success:' + JSON.stringify(data));
  })
  let promise = udp.getState();
  promise.then(data => {
    console.log('getState success:' + JSON.stringify(data));
  }).catch(err => {
    console.log('getState fail');
  });
})

let promise1 = udp.bind({address: '192.168.1.1', port: 8080, family: 1});
promise1.then(() => {
  console.log('bind success');
  let promise1 = udp.setExtraOptions({
    receiveBufferSize:1000,
    sendBufferSize:1000,
    reuseAddress:false,
    socketTimeout:6000,
    broadcast:true
  });
  promise1.then(() => {
    console.log('setExtraOptions success');
  }).catch(err => {
    console.log('setExtraOptions fail');
  });
}).catch(err => {
  console.log('bind fail');
});

udp.send({
  data: 'Hello, server!',
  address: {
    address: '192.168.1.1',
    port: 8888,
    family: 1
  }
}, err => {
  if (err) {
    console.log('send fail');
    return;
  }
  console.log('send success');
})

let promise2 = udp.send({
  data:'Hello, server!',
  address: {
    address:'192.168.xx.xxx',
    port:8888,
    family:1
  }
});
promise2.then(() => {
  console.log('send success');
}).catch(err => {
  console.log('send fail');
});

udp.on('message', value => {
  console.log("on message, message:" + value.message + ", remoteInfo:" + value.remoteInfo);
});

// let callback = value => {
//   console.log("on message, message:" + value.message + ", remoteInfo:" + value.remoteInfo);
// }
// udp.on('message', callback);
// // 可以指定传入on中的callback取消一个订阅，也可以不指定callback清空所有订阅。
// udp.off('message', callback);
udp.off('message');

udp.on('listening', () => {
  console.log("on listening success");
});
udp.on('close', () => {
  console.log("on close success" );
});

let callback1 = () =>{
  console.log("on listening, success");
}
udp.on('listening', callback1);
// 可以指定传入on中的callback取消一个订阅，也可以不指定callback清空所有订阅。
udp.off('listening', callback1);
udp.off('listening');
let callback2 = () =>{
  console.log("on close, success");
}
udp.on('close', callback2);
// 可以指定传入on中的callback取消一个订阅，也可以不指定callback清空所有订阅。
udp.off('close', callback2);
udp.off('close');

udp.on('error', err => {
  console.log("on error, err:" + JSON.stringify(err))
});

let callback = err =>{
  console.log("on error, err:" + JSON.stringify(err));
}
udp.on('error', callback);
// 可以指定传入on中的callback取消一个订阅，也可以不指定callback清空所有订阅。
udp.off('error', callback);
udp.off('error');

udp.close(err => {
  if (err) {
    console.log('close fail');
    return;
  }
  console.log('close success');
})

let udp2 = socket.constructUDPSocketInstance();
let promise22 = udp2.close();
promise22.then(() => {
  console.log('close success');
}).catch(err => {
  console.log('close fail');
});


let tcp = socket.constructTCPSocketInstance();
tcp.bind({ address: '192.168.xx.xxx', port: 8888, family: 1 }, err => {
  if (err) {
    console.log('bind fail');
    return;
  }
  console.log('bind success');
})

let promise_ = tcp.bind({ address: '192.168.xx.xxx', port: 8888, family: 1 });
promise_.then(() => {
  console.log('bind success');
}).catch(err => {
  console.log('bind fail');
});

tcp.connect({ address: { address: '192.168.xx.xxx', port: 8888, family: 1 } , timeout: 6000}, err => {
  if (err) {
    console.log('connect fail');
    return;
  }
  console.log('connect success');
})

let _promise = tcp.connect({ address: {address: '192.168.xx.xxx', port: 8888, family: 1} , timeout: 6000});
_promise.then(() => {
  console.log('connect success')
}).catch(err => {
  console.log('connect fail');
});

let _promise_ = tcp.connect({ address: {address: '192.168.xx.xxx', port: 8888, family: 1} , timeout: 6000});
_promise_.then(() => {
  console.log('connect success');
  tcp.send({
    data:'Hello, server!'
  },err => {
    if (err) {
      console.log('send fail');
      return;
    }
    console.log('send success');
  })
}).catch(err => {
  console.log('connect fail');
});


let promise11 = tcp.connect({ address: {address: '192.168.xx.xxx', port: 8888, family: 1} , timeout: 6000});
promise11.then(() => {
  console.log('connect success');
  tcp.getState((err, data) => {
    if (err) {
      console.log('getState fail');
      return;
    }
    console.log('getState success:' + JSON.stringify(data));
  });
  let promise1 = tcp.getState();
  promise1.then(() => {
    console.log('getState success');
  }).catch(err => {
    console.log('getState fail');
  });
  tcp.getRemoteAddress((err, data) => {
    if (err) {
      console.log('getRemoteAddressfail');
      return;
    }
    console.log('getRemoteAddresssuccess:' + JSON.stringify(data));
  })
  let promise11 = tcp.getRemoteAddress();
  promise11.then(() => {
    console.log('getRemoteAddress success');
  }).catch(err => {
    console.log('getRemoteAddress fail');
  });
  let promise22 = tcp.send({
    data:'Hello, server!'
  });
  promise22.then(() => {
    console.log('send success');
  }).catch(err => {
    console.log('send fail');
  });
}).catch(err => {
  console.log('connect fail');
});

tcp.close(err => {
  if (err) {
    console.log('close fail');
    return;
  }
  console.log('close success');
})

let promise__ = tcp.close();
promise__.then(() => {
  console.log('close success');
}).catch(err => {
  console.log('close fail');
});


let tcp_ = socket.constructTCPSocketInstance();
let promise1_ = tcp.connect({ address: {address: '192.168.xx.xxx', port: 9999, family: 1} , timeout: 6000});
promise1_.then(() => {
  console.log('connect success');
  tcp_.setExtraOptions({
    keepAlive: true,
    OOBInline: true,
    TCPNoDelay: true,
    socketLinger: { on: true, linger: 10 },
    receiveBufferSize: 1000,
    sendBufferSize: 1000,
    reuseAddress: true,
    socketTimeout: 3000,
  }, err => {
    if (err) {
      console.log('setExtraOptions fail');
      return;
    }
    console.log('setExtraOptions success');
  })

  let promise1 = tcp.setExtraOptions({
    keepAlive: true,
    OOBInline: true,
    TCPNoDelay: true,
    socketLinger: { on:true, linger:10 },
    receiveBufferSize: 1000,
    sendBufferSize: 1000,
    reuseAddress: true,
    socketTimeout: 3000,
  });
  promise1.then(() => {
    console.log('setExtraOptions success');
  }).catch(err => {
    console.log('setExtraOptions fail');
  });

}).catch(err => {
  console.log('connect fail');
});

tcp_.on('message', value => {
  console.log("on message, message:" + value.message + ", remoteInfo:" + value.remoteInfo)
});

let callback_ = value => {
  console.log("on message, message:" + value.message + ", remoteInfo:" + value.remoteInfo)
}
tcp_.on('message', callback_);
// 可以指定传入on中的callback取消一个订阅，也可以不指定callback清空所有订阅。
tcp_.off('message', callback);
tcp_.off('message');

tcp_.on('connect', () => {
  console.log("on connect success")
});
tcp_.off('close', data => {
  console.log("on close success")
});

let callback1_ = () =>{
  console.log("on connect success");
}
tcp_.on('connect', callback1_);
// 可以指定传入on中的callback取消一个订阅，也可以不指定callback清空所有订阅。
tcp_.off('connect', callback1);
tcp_.off('connect');
let callback2_ = () =>{
  console.log("on close success");
}
tcp_.on('close', callback2_);
// 可以指定传入on中的callback取消一个订阅，也可以不指定callback清空所有订阅。
tcp_.off('close', callback2_);
tcp_.off('close');

tcp_.on('error', err => {
  console.log("on error, err:" + JSON.stringify(err))
});

let _callback = err =>{
  console.log("on error, err:" + JSON.stringify(err));
}
tcp_.on('error', _callback);
// 可以指定传入on中的callback取消一个订阅，也可以不指定callback清空所有订阅。
tcp_.off('error', _callback);
tcp_.off('error');


let tls = socket.constructTLSSocketInstance();
tls.bind({address: '192.168.xx.xxx', port: 8888, family: 1}, err => {
  if (err) {
    console.log('bind fail');
    return;
  }
  console.log('bind success');
});

let promise_tls = tls.bind({address: '192.168.xx.xxx', port: 8888, family: 1});
promise_tls.then(() => {
  console.log('bind success');
}).catch(err => {
  console.log('bind fail');
});

let promise_tls_ = tls.bind({address: '192.168.xx.xxx', port: 8888, family: 1}, err => {
  if (err) {
    console.log('bind fail');
    return;
  }
  console.log('bind success');
});

tls.getState((err, data) => {
  if (err) {
    console.log('getState fail');
    return;
  }
  console.log('getState success:' + JSON.stringify(data));
})

let promise_tls1 = tls.getState();
promise_tls1.then(() => {
  console.log('getState success');
}).catch(err => {
  console.log('getState fail');
});

tls.getRemoteAddress((err, data) => {
  if (err) {
    console.log('getRemoteAddress fail');
    return;
  }
  console.log('getRemoteAddress success:' + JSON.stringify(data));
})

let promise_remote = tls.getRemoteAddress();
promise_remote.then(() => {
  console.log('getRemoteAddress success');
}).catch(err => {
  console.log('getRemoteAddress fail');
});

tls.getCertificate((err, data) => {
  if (err) {
    console.log("getCertificate callback error = " + err);
  } else {
    console.log("getCertificate callback = " + data);
  }
});

tls.getCertificate().then(data => {
  console.log("getCertificate promise = " + data);
}).catch(err => {
  console.error(err);
});

// 在TLSSocket通信连接成功之后，获取服务端的数字证书，使用callback方式作为异步方法。
tls.getRemoteCertificate((err, data) => {
  if (err) {
    console.log("getRemoteCertificate callback error = " + err);
  } else {
    console.log("getRemoteCertificate callback = " + data);
  }
});

tls.getRemoteCertificate().then(data => {
  console.log("getRemoteCertificate promise = " + data);
}).catch(err => {
  console.error(err);
});

tls.getProtocol((err, data) => {
  if (err) {
    console.log("getProtocol callback error = " + err);
  } else {
    console.log("getProtocol callback = " + data);
  }
});

tls.getProtocol().then(data => {
  console.log(data);
}).catch(err => {
  console.error(err);
});

tls.setExtraOptions({
  keepAlive: true,
  OOBInline: true,
  TCPNoDelay: true,
  socketLinger: { on: true, linger: 10 },
  receiveBufferSize: 1000,
  sendBufferSize: 1000,
  reuseAddress: true,
  socketTimeout: 3000,
}, err => {
  if (err) {
    console.log('setExtraOptions fail');
    return;
  }
  console.log('setExtraOptions success');
})

let tls_promise = tls.setExtraOptions({
  keepAlive: true,
  OOBInline: true,
  TCPNoDelay: true,
  socketLinger: { on:true, linger:10 },
  receiveBufferSize: 1000,
  sendBufferSize: 1000,
  reuseAddress: true,
  socketTimeout: 3000,
});
tls_promise.then(() => {
  console.log('setExtraOptions success');
}).catch(err => {
  console.log('setExtraOptions fail');
});


let tlsTwoWay = socket.constructTLSSocketInstance(); // Two way authentication
tlsTwoWay.bind({address: '192.168.xxx.xxx', port: 8080, family: 1}, err => {
  if (err) {
    console.log('bind fail');
    return;
  }
  console.log('bind success');
});

let options = {
  ALPNProtocols: ["spdy/1", "http/1.1"],
  address: {
    address: "192.168.xx.xxx",
    port: 8080,
    family: 1,
  },
  secureOptions: { // TLS安全相关操作，其中ca证书为必选参数，其他参数为可选参数。当本地证书cert和私钥key不为空时，开启双向验证模式。cert和key其中一项为空时，开启单向验证模式。
    key: "xxxx", // 本地数字证书的私钥。
    cert: "xxxx", // 本地客户端的数字证书。
    ca: ["xxxx"], // 服务端的ca证书，用于认证校验服务端的数字证书。
    password: "xxxx", // 读取私钥的密码。
    protocols: [socket.Protocol.TLSv12], // TLS的协议版本。
    useRemoteCipherPrefer: true, // 优先使用对等方的密码套件。
    signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256", // 通信过程中的签名算法。
    cipherSuite: "AES256-SHA256", // 通信过程中的加密套件。
  },
};
tlsTwoWay.connect(options, (err, data) => {
  console.error("connect callback error"+err);
  console.log(JSON.stringify(data));
});

let tlsOneWay = socket.constructTLSSocketInstance(); // One way authentication
tlsOneWay.bind({address: '192.168.xxx.xxx', port: 8080, family: 1}, err => {
  if (err) {
    console.log('bind fail');
    return;
  }
  console.log('bind success');
});
let oneWayOptions = {
  address: {
    address: "192.168.xxx.xxx",
    port: 8080,
    family: 1,
  },
  secureOptions: {
    ca: ["xxxx","xxxx"],
    cipherSuite: "AES256-SHA256",
  },
};
tlsOneWay.connect(oneWayOptions, (err, data) => {
  console.error("connect callback error"+err);
  console.log(JSON.stringify(data));
});

tls.getCipherSuite((err, data) => {
  if (err) {
    console.log("getCipherSuite callback error = " + err);
  } else {
    console.log("getCipherSuite callback = " + data);
  }
});

// 在TLSSocket通信连接成功之后，获取通信双方协商后的加密套件，使用Promise方式作为异步方法。
tls.getCipherSuite().then(data => {
  console.log('getCipherSuite success:' + JSON.stringify(data));
}).catch(err => {
  console.error(err);
});

// 在TLSSocket通信连接成功之后，获取通信双方协商后签名算法，该接口只适配双向认证模式下，使用callback方式作为异步方法。
tls.getSignatureAlgorithms((err, data) => {
  if (err) {
    console.log("getSignatureAlgorithms callback error = " + err);
  } else {
    console.log("getSignatureAlgorithms callback = " + data);
  }
});

tls.getSignatureAlgorithms().then(data => {
  console.log("getSignatureAlgorithms success" + data);
}).catch(err => {
  console.error(err);
});

tls.send("xxxx", (err) => {
  if (err) {
    console.log("send callback error = " + err);
  } else {
    console.log("send success");
  }
});

tls.send("xxxx").then(() =>{
  console.log("send success");
}).catch(err => {
  console.error(err);
});

tls.close((err) => {
  if (err) {
    console.log("close callback error = " + err);
  } else {
    console.log("close success");
  }
});

tls.close().then(() =>{
  console.log("close success");
}).catch(err => {
  console.error(err);
});
























