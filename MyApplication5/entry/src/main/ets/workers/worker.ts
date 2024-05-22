import worker from '@ohos.worker'
let parent = worker.workerPort;

// 处理来自主线程的消息
parent.onmessage = function(message) {
  console.info("onmessage: " + message);
  // 发送消息到主线程
  parent.postMessage("message from worker thread.")
}