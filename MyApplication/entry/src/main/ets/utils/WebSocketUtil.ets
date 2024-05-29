import webSocket from '@ohos.net.webSocket';

var defaultIpAddress = "ws://";
let ws = webSocket.createWebSocket(); // 创建一个WebSocket，里面包括建立连接、关闭连接、发送数据和订阅/取消订阅WebSocket连接的打开事件、接收到服务器消息事件、关闭事件和错误事件。
ws.on('open', (err, value) => {
  console.log("on open, status:" + value['status'] + ", message:" + value['message']);
  // 当收到on('open')事件时，可以通过send()方法与服务器进行通信
  ws.send("Hello, server!", (err, value) => {
    if (!err) {
      console.log("send success");
    } else {
      console.log("send fail, err:" + JSON.stringify(err));
    }
  });
});
ws.on('message', (err, value) => {
  console.log("on message, message:" + value);
  // 当收到服务器的`bye`消息时（此消息字段仅为示意，具体字段需要与服务器协商），主动断开连接
  if (value === 'bye') {
    ws.close((err, value) => {
      if (!err) {
        console.log("close success");
      } else {
        console.log("close fail, err is " + JSON.stringify(err));
      }
    });
  }
});
ws.on('close', (err, value) => {
  console.log("on close, code is " + value.code + ", reason is " + value.reason);
});
ws.on('error', (err) => {
  console.log("on error, error:" + JSON.stringify(err));
});
ws.connect(defaultIpAddress, (err, value) => {
  ws.send("Hello, server!", (err, value) => {
    if (!err) {
      console.log("send success");
    } else {
      console.log("send fail, err:" + JSON.stringify(err));
    }
  });
});
ws.connect(defaultIpAddress, (err, value) => {
  let promise = ws.send("Hello, server!");
  promise.then((value) => {
    console.log("send success");
  }).catch((err) => {
    console.log("send fail, error:" + JSON.stringify(err));
  });
});
// 根据URL地址和header，建立一个WebSocket连接，使用callback方式作为异步方法。
ws.connect(defaultIpAddress, {
  header: {
    "key": "value",
    "key2": "value2"
  }
}, (err, value) => {
  if (!err) {
    console.log("connect success");
  } else {
    console.log("connect fail, err:" + JSON.stringify(err))
  }
});

let promise = ws.connect(defaultIpAddress);
promise.then((value) => {
  console.log("connect success")
}).catch((err) => {
  console.log("connect fail, error:" + JSON.stringify(err))
});

ws.close((err, value) => {
  if (!err) {
    console.log("close success")
  } else {
    console.log("close fail, err is " + JSON.stringify(err))
  }
});

ws.close({
  code: 1000,
  reason: "your reason"
}, (err, value) => {
  if (!err) {
    console.log("close success")
  } else {
    console.log("close fail, err is " + JSON.stringify(err))
  }
});

let promise_ = ws.close({
  code: 1000,
  reason: "your reason"
});
promise_.then((value) => {
  console.log("close success")
}).catch((err) => {
  console.log("close fail, err is " + JSON.stringify(err))
});

let ws_ = webSocket.createWebSocket();
ws_.on('open', (err, value) => {
  console.log("on open, status:" + value['status'] + ", message:" + value['message']);
});

let callback1 = (err, value) => {
  console.log("on open, status:" + value['status'] + ", message:" + value['message']);
}
ws_.on('open', callback1);
// 可以指定传入on中的callback取消一个订阅，也可以不指定callback清空所有订阅
ws_.off('open', callback1);

ws_.on('message', (err, value) => {
  console.log("on message, message:" + value);
});

ws_.off('message');

ws_.on('close', (err, value) => {
  console.log("on close, code is " + value.code + ", reason is " + value.reason);
});

ws_.off('close');

ws_.on('error', (err) => {
  console.log("on error, error:" + JSON.stringify(err))
});

ws_.off('error');


